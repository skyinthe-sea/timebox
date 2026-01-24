import 'package:flutter/material.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../../core/utils/date_time_utils.dart';
import '../../../task/domain/entities/task.dart';
import '../../domain/entities/time_block.dart';
import 'time_block_card.dart';

/// 타임라인 뷰 위젯
///
/// 수직 시간축에 TimeBlock들을 표시하는 핵심 UI 컴포넌트
class TimelineView extends StatefulWidget {
  final DateTime date;
  final List<TimeBlock> timeBlocks;
  final int startHour;
  final int endHour;
  final double hourHeight;
  final void Function(TimeBlock)? onTimeBlockTap;
  final void Function(String taskId, DateTime dropTime)? onTaskDropped;
  final void Function(String id, DateTime newStartTime)? onTimeBlockMoved;
  final void Function(String id, DateTime newStart, DateTime newEnd)?
      onTimeBlockResized;

  /// Task ID별 우선순위 맵 (강조 표시용)
  final Map<String, TaskPriority> taskPriorities;

  const TimelineView({
    super.key,
    required this.date,
    required this.timeBlocks,
    this.startHour = 6,
    this.endHour = 24,
    this.hourHeight = 60,
    this.onTimeBlockTap,
    this.onTaskDropped,
    this.onTimeBlockMoved,
    this.onTimeBlockResized,
    this.taskPriorities = const {},
  });

  @override
  State<TimelineView> createState() => _TimelineViewState();
}

class _TimelineViewState extends State<TimelineView> {
  late ScrollController _scrollController;

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
    if (!DateTimeUtils.isToday(widget.date)) return;

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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final totalHours = widget.endHour - widget.startHour;
    final isToday = DateTimeUtils.isToday(widget.date);

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
                      top: index * widget.hourHeight + widget.hourHeight / 2,
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

                  // TimeBlock 카드들
                  ...widget.timeBlocks.map((tb) => _buildTimeBlockCard(tb)),

                  // 현재 시간 표시선
                  if (isToday) _buildCurrentTimeLine(theme),
                ],
              ),
            ),
          ],
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

    final top = startMinutesFromDayStart * widget.hourHeight / 60;
    final height = durationMinutes * widget.hourHeight / 60;

    // Task ID로 우선순위 조회
    final priority = timeBlock.taskId != null
        ? widget.taskPriorities[timeBlock.taskId]
        : null;

    return Positioned(
      top: top,
      left: 0,
      right: 0,
      child: TimeBlockCard(
        timeBlock: timeBlock,
        priority: priority,
        height: height.clamp(20, double.infinity),
        onTap: () => widget.onTimeBlockTap?.call(timeBlock),
        onResizeTop: (delta) {
          final newStart = timeBlock.startTime
              .add(Duration(minutes: (delta / widget.hourHeight * 60).round()));
          widget.onTimeBlockResized
              ?.call(timeBlock.id, newStart, timeBlock.endTime);
        },
        onResizeBottom: (delta) {
          final newEnd = timeBlock.endTime
              .add(Duration(minutes: (delta / widget.hourHeight * 60).round()));
          widget.onTimeBlockResized
              ?.call(timeBlock.id, timeBlock.startTime, newEnd);
        },
      ),
    );
  }

  Widget _buildCurrentTimeLine(ThemeData theme) {
    final now = DateTime.now();
    final minutesFromDayStart =
        (now.hour - widget.startHour) * 60 + now.minute;
    final top = minutesFromDayStart * widget.hourHeight / 60;

    final isDark = theme.brightness == Brightness.dark;

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
