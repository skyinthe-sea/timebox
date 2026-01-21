import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../task/domain/entities/task.dart';

/// 드래그 가능한 Task 카드
///
/// 브레인덤프에서 Top 3 또는 타임라인으로 드래그할 수 있는 카드
class DraggableTaskCard extends StatelessWidget {
  final Task task;
  final int? rank; // Top 3 순위 (null이면 Top 3 아님)

  const DraggableTaskCard({
    super.key,
    required this.task,
    this.rank,
  });

  Color? get _rankColor => switch (rank) {
        1 => AppColors.rank1,
        2 => AppColors.rank2,
        3 => AppColors.rank3,
        _ => null,
      };

  @override
  Widget build(BuildContext context) {
    return LongPressDraggable<Task>(
      data: task,
      delay: const Duration(milliseconds: 150),
      hapticFeedbackOnStart: true,
      onDragStarted: () => HapticFeedback.mediumImpact(),
      feedback: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(12),
        child: Transform.scale(
          scale: 1.05,
          child: SizedBox(
            width: MediaQuery.of(context).size.width - 64,
            child: _TaskCardContent(
              task: task,
              rank: rank,
              rankColor: _rankColor,
              isDragging: true,
            ),
          ),
        ),
      ),
      childWhenDragging: Opacity(
        opacity: 0.3,
        child: _TaskCardContent(
          task: task,
          rank: rank,
          rankColor: _rankColor,
        ),
      ),
      child: _TaskCardContent(
        task: task,
        rank: rank,
        rankColor: _rankColor,
      ),
    );
  }
}

class _TaskCardContent extends StatelessWidget {
  final Task task;
  final int? rank;
  final Color? rankColor;
  final bool isDragging;

  const _TaskCardContent({
    required this.task,
    this.rank,
    this.rankColor,
    this.isDragging = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: rankColor ??
              (isDark ? AppColors.borderDark : AppColors.borderLight),
          width: rank != null ? 2 : 1,
        ),
        boxShadow: isDragging
            ? [
                BoxShadow(
                  color: (rankColor ?? theme.colorScheme.primary)
                      .withValues(alpha: 0.3),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ]
            : null,
      ),
      child: Row(
        children: [
          // 순위 표시 (Top 3인 경우)
          if (rank != null) ...[
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: rankColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '$rank',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
          ],

          // Task 정보
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // 제목
                Text(
                  task.title,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),

                // 메타 정보
                Row(
                  children: [
                    // 예상 시간
                    Icon(
                      Icons.schedule,
                      size: 14,
                      color: theme.colorScheme.outline,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      _formatDuration(task.estimatedDuration),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.outline,
                      ),
                    ),

                    const SizedBox(width: 12),

                    // 우선순위
                    _PriorityIndicator(priority: task.priority),
                  ],
                ),
              ],
            ),
          ),

          // 드래그 핸들
          Icon(
            Icons.drag_indicator,
            color: theme.colorScheme.outline.withValues(alpha: 0.5),
          ),
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;

    if (hours > 0 && minutes > 0) {
      return '${hours}h ${minutes}m';
    } else if (hours > 0) {
      return '${hours}h';
    } else {
      return '${minutes}m';
    }
  }
}

class _PriorityIndicator extends StatelessWidget {
  final TaskPriority priority;

  const _PriorityIndicator({required this.priority});

  @override
  Widget build(BuildContext context) {
    final (color, label) = switch (priority) {
      TaskPriority.high => (AppColors.priorityHigh, 'High'),
      TaskPriority.medium => (AppColors.priorityMedium, 'Med'),
      TaskPriority.low => (AppColors.priorityLow, 'Low'),
    };

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: color,
                fontWeight: FontWeight.w500,
              ),
        ),
      ],
    );
  }
}
