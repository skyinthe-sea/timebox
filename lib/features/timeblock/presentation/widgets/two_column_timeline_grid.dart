import 'package:flutter/material.dart' hide SelectionOverlay;
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../../core/utils/date_time_utils.dart';
import '../../../task/domain/entities/task.dart';
import '../../domain/entities/time_block.dart';
import '../bloc/calendar_bloc.dart';
import '../cubit/timeline_selection_cubit.dart';
import '../cubit/timeline_selection_state.dart';
import 'selection_overlay.dart';
import 'time_block_card.dart';
import 'time_range_label.dart';

/// 2열 타임라인 그리드
///
/// - 48개 슬롯 (24시간 × 2열)
/// - 롱프레스-드래그 선택 지원
/// - 타임블록 표시
/// - 우선순위별 강조 표시
class TwoColumnTimelineGrid extends StatefulWidget {
  final DateTime date;
  final List<TimeBlock> timeBlocks;
  final int startHour;
  final int endHour;
  final void Function(TimeBlock)? onTimeBlockTap;
  final void Function(String id, DateTime newStartTime)? onTimeBlockMoved;
  final void Function(String id, DateTime newStart, DateTime newEnd)?
      onTimeBlockResized;

  /// 최근에 실패 처리된 TimeBlock ID 목록 (애니메이션용)
  final List<String> recentlySkippedIds;

  /// Task ID별 우선순위 맵 (강조 표시용)
  final Map<String, TaskPriority> taskPriorities;

  const TwoColumnTimelineGrid({
    super.key,
    required this.date,
    required this.timeBlocks,
    this.startHour = 0,
    this.endHour = 24,
    this.onTimeBlockTap,
    this.onTimeBlockMoved,
    this.onTimeBlockResized,
    this.recentlySkippedIds = const [],
    this.taskPriorities = const {},
  });

  @override
  State<TwoColumnTimelineGrid> createState() => _TwoColumnTimelineGridState();
}

class _TwoColumnTimelineGridState extends State<TwoColumnTimelineGrid> {
  late ScrollController _scrollController;
  final GlobalKey _gridKey = GlobalKey();

  /// 슬롯 높이 (30dp)
  static const double _slotHeight = 30.0;

  /// 시간 레이블 컬럼 너비
  static const double _timeColumnWidth = 50.0;

