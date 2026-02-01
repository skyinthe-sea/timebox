import 'package:flutter/material.dart';

import '../../../../config/themes/app_colors.dart';
import 'animated_counter.dart';

/// 통계 카드 위젯
///
/// 아이콘 + 숫자 + 라벨로 구성된 단일 통계 표시
class StatCard extends StatelessWidget {
  /// 아이콘
  final IconData icon;

  /// 값
  final int value;

  /// 라벨
  final String label;

  /// 접미사 (예: "%", "개")
  final String? suffix;

  /// 색상 (null이면 primary)
  final Color? color;

  /// 값이 시간인지 (분 단위)
  final bool isTime;

  /// 값이 양수/음수 표시가 필요한지
  final bool showSign;

  const StatCard({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    this.suffix,
    this.color,
    this.isTime = false,
    this.showSign = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final cardColor = color ?? theme.colorScheme.primary;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isDark ? AppColors.borderDark : AppColors.borderLight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 아이콘
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: cardColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: cardColor,
                size: 22,
              ),
            ),
            const SizedBox(height: 12),
            // 값
            if (isTime)
              AnimatedTimeCounter(
                minutes: value,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
                unitStyle: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.outline,
                ),
              )
            else
              AnimatedCounter(
                value: value,
                prefix: showSign && value > 0 ? '+' : (showSign && value < 0 ? '' : null),
                suffix: suffix,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: showSign
                      ? (value > 0
                          ? AppColors.successLight
                          : value < 0
                              ? AppColors.errorLight
                              : theme.colorScheme.onSurface)
                      : theme.colorScheme.onSurface,
                ),
              ),
            const SizedBox(height: 4),
            // 라벨
            Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.outline,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

/// 하이라이트 섹션 (2x2 그리드)
class HighlightsSection extends StatelessWidget {
  final int completedTasks;
  final int totalTasks;
  final int skippedTasks;
  final int focusMinutes;
  final int timeDifferenceMinutes;
  final int top3Completed;

  const HighlightsSection({
    super.key,
    required this.completedTasks,
    this.totalTasks = 0,
    this.skippedTasks = 0,
    required this.focusMinutes,
    required this.timeDifferenceMinutes,
    required this.top3Completed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: StatCard(
                icon: Icons.check_circle_outline,
                value: completedTasks,
                label: '완료',
                suffix: totalTasks > 0 ? '/$totalTasks' : '개',
                color: AppColors.successLight,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: StatCard(
                icon: Icons.cancel_outlined,
                value: skippedTasks,
                label: '미완료',
                suffix: '개',
                color: AppColors.errorLight,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: StatCard(
                icon: Icons.timer_outlined,
                value: focusMinutes,
                label: '집중 시간',
                isTime: true,
                color: AppColors.primaryLight,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: StatCard(
                icon: Icons.stars_outlined,
                value: top3Completed,
                label: 'Top 3 달성',
                suffix: '/3',
                color: AppColors.rank1,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
