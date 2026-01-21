import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../task/domain/entities/task.dart';

/// Top 3 카드 위젯
///
/// Top 3 슬롯에 배치된 Task를 표시하는 카드
class TopThreeCard extends StatelessWidget {
  final Task task;
  final int rank;
  final Color color;
  final VoidCallback onRemove;

  const TopThreeCard({
    super.key,
    required this.task,
    required this.rank,
    required this.color,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onLongPress: () {
        HapticFeedback.mediumImpact();
        _showRemoveConfirmation(context);
      },
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            // 순위 표시
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: color,
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
            const SizedBox(width: 8),

            // Task 정보
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 제목
                  Text(
                    task.title,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  // 예상 시간
                  Row(
                    children: [
                      Icon(
                        Icons.schedule,
                        size: 12,
                        color: theme.colorScheme.outline,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _formatDuration(task.estimatedDuration),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.outline,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
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

  void _showRemoveConfirmation(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.remove_circle_outline,
                    color: Colors.red),
                title: const Text('Remove from Top 3'),
                onTap: () {
                  Navigator.pop(context);
                  onRemove();
                },
              ),
              ListTile(
                leading: const Icon(Icons.close),
                title: const Text('Cancel'),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
