import 'package:flutter/material.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/task_completion_ranking.dart';

/// Task 완료 랭킹 카드
///
/// Top 5 성공/실패 Task를 두 섹션으로 표시
class TaskCompletionRankingCard extends StatelessWidget {
  final List<TaskCompletionRanking> topSuccess;
  final List<TaskCompletionRanking> topFailure;

  const TaskCompletionRankingCard({
    super.key,
    required this.topSuccess,
    required this.topFailure,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;

    if (topSuccess.isEmpty && topFailure.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: isDark ? AppColors.borderDark : AppColors.borderLight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.taskRankings,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              // Top Success
              if (topSuccess.isNotEmpty) ...[
                _SectionHeader(
                  label: l10n.topSuccessTasks,
                  color: isDark ? AppColors.successDark : AppColors.successLight,
                ),
                const SizedBox(height: 8),
                ...topSuccess.asMap().entries.map((entry) {
                  return _RankingRow(
                    rank: entry.key + 1,
                    ranking: entry.value,
                    color: isDark ? AppColors.successDark : AppColors.successLight,
                  );
                }),
              ],
              if (topSuccess.isNotEmpty && topFailure.isNotEmpty)
                const SizedBox(height: 16),
              // Top Failure
              if (topFailure.isNotEmpty) ...[
                _SectionHeader(
                  label: l10n.topFailureTasks,
                  color: isDark ? AppColors.warningDark : AppColors.warningLight,
                ),
                const SizedBox(height: 8),
                ...topFailure.asMap().entries.map((entry) {
                  return _RankingRow(
                    rank: entry.key + 1,
                    ranking: entry.value,
                    color: isDark ? AppColors.warningDark : AppColors.warningLight,
                  );
                }),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String label;
  final Color color;

  const _SectionHeader({
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Container(
          width: 4,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: theme.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }
}

class _RankingRow extends StatelessWidget {
  final int rank;
  final TaskCompletionRanking ranking;
  final Color color;

  const _RankingRow({
    required this.rank,
    required this.ranking,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final percent = (ranking.completionRate * 100).round();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          // 순위
          SizedBox(
            width: 24,
            child: Text(
              '$rank',
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: color,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: 8),
          // 제목
          Expanded(
            child: Text(
              ranking.title,
              style: theme.textTheme.bodyMedium,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 8),
          // 프로그레스 바
          SizedBox(
            width: 60,
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: ranking.completionRate),
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeOutCubic,
              builder: (context, value, child) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: value,
                    minHeight: 8,
                    backgroundColor: color.withValues(alpha: 0.15),
                    valueColor: AlwaysStoppedAnimation(color),
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 8),
          // 비율 + 횟수
          SizedBox(
            width: 64,
            child: Text(
              '$percent% (${ranking.completedCount}/${ranking.totalCount})',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.outline,
                fontSize: 11,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
