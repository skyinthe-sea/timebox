import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../l10n/app_localizations.dart';
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
                        _formatDuration(context, task.estimatedDuration),
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

  String _formatDuration(BuildContext context, Duration duration) {
    final l10n = AppLocalizations.of(context);
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;

    if (hours > 0 && minutes > 0) {
      return l10n?.durationFormat(hours, minutes) ?? '${hours}h ${minutes}m';
    } else if (hours > 0) {
      return l10n?.hoursShort(hours) ?? '${hours}h';
    } else {
      return l10n?.minutesShort(minutes) ?? '${minutes}m';
    }
  }

  void _showRemoveConfirmation(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    showModalBottomSheet(
      context: context,
      builder: (sheetContext) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.remove_circle_outline,
                    color: Colors.red),
                title: Text(l10n?.removeFromTop3 ?? 'Remove from Top 3'),
                onTap: () {
                  Navigator.pop(sheetContext);
                  onRemove();
                },
              ),
              ListTile(
                leading: const Icon(Icons.close),
                title: Text(l10n?.cancel ?? 'Cancel'),
                onTap: () => Navigator.pop(sheetContext),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
