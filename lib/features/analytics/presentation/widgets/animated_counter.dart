import 'package:flutter/material.dart';

/// 애니메이션 카운터 위젯
///
/// 숫자가 0에서 목표값까지 카운트업 애니메이션
class AnimatedCounter extends StatefulWidget {
  /// 목표 값
  final int value;

  /// 애니메이션 지속 시간
  final Duration duration;

  /// 텍스트 스타일
  final TextStyle? style;

  /// 접미사 (예: "%", "점")
  final String? suffix;

  /// 접두사 (예: "+", "-")
  final String? prefix;

  /// 소수점 자리수 (0이면 정수)
  final int decimalPlaces;

  const AnimatedCounter({
    super.key,
    required this.value,
    this.duration = const Duration(milliseconds: 800),
    this.style,
    this.suffix,
    this.prefix,
    this.decimalPlaces = 0,
  });

  @override
  State<AnimatedCounter> createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<AnimatedCounter>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  int _previousValue = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _animation = Tween<double>(
      begin: 0,
      end: widget.value.toDouble(),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));

    _controller.forward();
  }

  @override
  void didUpdateWidget(AnimatedCounter oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _previousValue = oldWidget.value;
      _animation = Tween<double>(
        begin: _previousValue.toDouble(),
        end: widget.value.toDouble(),
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

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        String text;
        if (widget.decimalPlaces > 0) {
          text = _animation.value.toStringAsFixed(widget.decimalPlaces);
        } else {
          text = _animation.value.round().toString();
        }

        if (widget.prefix != null) {
          text = '${widget.prefix}$text';
        }
        if (widget.suffix != null) {
          text = '$text${widget.suffix}';
        }

        return Text(
          text,
          style: widget.style,
        );
      },
    );
  }
}

/// 시간 포맷 애니메이션 카운터
///
/// 분 단위 값을 "Xh Ym" 형식으로 표시
class AnimatedTimeCounter extends StatefulWidget {
  /// 총 분
  final int minutes;

  /// 애니메이션 지속 시간
  final Duration duration;

  /// 텍스트 스타일
  final TextStyle? style;

  /// 단위 텍스트 스타일
  final TextStyle? unitStyle;

  const AnimatedTimeCounter({
    super.key,
    required this.minutes,
    this.duration = const Duration(milliseconds: 800),
    this.style,
    this.unitStyle,
  });

  @override
  State<AnimatedTimeCounter> createState() => _AnimatedTimeCounterState();
}

class _AnimatedTimeCounterState extends State<AnimatedTimeCounter>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _animation = Tween<double>(
      begin: 0,
      end: widget.minutes.toDouble(),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));

    _controller.forward();
  }

  @override
  void didUpdateWidget(AnimatedTimeCounter oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.minutes != widget.minutes) {
      _animation = Tween<double>(
        begin: oldWidget.minutes.toDouble(),
        end: widget.minutes.toDouble(),
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

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final totalMinutes = _animation.value.round();
        final hours = totalMinutes ~/ 60;
        final mins = totalMinutes % 60;

        if (hours > 0) {
          return RichText(
            text: TextSpan(
              children: [
                TextSpan(text: '$hours', style: widget.style),
                TextSpan(text: 'h ', style: widget.unitStyle ?? widget.style),
                TextSpan(text: '$mins', style: widget.style),
                TextSpan(text: 'm', style: widget.unitStyle ?? widget.style),
              ],
            ),
          );
        } else {
          return RichText(
            text: TextSpan(
              children: [
                TextSpan(text: '$mins', style: widget.style),
                TextSpan(text: 'm', style: widget.unitStyle ?? widget.style),
              ],
            ),
          );
        }
      },
    );
  }
}
