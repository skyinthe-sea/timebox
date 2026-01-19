import 'package:flutter/material.dart';
import '../../domain/entities/task.dart';

/// 할 일 목록 아이템 위젯
///
/// 인박스에서 각 할 일을 표시하는 카드
///
/// 기능:
/// - 제목, 예상 시간, 우선순위, 태그 표시
/// - 탭하여 상세 보기
/// - 롱프레스하여 드래그 (캘린더로 이동)
/// - 스와이프로 완료/삭제
class TaskListItem extends StatelessWidget {
  /// 표시할 Task
  final Task task;

  /// 탭 콜백
  final VoidCallback? onTap;

  /// 완료 토글 콜백
  final VoidCallback? onToggleComplete;

  /// 삭제 콜백
  final VoidCallback? onDelete;

  /// 드래그 시작 콜백
  final VoidCallback? onDragStarted;

  const TaskListItem({
    super.key,
    required this.task,
    this.onTap,
    this.onToggleComplete,
    this.onDelete,
    this.onDragStarted,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // TODO: Dismissible로 스와이프 액션 구현
    // TODO: LongPressDraggable로 드래그 구현
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: Checkbox(
          value: task.isCompleted,
          onChanged: (_) => onToggleComplete?.call(),
        ),
        title: Text(
          task.title,
          style: task.isCompleted
              ? theme.textTheme.bodyLarge?.copyWith(
                  decoration: TextDecoration.lineThrough,
                  color: theme.colorScheme.outline,
                )
              : theme.textTheme.bodyLarge,
        ),
        subtitle: Row(
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
              style: theme.textTheme.bodySmall,
            ),
            const SizedBox(width: 12),
            // 우선순위
            _buildPriorityIndicator(task.priority),
          ],
        ),
        trailing: const Icon(Icons.drag_handle),
        onTap: onTap,
      ),
    );
  }

  Widget _buildPriorityIndicator(TaskPriority priority) {
    final color = switch (priority) {
      TaskPriority.high => const Color(0xFFEF4444),
      TaskPriority.medium => const Color(0xFFF59E0B),
      TaskPriority.low => const Color(0xFF10B981),
    };

    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
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
