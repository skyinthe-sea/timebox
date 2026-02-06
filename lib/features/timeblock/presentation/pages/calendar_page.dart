import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../../../../config/routes/route_names.dart';
import '../../../../core/widgets/loading_indicator.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../focus/presentation/widgets/focus_mode_transition.dart';
import '../../../planner/presentation/bloc/planner_bloc.dart';
import '../../../task/domain/entities/tag.dart';
import '../../../task/domain/entities/task.dart';
import '../../domain/entities/time_block.dart';
import '../bloc/calendar_bloc.dart';
import '../cubit/timeline_selection_cubit.dart';
import '../cubit/timeline_selection_state.dart';
import '../widgets/brain_dump_popup.dart';
import '../widgets/two_column_timeline_grid.dart';

/// 캘린더 페이지 (타임라인)
///
/// 타임박싱의 메인 화면
/// - 2열 타임라인 그리드
/// - 롱프레스-드래그 시간 범위 선택
/// - 브레인덤프 팝업으로 태스크 할당
class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  bool _hasCheckedExpired = false;

  @override
  void initState() {
    super.initState();
    context.read<CalendarBloc>().add(WatchTimeBlocksStarted(DateTime.now()));
  }

  void _checkAndMarkExpiredBlocks(CalendarState state) {
    if (_hasCheckedExpired) return;
    if (state.status != CalendarStateStatus.success) return;
    if (state.timeBlocks.isEmpty) return;

    // 만료된 타임블록이 있는지 확인
    final now = DateTime.now();
    final hasExpired = state.timeBlocks.any((tb) =>
        tb.endTime.isBefore(now) && tb.status == TimeBlockStatus.pending);

    if (hasExpired) {
      // 약간의 딜레이 후 실패 처리 (UI 로딩 후 애니메이션 효과)
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          context.read<CalendarBloc>().add(const MarkExpiredAsSkippedEvent());
        }
      });
    }
    _hasCheckedExpired = true;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return BlocProvider(
      create: (_) => TimelineSelectionCubit(),
      child: BlocBuilder<CalendarBloc, CalendarState>(
        builder: (context, calendarState) {
          // 페이지 로드 후 만료된 타임블록 확인
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _checkAndMarkExpiredBlocks(calendarState);
          });

          if (calendarState.status == CalendarStateStatus.loading) {
            return const LoadingIndicator();
          }

          if (calendarState.status == CalendarStateStatus.failure) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 48,
                    color: theme.colorScheme.error,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    calendarState.errorMessage ?? 'An error occurred',
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: () {
                      context.read<CalendarBloc>().add(
                            WatchTimeBlocksStarted(calendarState.selectedDate),
                          );
                    },
                    child: Text(l10n?.retry ?? 'Retry'),
                  ),
                ],
              ),
            );
          }

          return Stack(
            children: [
              Column(
                children: [
                  // 날짜 헤더 (AppBar 대체) - TimeBlock 기반 완료율 표시
                  _buildDateHeader(context, calendarState, l10n),

                  // 날짜 네비게이션
                  _buildDateNavigation(context, calendarState),

                  // 타임라인 그리드
                  Expanded(
                    child: Stack(
                      children: [
                        // 2열 타임라인 그리드
                        TwoColumnTimelineGrid(
                          date: calendarState.selectedDate,
                          timeBlocks: calendarState.timeBlocks,
                          startHour: 0,
                          endHour: 24,
                          recentlySkippedIds: calendarState.recentlySkippedIds,
                          taskPriorities: _buildTaskPriorities(context),
                          onTimeBlockTap: (tb) {
                            // TODO: 포커스 모드로 이동
                          },
                          onTimeBlockMoved: (id, newStart) {
                            context.read<CalendarBloc>().add(
                                  MoveTimeBlockEvent(
                                    id: id,
                                    newStartTime: newStart,
                                  ),
                                );
                          },
                          onTimeBlockResized: (id, newStart, newEnd) {
                            context.read<CalendarBloc>().add(
                                  ResizeTimeBlockEvent(
                                    id: id,
                                    newStartTime: newStart,
                                    newEndTime: newEnd,
                                  ),
                                );
                          },
                        ),

                        // 브레인덤프 팝업
                        BlocBuilder<TimelineSelectionCubit,
                            TimelineSelectionState>(
                          buildWhen: (prev, curr) =>
                              prev.mode != curr.mode ||
                              prev.normalizedStartSlot != curr.normalizedStartSlot ||
                              prev.normalizedEndSlot != curr.normalizedEndSlot,
                          builder: (context, selectionState) {
                            if (!selectionState.isPopupVisible) {
                              return const SizedBox.shrink();
                            }

                            return _buildBrainDumpPopup(
                              context,
                              selectionState,
                              calendarState,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // FAB - 버닝타임!
              Positioned(
                right: 16,
                bottom: 16,
                child: FloatingActionButton(
                  onPressed: () => _handleFocusFAB(context, calendarState, l10n),
                  tooltip: l10n?.focusModeTooltip ?? '버닝타임!',
                  child: const Icon(Icons.local_fire_department),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDateHeader(
    BuildContext context,
    CalendarState state,
    AppLocalizations? l10n,
  ) {
    final theme = Theme.of(context);

    // TimeBlock 기반 완료율 계산 (TimeBlock이 있을 때만)
    final completionPercentage = state.timeBlocks.isNotEmpty
        ? (state.completionRate * 100).toInt()
        : null;

    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          // 왼쪽 여백
          const Expanded(child: SizedBox()),
          // 날짜 (중앙)
          GestureDetector(
            onTap: () => _showDatePicker(context, state.selectedDate),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _formatDate(state.selectedDate, l10n),
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
          // 오른쪽: 완료율 + Today 버튼
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // 완료율 표시 (TimeBlock이 있을 때만)
                if (completionPercentage != null)
                  Text(
                    '$completionPercentage%',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                if (!state.isToday)
                  IconButton(
                    icon: const Icon(Icons.today),
                    tooltip: l10n?.today ?? 'Today',
                    onPressed: () {
                      context.read<CalendarBloc>().add(const GoToToday());
                    },
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateNavigation(BuildContext context, CalendarState state) {
    final theme = Theme.of(context);

    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        border: Border(
          bottom: BorderSide(
            color: theme.colorScheme.outlineVariant,
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: () {
              final newDate = state.selectedDate.subtract(const Duration(days: 1));
              context.read<CalendarBloc>().add(DateChanged(newDate));
              // PlannerBloc 날짜도 동기화
              context.read<PlannerBloc>().add(PlannerDateChanged(newDate));
            },
          ),
          Text(
            _getRelativeDateText(state.selectedDate),
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: () {
              final newDate = state.selectedDate.add(const Duration(days: 1));
              context.read<CalendarBloc>().add(DateChanged(newDate));
              // PlannerBloc 날짜도 동기화
              context.read<PlannerBloc>().add(PlannerDateChanged(newDate));
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBrainDumpPopup(
    BuildContext context,
    TimelineSelectionState selectionState,
    CalendarState calendarState,
  ) {
    // PlannerBloc에서 미배정 태스크 가져오기
    List<Task> unscheduledTasks = [];
    try {
      final plannerState = context.read<PlannerBloc>().state;
      // 캘린더의 선택된 날짜와 일치하는 태스크만 필터링
      final selectedDate = calendarState.selectedDate;
      unscheduledTasks = plannerState.unscheduledTasks.where((task) {
        return task.targetDate.year == selectedDate.year &&
            task.targetDate.month == selectedDate.month &&
            task.targetDate.day == selectedDate.day;
      }).toList();
    } catch (_) {
      // PlannerBloc이 없는 경우 빈 목록
    }

    return BrainDumpPopup(
      key: ValueKey('popup_${selectionState.normalizedStartSlot}_${selectionState.normalizedEndSlot}'),
      unscheduledTasks: unscheduledTasks,
      selectionState: selectionState,
      onTaskSelected: (task, startTime, endTime, tags) {
        _assignTaskToTimeBlock(
          context,
          task: task,
          startTime: startTime,
          endTime: endTime,
          tags: tags,
        );
      },
      onNewTaskCreated: (title, startTime, endTime, tags) {
        _createNewTaskAndTimeBlock(
          context,
          title: title,
          startTime: startTime,
          endTime: endTime,
          tags: tags,
        );
      },
      onCancel: () {
        context.read<TimelineSelectionCubit>().cancelSelection();
      },
    );
  }

  void _assignTaskToTimeBlock(
    BuildContext context, {
    required Task task,
    required DateTime startTime,
    required DateTime endTime,
    List<Tag> tags = const [],
  }) {
    // 첫 번째 태그의 색상 사용 (태그가 없으면 null)
    final colorValue = tags.isNotEmpty ? tags.first.color.toARGB32() : null;

    // 태그가 선택되었으면 Task에도 태그 업데이트
    if (tags.isNotEmpty) {
      try {
        context.read<PlannerBloc>().add(UpdateTaskTags(
              taskId: task.id,
              tags: tags,
            ));
      } catch (_) {
        // PlannerBloc이 없는 경우 무시
      }
    }

    // TimeBlock 생성
    context.read<CalendarBloc>().add(
          CreateTimeBlockEvent(
            taskId: task.id,
            title: task.title,
            startTime: startTime,
            endTime: endTime,
            colorValue: colorValue,
          ),
        );

    // 선택 상태 초기화
    context.read<TimelineSelectionCubit>().completeAssignment();

    // 성공 메시지
    _showSuccessSnackBar(context);
  }

  void _createNewTaskAndTimeBlock(
    BuildContext context, {
    required String title,
    required DateTime startTime,
    required DateTime endTime,
    List<Tag> tags = const [],
  }) {
    final taskId = const Uuid().v4();

    // 첫 번째 태그의 색상 사용 (태그가 없으면 null)
    final colorValue = tags.isNotEmpty ? tags.first.color.toARGB32() : null;

    // 새 태스크 생성 (PlannerBloc 통해)
    try {
      final duration = endTime.difference(startTime);
      context.read<PlannerBloc>().add(QuickCreateTask(
            taskId: taskId,
            title: title,
            estimatedDuration: duration,
            tags: tags,
          ));
    } catch (_) {
      // PlannerBloc이 없는 경우 무시
    }

    // TimeBlock 생성 (taskId 연결)
    context.read<CalendarBloc>().add(
          CreateTimeBlockEvent(
            taskId: taskId,
            title: title,
            startTime: startTime,
            endTime: endTime,
            colorValue: colorValue,
          ),
        );

    // 선택 상태 초기화
    context.read<TimelineSelectionCubit>().completeAssignment();

    // 성공 메시지
    _showSuccessSnackBar(context);
  }

  void _showSuccessSnackBar(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n?.taskAssigned ?? 'Task assigned'),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _showDatePicker(
    BuildContext context,
    DateTime currentDate,
  ) async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null && context.mounted) {
      context.read<CalendarBloc>().add(DateChanged(selectedDate));
      // PlannerBloc 날짜도 동기화
      context.read<PlannerBloc>().add(PlannerDateChanged(selectedDate));
    }
  }

  String _formatDate(DateTime date, AppLocalizations? l10n) {
    final formatter = DateFormat.MMMd();
    return formatter.format(date);
  }

  String _getRelativeDateText(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final selectedDay = DateTime(date.year, date.month, date.day);
    final difference = selectedDay.difference(today).inDays;

    if (difference == 0) return 'Today';
    if (difference == 1) return 'Tomorrow';
    if (difference == -1) return 'Yesterday';

    return DateFormat.EEEE().format(date);
  }

  /// FAB 클릭 시 집중 모드 처리
  void _handleFocusFAB(
    BuildContext context,
    CalendarState calendarState,
    AppLocalizations? l10n,
  ) {
    final currentBlock = calendarState.currentTimeBlock;

    if (currentBlock != null) {
      // 현재 진행 중인 타임블록이 있으면 집중 모드로 전환
      _navigateToFocusWithAnimation(context, currentBlock);
    } else {
      // 타임블록이 없으면 안내 메시지 표시
      _showNoTimeBlockMessage(context, l10n);
    }
  }

  /// 애니메이션과 함께 집중 모드로 이동
  void _navigateToFocusWithAnimation(
    BuildContext context,
    TimeBlock timeBlock,
  ) {
    // 연결된 Task의 제목 찾기
    String? taskTitle;
    try {
      final plannerState = context.read<PlannerBloc>().state;
      if (timeBlock.taskId != null) {
        final task = plannerState.tasks.firstWhere(
          (t) => t.id == timeBlock.taskId,
        );
        taskTitle = task.title;
      }
    } catch (_) {
      // PlannerBloc이 없거나 Task를 찾을 수 없는 경우
    }

    Navigator.of(context).push(
      FocusModePageRoute(
        timeBlock: timeBlock,
        taskTitle: taskTitle ?? timeBlock.title,
      ),
    );
  }

  /// 진행 중인 타임블록이 없을 때 안내 메시지 표시
  void _showNoTimeBlockMessage(BuildContext context, AppLocalizations? l10n) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n?.noActiveTimeBlock ?? '진행 중인 타임블록이 없습니다',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              l10n?.createTimeBlockFirst ?? '캘린더에서 타임블록을 먼저 생성하세요',
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: l10n?.quickStart ?? '빠른 시작',
          onPressed: () {
            // 빠른 시작 - 타임블록 없이 집중 모드로 이동
            context.push(RouteNames.focus);
          },
        ),
      ),
    );
  }

  /// Task ID별 우선순위 맵 생성
  ///
  /// DailyPriority의 Top 3 Task는 high/medium/low 순위로 강조
  /// 그 외 Task는 자체 priority 사용
  Map<String, TaskPriority> _buildTaskPriorities(BuildContext context) {
    try {
      final plannerState = context.read<PlannerBloc>().state;
      final priorities = <String, TaskPriority>{};

      // DailyPriority의 Top 3 Task에 우선순위 부여
      final dailyPriority = plannerState.dailyPriority;
      if (dailyPriority != null) {
        if (dailyPriority.rank1TaskId != null) {
          priorities[dailyPriority.rank1TaskId!] = TaskPriority.high;
        }
        if (dailyPriority.rank2TaskId != null) {
          priorities[dailyPriority.rank2TaskId!] = TaskPriority.medium;
        }
        if (dailyPriority.rank3TaskId != null) {
          priorities[dailyPriority.rank3TaskId!] = TaskPriority.low;
        }
      }

      // Top 3에 없는 Task는 자체 priority 사용 (high만 강조)
      for (final task in plannerState.tasks) {
        if (!priorities.containsKey(task.id) && task.priority == TaskPriority.high) {
          priorities[task.id] = TaskPriority.high;
        }
      }

      return priorities;
    } catch (_) {
      return {};
    }
  }
}