  /// 타임블록 좌우 패딩
  static const double _blockPadding = 4.0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToInitialPosition();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToInitialPosition() {
    // 오늘이면 현재 시간으로, 아니면 시작 시간으로 스크롤
    final targetHour = DateTimeUtils.isToday(widget.date)
        ? DateTime.now().hour
        : widget.startHour;

    final offset =
        ((targetHour - widget.startHour) * 2 * _slotHeight) - 100;
    _scrollController.animateTo(
      offset.clamp(0.0, _scrollController.position.maxScrollExtent),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final totalHours = widget.endHour - widget.startHour;
    final totalSlots = totalHours * 2;
    final isToday = DateTimeUtils.isToday(widget.date);

    return BlocBuilder<TimelineSelectionCubit, TimelineSelectionState>(
      builder: (context, selectionState) {
        return GestureDetector(
          onLongPressStart: (details) => _handleLongPressStart(details),
          onLongPressMoveUpdate: (details) =>
              _handleLongPressMoveUpdate(details),
          onLongPressEnd: (details) => _handleLongPressEnd(details),
          child: Stack(
            children: [
              // 메인 스크롤 영역
              SingleChildScrollView(
                controller: _scrollController,
                physics: selectionState.isSelecting
                    ? const NeverScrollableScrollPhysics()
                    : const AlwaysScrollableScrollPhysics(),
                child: SizedBox(
                  key: _gridKey,
                  height: totalSlots * _slotHeight,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 시간 레이블 컬럼
                      _buildTimeLabels(theme, totalHours),

                      // 그리드 영역
                      Expanded(
                        child: Stack(
                          children: [
                            // 배경 그리드 라인
                            _buildGridLines(theme, totalSlots, isDark),

                            // 선택 오버레이
                            if (selectionState.hasValidSelection)
                              SelectionOverlay(
                                startSlot: selectionState.normalizedStartSlot!,
                                endSlot: selectionState.normalizedEndSlot!,
                                slotHeight: _slotHeight,
                                startHour: widget.startHour,
                                isAnimating: selectionState.isAnimating,
                              ),

                            // 타임블록들
                            ...widget.timeBlocks
                                .map((tb) => _buildTimeBlockCard(tb)),

                            // 현재 시간 표시선
                            if (isToday) _buildCurrentTimeLine(theme, isDark),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // 플로팅 시간 레이블
              if (selectionState.isSelecting &&
                  selectionState.touchPosition != null)
                TimeRangeLabel(
                  startSlot: selectionState.normalizedStartSlot!,
                  endSlot: selectionState.normalizedEndSlot!,
                  position: selectionState.touchPosition!,
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTimeLabels(ThemeData theme, int totalHours) {
    return SizedBox(
      width: _timeColumnWidth,
      child: Column(
        children: List.generate(
          totalHours,
          (index) => SizedBox(
            height: _slotHeight * 2,
            child: Padding(
              padding: const EdgeInsets.only(top: 0, right: 8),
              child: Text(
                '${widget.startHour + index}:00',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.outline,
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGridLines(ThemeData theme, int totalSlots, bool isDark) {
    return Column(
      children: List.generate(
        totalSlots,
        (index) => Container(
          height: _slotHeight,
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: index % 2 == 0
                    ? theme.colorScheme.outlineVariant
                    : theme.colorScheme.outlineVariant.withValues(alpha: 0.3),
                width: index % 2 == 0 ? 0.5 : 0.5,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTimeBlockCard(TimeBlock timeBlock) {
    final startMinutesFromDayStart =
        (timeBlock.startTime.hour - widget.startHour) * 60 +
            timeBlock.startTime.minute;
    final durationMinutes =
        timeBlock.endTime.difference(timeBlock.startTime).inMinutes;

    final top = startMinutesFromDayStart * _slotHeight / 30;
    final height = durationMinutes * _slotHeight / 30;

    // 완료/실패된 블록은 스와이프 비활성화
    final isFinished = timeBlock.status == TimeBlockStatus.completed ||
        timeBlock.status == TimeBlockStatus.skipped;

    final animateToSkipped = widget.recentlySkippedIds.contains(timeBlock.id);

    // Task ID로 우선순위 조회
    final priority = timeBlock.taskId != null
        ? widget.taskPriorities[timeBlock.taskId]
        : null;

    return Positioned(
      top: top,
      left: _blockPadding,
      right: _blockPadding,
      child: isFinished
          ? TimeBlockCard(
              timeBlock: timeBlock,
              priority: priority,
              height: height.clamp(20, double.infinity),
              onTap: () => widget.onTimeBlockTap?.call(timeBlock),
              animateToSkipped: animateToSkipped,
            )
          : Dismissible(
              key: Key('dismissible_${timeBlock.id}'),
              direction: DismissDirection.horizontal,
              // 오른쪽으로 스와이프 배경 (완료)
              background: _buildSwipeBackground(
                alignment: Alignment.centerLeft,
                color: AppColors.successLight,
                icon: Icons.check_circle_outline,
                label: '완료',
              ),
              // 왼쪽으로 스와이프 배경 (삭제)
              secondaryBackground: _buildSwipeBackground(
                alignment: Alignment.centerRight,
                color: AppColors.errorLight,
                icon: Icons.delete_outline,
                label: '삭제',
              ),
              confirmDismiss: (direction) async {
                if (direction == DismissDirection.endToStart) {
                  // 왼쪽 스와이프: 삭제 확인
                  return await _showDeleteConfirmDialog(context, timeBlock);
                } else {
                  // 오른쪽 스와이프: 완료/실패 선택
                  await _showCompletionDialog(context, timeBlock);
                  return false; // Dismissible 애니메이션 취소
                }
              },
              onDismissed: (direction) {
                if (direction == DismissDirection.endToStart) {
                  // 삭제 처리
                  context.read<CalendarBloc>().add(
                        DeleteTimeBlockEvent(timeBlock.id),
                      );
                }
              },
              child: TimeBlockCard(
                timeBlock: timeBlock,
                priority: priority,
                height: height.clamp(20, double.infinity),
                onTap: () => widget.onTimeBlockTap?.call(timeBlock),
                onResizeTop: (delta) {
                  final newStart = timeBlock.startTime.add(
                      Duration(minutes: (delta / (_slotHeight / 30)).round()));
                  widget.onTimeBlockResized
                      ?.call(timeBlock.id, newStart, timeBlock.endTime);
                },
                onResizeBottom: (delta) {
                  final newEnd = timeBlock.endTime.add(
                      Duration(minutes: (delta / (_slotHeight / 30)).round()));
                  widget.onTimeBlockResized
                      ?.call(timeBlock.id, timeBlock.startTime, newEnd);
                },
                animateToSkipped: animateToSkipped,
              ),
            ),
    );
  }

  Widget _buildSwipeBackground({
    required Alignment alignment,
    required Color color,
    required IconData icon,
    required String label,
  }) {
    return Container(
      alignment: alignment,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (alignment == Alignment.centerRight) ...[
            Text(
              label,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
            const SizedBox(width: 4),
          ],
          Icon(icon, color: color, size: 20),
          if (alignment == Alignment.centerLeft) ...[
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Future<bool?> _showDeleteConfirmDialog(
    BuildContext context,
    TimeBlock timeBlock,
  ) async {
    return showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('타임블록 삭제'),
        content: Text(
          '${timeBlock.title ?? "이 타임블록"}을(를) 삭제하시겠습니까?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('취소'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.errorLight,
            ),
            child: const Text('삭제'),
          ),
        ],
      ),
    );
  }

  Future<void> _showCompletionDialog(
    BuildContext context,
    TimeBlock timeBlock,
  ) async {
    final bloc = context.read<CalendarBloc>();

    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 핸들
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 20),
                // 제목
                Text(
                  '타임블록 결과',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  timeBlock.title ?? '제목 없음',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                ),
                const SizedBox(height: 24),
                // 버튼들
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          bloc.add(UpdateTimeBlockStatusEvent(
                            id: timeBlock.id,
                            status: TimeBlockStatus.skipped,
                          ));
                          Navigator.pop(ctx);
                          _showResultSnackBar(context, false);
                        },
                        icon: const Icon(Icons.cancel_outlined),
                        label: const Text('미완료'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.errorLight,
                          side: BorderSide(color: AppColors.errorLight),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: () {
                          bloc.add(UpdateTimeBlockStatusEvent(
                            id: timeBlock.id,
                            status: TimeBlockStatus.completed,
                          ));
                          Navigator.pop(ctx);
                          _showResultSnackBar(context, true);
                        },
                        icon: const Icon(Icons.check_circle_outline),
                        label: const Text('완료'),
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.successLight,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showResultSnackBar(BuildContext context, bool isCompleted) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              isCompleted ? Icons.check_circle : Icons.cancel,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(isCompleted ? '완료 처리되었습니다' : '미완료 처리되었습니다'),
          ],
        ),
        backgroundColor: isCompleted ? AppColors.successLight : AppColors.errorLight,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Widget _buildCurrentTimeLine(ThemeData theme, bool isDark) {
    final now = DateTime.now();
    final minutesFromDayStart =
        (now.hour - widget.startHour) * 60 + now.minute;
    final top = minutesFromDayStart * _slotHeight / 30;

    return Positioned(
      top: top,
      left: 0,
      right: 0,
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: isDark ? AppColors.errorDark : AppColors.errorLight,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Container(
              height: 2,
              color: isDark ? AppColors.errorDark : AppColors.errorLight,
            ),
          ),
        ],
      ),
    );
  }

  void _handleLongPressStart(LongPressStartDetails details) {
    final cubit = context.read<TimelineSelectionCubit>();
    final yPosition = _getYPositionInContent(details.globalPosition);
    if (yPosition == null) return;

    final slotIndex = TimelineSelectionCubit.yPositionToSlot(
      yPosition,
      startHour: widget.startHour,
    );

    cubit.startSelection(
      slotIndex: slotIndex,
      date: widget.date,
      touchPosition: details.globalPosition,
    );
  }

  void _handleLongPressMoveUpdate(LongPressMoveUpdateDetails details) {
    final cubit = context.read<TimelineSelectionCubit>();
    final yPosition = _getYPositionInContent(details.globalPosition);
    if (yPosition == null) return;

    final slotIndex = TimelineSelectionCubit.yPositionToSlot(
      yPosition,
      startHour: widget.startHour,
    );

    cubit.updateSelection(
      slotIndex: slotIndex,
      touchPosition: details.globalPosition,
    );

    // 화면 가장자리에서 자동 스크롤
    _handleAutoScroll(details.globalPosition);
  }

  void _handleLongPressEnd(LongPressEndDetails details) {
    final cubit = context.read<TimelineSelectionCubit>();
    cubit.finishSelection();
  }

  /// 글로벌 좌표를 스크롤 콘텐츠 내의 Y 위치로 변환
  ///
  /// GestureDetector가 SingleChildScrollView를 감싸고 있으므로,
  /// 스크롤 오프셋을 직접 더해서 콘텐츠 내 위치를 계산합니다.
  double? _getYPositionInContent(Offset globalPosition) {
    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null) return null;

    // GestureDetector(현재 위젯) 기준 로컬 좌표
    final localPosition = renderBox.globalToLocal(globalPosition);

    // 스크롤 오프셋을 더해서 콘텐츠 내 실제 Y 위치 계산
    return localPosition.dy + _scrollController.offset;
  }

  void _handleAutoScroll(Offset globalPosition) {
    final screenHeight = MediaQuery.of(context).size.height;
    const edgeThreshold = 80.0;
    const scrollSpeed = 5.0;

    if (globalPosition.dy < edgeThreshold) {
      // 위쪽 가장자리 - 위로 스크롤
      final newOffset = (_scrollController.offset - scrollSpeed)
          .clamp(0.0, _scrollController.position.maxScrollExtent);
      _scrollController.jumpTo(newOffset);
    } else if (globalPosition.dy > screenHeight - edgeThreshold) {
      // 아래쪽 가장자리 - 아래로 스크롤
      final newOffset = (_scrollController.offset + scrollSpeed)
          .clamp(0.0, _scrollController.position.maxScrollExtent);
      _scrollController.jumpTo(newOffset);
    }
  }
}
