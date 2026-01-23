import 'package:flutter/material.dart';

import '../../../../core/animations/app_animations.dart';

/// 새로 추가된 Task 카드의 진입 애니메이션 위젯
///
/// 약한 흔들림 + 글로우 + 스케일 효과 제공
class AnimatedTaskEntry extends StatefulWidget {
  final Widget child;
  final bool animate;
  final VoidCallback? onAnimationComplete;

  const AnimatedTaskEntry({
    super.key,
    required this.child,
    this.animate = false,
    this.onAnimationComplete,
  });

  @override
  State<AnimatedTaskEntry> createState() => _AnimatedTaskEntryState();
}

class _AnimatedTaskEntryState extends State<AnimatedTaskEntry>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _shakeAnimation;
  late Animation<double> _glowAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AppAnimations.slowest, // 500ms
    );

    // 흔들림 애니메이션: 미세한 회전
    _shakeAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: 0.0, end: 0.02), // ~1.1 degrees
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 0.02, end: -0.02),
        weight: 2,
      ),
      TweenSequenceItem(
        tween: Tween(begin: -0.02, end: 0.01),
        weight: 2,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 0.01, end: -0.005),
        weight: 2,
      ),
      TweenSequenceItem(
        tween: Tween(begin: -0.005, end: 0.0),
        weight: 1,
      ),
    ]).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    // 글로우 애니메이션: 0 → 1 → 0
    _glowAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: 0.0, end: 1.0),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 1.0, end: 0.0),
        weight: 2,
      ),
    ]).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    // 스케일 애니메이션: 1.0 → 1.02 → 1.0
    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: 1.0, end: 1.02),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 1.02, end: 1.0),
        weight: 2,
      ),
    ]).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    if (widget.animate) {
      _startAnimation();
    }
  }

  @override
  void didUpdateWidget(covariant AnimatedTaskEntry oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animate && !oldWidget.animate) {
      _startAnimation();
    }
  }

  void _startAnimation() {
    _controller.forward(from: 0.0).then((_) {
      widget.onAnimationComplete?.call();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Transform.rotate(
            angle: _shakeAnimation.value,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: _glowAnimation.value > 0
                    ? [
                        BoxShadow(
                          color: theme.colorScheme.primary
                              .withValues(alpha: 0.4 * _glowAnimation.value),
                          blurRadius: 16 * _glowAnimation.value,
                          spreadRadius: 2 * _glowAnimation.value,
                        ),
                      ]
                    : null,
              ),
              child: child,
            ),
          ),
        );
      },
      child: widget.child,
    );
  }
}
