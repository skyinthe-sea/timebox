import 'package:flutter/material.dart';

import '../../../../config/themes/app_colors.dart';
import 'animated_counter.dart';

/// 생산성 점수 카드
///
/// 원형 프로그레스와 카운트업 애니메이션으로 점수 표시
class ProductivityScoreCard extends StatefulWidget {
  /// 생산성 점수 (0-100)
  final int score;

  /// 어제 대비 변화
  final int? scoreChange;

  /// 제목
  final String title;

  /// 부제목 (변화 텍스트)
  final String? subtitle;

  const ProductivityScoreCard({
    super.key,
    required this.score,
    this.scoreChange,
    this.title = '생산성 점수',
    this.subtitle,
  });

  @override
  State<ProductivityScoreCard> createState() => _ProductivityScoreCardState();
}

class _ProductivityScoreCardState extends State<ProductivityScoreCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _progressAnimation = Tween<double>(
      begin: 0,
      end: widget.score / 100,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));

    _controller.forward();
  }

  @override
  void didUpdateWidget(ProductivityScoreCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.score != widget.score) {
      _progressAnimation = Tween<double>(
        begin: oldWidget.score / 100,
        end: widget.score / 100,
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ));
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color _getScoreColor(int score) {
    if (score <= 40) {
      return AppColors.errorLight;
    } else if (score <= 70) {
      return AppColors.warningLight;
    } else {
      return AppColors.successLight;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final scoreColor = _getScoreColor(widget.score);

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isDark ? AppColors.borderDark : AppColors.borderLight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Row(
          children: [
            // 원형 점수 표시
            SizedBox(
              width: 100,
              height: 100,
              child: AnimatedBuilder(
                animation: _progressAnimation,
                builder: (context, child) {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      // 배경 원
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: CircularProgressIndicator(
                          value: 1,
                          strokeWidth: 8,
                          backgroundColor: Colors.transparent,
                          valueColor: AlwaysStoppedAnimation(
                            scoreColor.withValues(alpha: 0.2),
                          ),
                        ),
                      ),
                      // 진행 원
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: CircularProgressIndicator(
                          value: _progressAnimation.value,
                          strokeWidth: 8,
                          backgroundColor: Colors.transparent,
                          valueColor: AlwaysStoppedAnimation(scoreColor),
                          strokeCap: StrokeCap.round,
                        ),
                      ),
                      // 점수 텍스트
                      AnimatedCounter(
                        value: widget.score,
                        duration: const Duration(milliseconds: 1200),
                        style: theme.textTheme.headlineLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: scoreColor,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(width: 24),
            // 텍스트 정보
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (widget.scoreChange != null) _buildChangeText(theme),
                  if (widget.subtitle != null && widget.scoreChange == null)
                    Text(
                      widget.subtitle!,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.outline,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChangeText(ThemeData theme) {
    final change = widget.scoreChange!;
    final isPositive = change > 0;
    final isNegative = change < 0;
    final color = isPositive
        ? AppColors.successLight
        : isNegative
            ? AppColors.errorLight
            : theme.colorScheme.outline;

    final icon = isPositive
        ? Icons.trending_up
        : isNegative
            ? Icons.trending_down
            : Icons.trending_flat;

    final text = isPositive
        ? '어제보다 $change점 상승!'
        : isNegative
            ? '어제보다 ${change.abs()}점 하락'
            : '어제와 동일';

    return Row(
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 4),
        Text(
          text,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: color,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
