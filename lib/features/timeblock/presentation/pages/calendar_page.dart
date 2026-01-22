import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/widgets/loading_indicator.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../planner/presentation/bloc/planner_bloc.dart';
import '../../../task/domain/entities/task.dart';
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
  @override
  void initState() {
    super.initState();
    context.read<CalendarBloc>().add(WatchTimeBlocksStarted(DateTime.now()));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return BlocProvider(
      create: (_) => TimelineSelectionCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: BlocBuilder<CalendarBloc, CalendarState>(
            buildWhen: (prev, curr) => prev.selectedDate != curr.selectedDate,
            builder: (context, state) {
              return GestureDetector(
                onTap: () => _showDatePicker(context, state.selectedDate),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(_formatDate(state.selectedDate, l10n)),
                    const Icon(Icons.arrow_drop_down),
                  ],
                ),
              );
            },
          ),
          actions: [
            // 오늘로 이동
            BlocBuilder<CalendarBloc, CalendarState>(
              buildWhen: (prev, curr) => prev.isToday != curr.isToday,
              builder: (context, state) {
                if (state.isToday) return const SizedBox.shrink();
                return IconButton(
                  icon: const Icon(Icons.today),
                  tooltip: l10n?.today ?? 'Today',
                  onPressed: () {
                    context.read<CalendarBloc>().add(const GoToToday());
                  },
                );
              },
            ),
          ],
        ),
        body: BlocBuilder<CalendarBloc, CalendarState>(
          builder: (context, calendarState) {
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

            return Column(
              children: [
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
            );
          },
        ),
      ),
    );
  }

  Widget _buildDateNavigation(BuildContext context, CalendarState state) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
              context.read<CalendarBloc>().add(
                    DateChanged(
                      state.selectedDate.subtract(const Duration(days: 1)),
                    ),
                  );
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
              context.read<CalendarBloc>().add(
                    DateChanged(
                      state.selectedDate.add(const Duration(days: 1)),
                    ),
                  );
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
      unscheduledTasks = plannerState.unscheduledTasks;
    } catch (_) {
      // PlannerBloc이 없는 경우 빈 목록
    }

    return BrainDumpPopup(
      unscheduledTasks: unscheduledTasks,
      onTaskSelected: (task, startTime, endTime) {
        _assignTaskToTimeBlock(
          context,
          task: task,
          startTime: startTime,
          endTime: endTime,
        );
      },
      onNewTaskCreated: (title, startTime, endTime) {
        _createNewTaskAndTimeBlock(
          context,
          title: title,
          startTime: startTime,
          endTime: endTime,
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
  }) {
    // TimeBlock 생성
    context.read<CalendarBloc>().add(
          CreateTimeBlockEvent(
            taskId: task.id,
            title: task.title,
            startTime: startTime,
            endTime: endTime,
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
  }) {
    // 새 태스크 생성 (PlannerBloc 통해)
    try {
      final duration = endTime.difference(startTime);
      context.read<PlannerBloc>().add(QuickCreateTask(
            title: title,
            estimatedDuration: duration,
          ));
    } catch (_) {
      // PlannerBloc이 없는 경우 무시
    }

    // TimeBlock 생성 (title만 사용, taskId 없이)
    context.read<CalendarBloc>().add(
          CreateTimeBlockEvent(
            title: title,
            startTime: startTime,
            endTime: endTime,
          ),
        );

    // 선택 상태 초기화
    context.read<TimelineSelectionCubit>().completeAssignment();

    // 성공 메시지
    _showSuccessSnackBar(context);
  }

  void _showSuccessSnackBar(BuildContext context) {
    final l10n = AppLocalizations.of(context);
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
}
