import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../task/domain/entities/task.dart';

/// 흔들리는 태스크 버튼
///
/// iOS 홈 화면 편집 모드 스타일의 흔들리는 칩 버튼
/// - 부드러운 회전 애니메이션 (±2.5도)
/// - 탭 시 선택 영역으로 날아가는 효과
class JigglingTaskButton extends StatefulWidget {
  final Task task;
  final VoidCallback? onTap;
  final bool isJiggling;
  final int jiggleDelay;

  const JigglingTaskButton({
    super.key,
    required this.task,
    this.onTap,
    this.isJiggling = true,
    this.jiggleDelay = 0,
  });

  @override
  State<JigglingTaskButton> createState() => _JigglingTaskButtonState();
}

class _JigglingTaskButtonState extends State<JigglingTaskButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();

    // 랜덤 타이밍으로 자연스러운 흔들림
    final random = math.Random();
    final duration = 100 + random.nextInt(50); // 100-150ms

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: duration),
    );

    _rotationAnimation = Tween<double>(
      begin: -0.04, // -2.5도 (라디안)
      end: 0.04, // +2.5도 (라디안)
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    // 딜레이 후 애니메이션 시작
    if (widget.isJiggling) {
      Future.delayed(Duration(milliseconds: widget.jiggleDelay), () {
        if (mounted) {
          _controller.repeat(reverse: true);
        }
      });
    }
  }

  @override
  void didUpdateWidget(covariant JigglingTaskButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isJiggling && !_controller.isAnimating) {
      _controller.repeat(reverse: true);
    } else if (!widget.isJiggling && _controller.isAnimating) {
      _controller.stop();
      _controller.reset();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // 우선순위에 따른 색상
    final priorityColor = switch (widget.task.priority) {
      TaskPriority.high => AppColors.priorityHigh,
      TaskPriority.medium => AppColors.priorityMedium,
      TaskPriority.low => AppColors.priorityLow,
    };

    return AnimatedBuilder(
      animation: _rotationAnimation,
      builder: (context, child) {
        return Transform.rotate(
          angle: widget.isJiggling ? _rotationAnimation.value : 0,
          child: child,
        );
      },
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: priorityColor,
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: theme.colorScheme.shadow.withValues(alpha: 0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 우선순위 도트
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: priorityColor,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                // 태스크 제목
                Flexible(
                  child: Text(
                    widget.task.title,
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: theme.colorScheme.onSurface,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// AnimatedBuilder와 동일하지만 자식을 재빌드하지 않음
class AnimatedBuilder extends AnimatedWidget {
  final Widget? child;
  final Widget Function(BuildContext context, Widget? child) builder;

  const AnimatedBuilder({
    super.key,
    required Animation<double> animation,
    required this.builder,
    this.child,
  }) : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    return builder(context, child);
  }
}
