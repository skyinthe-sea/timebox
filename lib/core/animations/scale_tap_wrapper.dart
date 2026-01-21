import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_animations.dart';

/// 스케일 탭 래퍼
///
/// 터치 시 자연스러운 스케일 다운 애니메이션을 적용하는 위젯
class ScaleTapWrapper extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final double scaleDown;
  final Duration duration;
  final bool enableHaptic;

  const ScaleTapWrapper({
    super.key,
    required this.child,
    this.onTap,
    this.onLongPress,
    this.scaleDown = AppAnimations.tapScale,
    this.duration = AppAnimations.fast,
    this.enableHaptic = true,
  });

  @override
  State<ScaleTapWrapper> createState() => _ScaleTapWrapperState();
}

class _ScaleTapWrapperState extends State<ScaleTapWrapper>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: widget.scaleDown,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: AppAnimations.quickStart,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
    if (widget.enableHaptic) {
      HapticFeedback.selectionClick();
    }
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }

  void _onTapCancel() {
    _controller.reverse();
  }

  void _onTap() {
    if (widget.enableHaptic) {
      HapticFeedback.lightImpact();
    }
    widget.onTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      onTap: widget.onTap != null ? _onTap : null,
      onLongPress: widget.onLongPress,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: child,
          );
        },
        child: widget.child,
      ),
    );
  }
}

/// 드래그 피드백 카드
///
/// 드래그 중 표시되는 피드백 위젯을 감싸는 컨테이너
class DragFeedbackWrapper extends StatelessWidget {
  final Widget child;
  final double scale;
  final Color? shadowColor;
  final double elevation;

  const DragFeedbackWrapper({
    super.key,
    required this.child,
    this.scale = AppAnimations.dragScale,
    this.shadowColor,
    this.elevation = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: elevation,
      shadowColor: shadowColor ?? Colors.black.withValues(alpha: 0.3),
      borderRadius: BorderRadius.circular(12),
      child: Transform.scale(
        scale: scale,
        child: child,
      ),
    );
  }
}
