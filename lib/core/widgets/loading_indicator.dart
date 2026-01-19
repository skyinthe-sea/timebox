import 'package:flutter/material.dart';

/// 로딩 인디케이터 위젯
///
/// 앱 전체에서 사용되는 통일된 로딩 표시
class LoadingIndicator extends StatelessWidget {
  /// 크기 (기본: 36)
  final double size;

  /// 색상 (기본: primary color)
  final Color? color;

  /// 스트로크 두께 (기본: 3)
  final double strokeWidth;

  const LoadingIndicator({
    super.key,
    this.size = 36,
    this.color,
    this.strokeWidth = 3,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        strokeWidth: strokeWidth,
        valueColor: AlwaysStoppedAnimation<Color>(
          color ?? Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}

/// 전체 화면 로딩 오버레이
class LoadingOverlay extends StatelessWidget {
  /// 로딩 메시지 (선택)
  final String? message;

  const LoadingOverlay({
    super.key,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const LoadingIndicator(
              size: 48,
              color: Colors.white,
            ),
            if (message != null) ...[
              const SizedBox(height: 16),
              Text(
                message!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
