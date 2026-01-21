import 'package:flutter/material.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/task.dart';

/// 할 일 목록 아이템 위젯
///
/// 인박스에서 각 할 일을 표시하는 카드
class TaskListItem extends StatelessWidget {
  final Task task;
  final VoidCallback? onTap;
  final VoidCallback? onToggleComplete;
  final VoidCallback? onDelete;

  const TaskListItem({
    super.key,
    required this.task,
    this.onTap,
    this.onToggleComplete,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Dismissible(
      key: Key(task.id),
      direction: DismissDirection.horizontal,
      // 왼쪽 스와이프: 삭제
      background: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 20),
        color: isDark ? AppColors.errorDark : AppColors.errorLight,
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      // 오른쪽 스와이프: 완료
      secondaryBackground: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: isDark ? AppColors.successDark : AppColors.successLight,
        child: const Icon(Icons.check, color: Colors.white),
      ),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.endToStart) {
          // 완료 토글
          onToggleComplete?.call();
          return false; // 실제로 dismiss하지 않음
        } else {
          // 삭제 확인
          return await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(l10n?.deleteTask ?? 'Delete Task'),
                  content: Text(l10n?.deleteTaskConfirm ??
                      'Are you sure you want to delete this task?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text(l10n?.cancel ?? 'Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: Text(l10n?.delete ?? 'Delete'),
                    ),
                  ],
                ),
              ) ??
              false;
        }
      },
      onDismissed: (direction) {
        if (direction == DismissDirection.startToEnd) {
          onDelete?.call();
        }
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                // 체크박스
                Transform.scale(
                  scale: 1.1,
                  child: Checkbox(
                    value: task.isCompleted,
                    onChanged: (_) => onToggleComplete?.call(),
                    shape: const CircleBorder(),
                  ),
                ),
                const SizedBox(width: 8),

                // 내용
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 제목
                      Text(
                        task.title,
                        style: task.isCompleted
                            ? theme.textTheme.bodyLarge?.copyWith(
                                decoration: TextDecoration.lineThrough,
                                color: theme.colorScheme.outline,
                              )
                            : theme.textTheme.bodyLarge,
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
                          _PriorityBadge(priority: task.priority),

                          // 하위 태스크 진행률
                          if (task.subtasks.isNotEmpty) ...[
                            const SizedBox(width: 12),
                            Icon(
                              Icons.checklist,
                              size: 14,
                              color: theme.colorScheme.outline,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${task.subtasks.where((s) => s.isCompleted).length}/${task.subtasks.length}',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.outline,
                              ),
                            ),
                          ],
                        ],
                      ),

                      // 태그
                      if (task.tags.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 4,
                          children: task.tags.map((tag) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: tag.color.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                tag.name,
                                style: theme.textTheme.labelSmall?.copyWith(
                                  color: tag.color,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ],
                  ),
                ),

                // 드래그 핸들
                Icon(
                  Icons.drag_indicator,
                  color: theme.colorScheme.outline,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;

    if (hours > 0 && minutes > 0) {
      return '$hours시간 $minutes분';
    } else if (hours > 0) {
      return '$hours시간';
    } else {
      return '$minutes분';
    }
  }
}

class _PriorityBadge extends StatelessWidget {
  final TaskPriority priority;

  const _PriorityBadge({required this.priority});

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
