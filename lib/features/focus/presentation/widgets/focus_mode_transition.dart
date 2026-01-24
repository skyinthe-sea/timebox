import 'package:flutter/material.dart';

import '../../../timeblock/domain/entities/time_block.dart';
import '../pages/focus_mode_page.dart';

/// 집중 모드 전환 애니메이션 Route
///
/// 타임블록 카드가 확대되며 전체화면 집중 모드로 전환되는 효과
class FocusModePageRoute extends PageRouteBuilder<void> {
  final TimeBlock timeBlock;
  final String? taskTitle;

  FocusModePageRoute({
    required this.timeBlock,
    this.taskTitle,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) {
            return FocusModePage(
              initialTimeBlock: timeBlock,
              taskTitle: taskTitle,
            );
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return _FocusModeTransition(
              animation: animation,
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 500),
          reverseTransitionDuration: const Duration(milliseconds: 400),
        );
}

/// 집중 모드 전환 애니메이션 위젯
class _FocusModeTransition extends StatelessWidget {
  final Animation<double> animation;
  final Widget child;

  const _FocusModeTransition({
    required this.animation,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final curvedAnimation = CurvedAnimation(
      parent: animation,
      curve: Curves.easeInOutCubic,
    );

    return AnimatedBuilder(
      animation: curvedAnimation,
      builder: (context, _) {
        return Stack(
          children: [
            // 배경 페이드 인
            Opacity(
              opacity: curvedAnimation.value,
              child: Container(
                color: Theme.of(context).colorScheme.surface,
              ),
            ),
            // 콘텐츠 스케일 + 페이드
            FadeTransition(
              opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
                ),
              ),
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.0, 0.1),
                  end: Offset.zero,
                ).animate(curvedAnimation),
                child: child,
              ),
            ),
          ],
        );
      },
    );
  }
}
