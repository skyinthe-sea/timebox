import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../task/domain/entities/task.dart';
import '../../../timeblock/domain/entities/time_block.dart';
import '../../../timeblock/presentation/widgets/time_block_card.dart';
import '../bloc/planner_bloc.dart';

/// 타임라인 드롭존 위젯
///
/// Task를 드래그하여 TimeBlock을 생성할 수 있는 타임라인 뷰
class TimelineDropZone extends StatefulWidget {
  final DateTime date;
  final List<TimeBlock> timeBlocks;
  final int startHour;
  final int endHour;
  final double hourHeight;

  const TimelineDropZone({
    super.key,
    required this.date,
    required this.timeBlocks,
    this.startHour = 6,
    this.endHour = 24,
    this.hourHeight = 60,
  });

  @override
  State<TimelineDropZone> createState() => _TimelineDropZoneState();
}

class _TimelineDropZoneState extends State<TimelineDropZone> {
  late ScrollController _scrollController;
  double? _dragPreviewTop;
  Task? _draggingTask;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToCurrentTime();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToCurrentTime() {
    if (!_isToday) return;

    final now = DateTime.now();
    if (now.hour >= widget.startHour && now.hour < widget.endHour) {
      final offset = (now.hour - widget.startHour) * widget.hourHeight - 100;
      _scrollController.animateTo(
        offset.clamp(0.0, double.infinity),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  bool get _isToday {
    final now = DateTime.now();
    return widget.date.year == now.year &&
        widget.date.month == now.month &&
        widget.date.day == now.day;
  }

  DateTime _calculateDropTime(double localY) {
    // 30분 단위로 스냅
    final totalMinutes =
        (localY / widget.hourHeight * 60).round() + widget.startHour * 60;
    final snappedMinutes = (totalMinutes / 30).round() * 30;

    return DateTime(
      widget.date.year,
      widget.date.month,
      widget.date.day,
      snappedMinutes ~/ 60,
      snappedMinutes % 60,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final totalHours = widget.endHour - widget.startHour;
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 타임라인 헤더
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            border: Border(
              bottom: BorderSide(
                color: isDark ? AppColors.borderDark : AppColors.borderLight,
              ),
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.access_time_rounded,
                size: 20,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Text(
                l10n?.timeline ?? 'Timeline',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Text(
                l10n?.dragToSchedule ?? 'Drag tasks here to schedule',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.outline,
                ),
              ),
            ],
          ),
        ),

        // 타임라인
        Expanded(
          child: DragTarget<Task>(
            onWillAcceptWithDetails: (details) {
              // 이미 타임블록이 배정된 Task는 거부
              final plannerState = context.read<PlannerBloc>().state;
              if (plannerState.isTaskScheduled(details.data.id)) {
                return false;
              }
              setState(() => _draggingTask = details.data);
              return true;
            },
            onLeave: (_) {
              setState(() {
                _draggingTask = null;
                _dragPreviewTop = null;
              });
            },
            onMove: (details) {
              // 스크롤 위치를 고려한 드롭 위치 계산
              final RenderBox? box = context.findRenderObject() as RenderBox?;
              if (box != null) {
                final localPosition = box.globalToLocal(details.offset);
                final adjustedY =
                    localPosition.dy + _scrollController.offset - 56; // 헤더 높이

                setState(() {
                  _dragPreviewTop = adjustedY;
                });
              }
            },
            onAcceptWithDetails: (details) {
              if (_dragPreviewTop != null) {
                final dropTime = _calculateDropTime(_dragPreviewTop!);
                HapticFeedback.mediumImpact();

                context.read<PlannerBloc>().add(CreateTimeBlockFromTask(
                      task: details.data,
                      startTime: dropTime,
                    ));
              }

              setState(() {
                _draggingTask = null;
                _dragPreviewTop = null;
              });
            },
            builder: (context, candidateData, rejectedData) {
              return SingleChildScrollView(
                controller: _scrollController,
                child: SizedBox(
                  height: totalHours * widget.hourHeight,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 시간 눈금
                      SizedBox(
                        width: 50,
                        child: Column(
                          children: List.generate(
                            totalHours,
                            (index) => SizedBox(
                              height: widget.hourHeight,
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
                      ),

                      // 타임블록 영역
                      Expanded(
                        child: Stack(
                          children: [
                            // 시간 구분선
                            ...List.generate(
                              totalHours,
                              (index) => Positioned(
                                top: index * widget.hourHeight,
                                left: 0,
                                right: 0,
                                child: Divider(
                                  height: 1,
                                  thickness: 0.5,
                                  color: theme.colorScheme.outlineVariant,
                                ),
                              ),
                            ),

                            // 30분 구분선 (점선)
                            ...List.generate(
                              totalHours,
                              (index) => Positioned(
                                top: index * widget.hourHeight +
                                    widget.hourHeight / 2,
                                left: 0,
                                right: 0,
                                child: Divider(
                                  height: 1,
                                  thickness: 0.5,
                                  color: theme.colorScheme.outlineVariant
                                      .withValues(alpha: 0.3),
                                ),
                              ),
                            ),

                            // 드래그 프리뷰
                            if (_draggingTask != null && _dragPreviewTop != null)
                              _buildDragPreview(theme),

                            // TimeBlock 카드들
                            ...widget.timeBlocks.map((tb) => _buildTimeBlockCard(tb, theme)),

                            // 현재 시간 표시선
                            if (_isToday) _buildCurrentTimeLine(theme, isDark),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDragPreview(ThemeData theme) {
    final task = _draggingTask!;
    final snappedTop =
        ((_dragPreviewTop! / widget.hourHeight * 60 / 30).round() *
                30 *
                widget.hourHeight /
                60)
            .clamp(0.0, double.infinity);
    final height = task.estimatedDuration.inMinutes * widget.hourHeight / 60;

    // 순위에 따른 색상
    final bloc = context.read<PlannerBloc>();
    final rank = bloc.state.getTaskRank(task.id);
    final color = switch (rank) {
      1 => AppColors.rank1,
      2 => AppColors.rank2,
      3 => AppColors.rank3,
      _ => theme.colorScheme.primary,
    };

    return Positioned(
      top: snappedTop,
      left: 4,
      right: 4,
      child: Container(
        height: height.clamp(40, double.infinity),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: color,
            width: 2,
            strokeAlign: BorderSide.strokeAlignCenter,
          ),
        ),
        padding: const EdgeInsets.all(8),
        child: Text(
          task.title,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: color,
            fontWeight: FontWeight.w600,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget _buildTimeBlockCard(TimeBlock timeBlock, ThemeData theme) {
    final startMinutesFromDayStart =
        (timeBlock.startTime.hour - widget.startHour) * 60 +
            timeBlock.startTime.minute;
    final durationMinutes =
        timeBlock.endTime.difference(timeBlock.startTime).inMinutes;

    final top = startMinutesFromDayStart * widget.hourHeight / 60;
    final height = durationMinutes * widget.hourHeight / 60;

    return Positioned(
      top: top,
      left: 4,
      right: 4,
      child: TimeBlockCard(
        timeBlock: timeBlock,
        height: height.clamp(30, double.infinity),
        onTap: () {
          // TODO: Open time block detail
        },
      ),
    );
  }

  Widget _buildCurrentTimeLine(ThemeData theme, bool isDark) {
    final now = DateTime.now();
    final minutesFromDayStart =
        (now.hour - widget.startHour) * 60 + now.minute;
    final top = minutesFromDayStart * widget.hourHeight / 60;

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
}
