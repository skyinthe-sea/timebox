import 'package:flutter/material.dart';

import '../../../../config/themes/app_colors.dart';

/// 선택 영역 오버레이
///
/// 롱프레스-드래그로 선택한 시간 범위를 하이라이트
/// - 펄스/글로우 애니메이션
/// - Primary 색상 배경 + 테두리
class SelectionOverlay extends StatefulWidget {
  /// 시작 슬롯 인덱스 (0-47)
  final int startSlot;

  /// 종료 슬롯 인덱스 (0-47)
  final int endSlot;

  /// 슬롯 높이 (픽셀)
  final double slotHeight;

  /// 타임라인 시작 시간
  final int startHour;

  /// 애니메이션 진행 중
  final bool isAnimating;

  const SelectionOverlay({
    super.key,
    required this.startSlot,
    required this.endSlot,
    required this.slotHeight,
    this.startHour = 0,
    this.isAnimating = false,
  });

  @override
  State<SelectionOverlay> createState() => _SelectionOverlayState();
}

class _SelectionOverlayState extends State<SelectionOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _pulseAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    _pulseController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // 시작 슬롯을 뷰 좌표로 변환
    final adjustedStartSlot = widget.startSlot - (widget.startHour * 2);
    final adjustedEndSlot = widget.endSlot - (widget.startHour * 2);

    final top = adjustedStartSlot * widget.slotHeight;
    final height = (adjustedEndSlot - adjustedStartSlot + 1) * widget.slotHeight;

    final backgroundColor = isDark
        ? AppColors.selectionBackgroundDark
        : AppColors.selectionBackgroundLight;
    final borderColor = isDark
        ? AppColors.selectionBorderDark
        : AppColors.selectionBorderLight;

    return _AnimatedBuilder(
      animation: _pulseAnimation,
      builder: (context, child) {
        return Positioned(
          top: top,
          left: 0,
          right: 0,
          height: height,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            curve: Curves.easeOutCubic,
            decoration: BoxDecoration(
              color: backgroundColor,
              border: Border.all(
                color: borderColor,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: borderColor.withValues(alpha: 0.3 * _pulseAnimation.value),
                  blurRadius: 12 * _pulseAnimation.value,
                  spreadRadius: 2 * _pulseAnimation.value,
                ),
              ],
            ),
            child: child,
          ),
        );
      },
      child: const SizedBox.expand(),
    );
  }
}

/// AnimatedBuilder와 동일하지만 자식을 재빌드하지 않음
class _AnimatedBuilder extends AnimatedWidget {
  final Widget? child;
  final Widget Function(BuildContext context, Widget? child) builder;

  const _AnimatedBuilder({
    required Animation<double> animation,
    required this.builder,
    this.child,
  }) : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    return builder(context, child);
  }
}
