import 'package:flutter/material.dart';

import '../../../../config/themes/app_colors.dart';
import '../../domain/entities/insight.dart';
import '../../../../l10n/app_localizations.dart';

/// 컴팩트 인사이트 섹션 (최대 3개)
///
/// 한줄 카드 형태로 인사이트를 표시
class TopInsightsSection extends StatefulWidget {
  final List<Insight> insights;
  final IconData Function(InsightType) getIcon;

  const TopInsightsSection({
    super.key,
    required this.insights,
    required this.getIcon,
  });

  @override
  State<TopInsightsSection> createState() => _TopInsightsSectionState();
}

class _TopInsightsSectionState extends State<TopInsightsSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final items = widget.insights.take(3).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.statsTopInsights,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          ...items.asMap().entries.map((entry) {
            final index = entry.key;
            final insight = entry.value;
            final delay = index * 0.15;
            final end = (delay + 0.7).clamp(0.0, 1.0);

            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.1, 0),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: _controller,
                curve: Interval(delay, end, curve: Curves.easeOutCubic),
              )),
              child: FadeTransition(
                opacity: CurvedAnimation(
                  parent: _controller,
                  curve: Interval(delay, end, curve: Curves.easeOut),
                ),
                child: _CompactInsightCard(
                  insight: insight,
                  icon: widget.getIcon(insight.type),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _CompactInsightCard extends StatelessWidget {
  final Insight insight;
  final IconData icon;

  const _CompactInsightCard({
    required this.insight,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final indicatorColor = insight.isPositive
        ? (isDark ? AppColors.successDark : AppColors.successLight)
        : (isDark ? AppColors.warningDark : AppColors.warningLight);

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Card(
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: isDark ? AppColors.borderDark : AppColors.borderLight,
          ),
        ),
        child: IntrinsicHeight(
          child: Row(
            children: [
              // Color indicator line
              Container(
                width: 4,
                decoration: BoxDecoration(
                  color: indicatorColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        icon,
                        size: 20,
                        color: indicatorColor,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          insight.title,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
