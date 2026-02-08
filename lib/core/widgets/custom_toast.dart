import 'dart:async';

import 'package:flutter/material.dart';

/// OverlayEntry 기반 커스텀 토스트
///
/// SnackBar의 duration 무시 버그를 우회하기 위해 사용
class CustomToast {
  static OverlayEntry? _currentEntry;
  static Timer? _timer;

  /// 토스트 표시
  static void show(
    BuildContext context, {
    required String title,
    String? subtitle,
    String? actionLabel,
    VoidCallback? onAction,
    Duration duration = const Duration(milliseconds: 2500),
  }) {
    dismiss();

    final overlay = Overlay.of(context);
    final theme = Theme.of(context);

    late OverlayEntry entry;
    entry = OverlayEntry(
      builder: (context) => _ToastWidget(
        title: title,
        subtitle: subtitle,
        actionLabel: actionLabel,
        onAction: () {
          onAction?.call();
          dismiss();
        },
        onDismiss: dismiss,
        theme: theme,
      ),
    );

    _currentEntry = entry;
    overlay.insert(entry);

    _timer = Timer(duration, dismiss);
  }

  /// 현재 토스트 제거
  static void dismiss() {
    _timer?.cancel();
    _timer = null;
    _currentEntry?.remove();
    _currentEntry = null;
  }
}

class _ToastWidget extends StatefulWidget {
  final String title;
  final String? subtitle;
  final String? actionLabel;
  final VoidCallback? onAction;
  final VoidCallback onDismiss;
  final ThemeData theme;

  const _ToastWidget({
    required this.title,
    this.subtitle,
    this.actionLabel,
    this.onAction,
    required this.onDismiss,
    required this.theme,
  });

  @override
  State<_ToastWidget> createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<_ToastWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _slideAnimation;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _dismiss() async {
    await _controller.reverse();
    widget.onDismiss();
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Positioned(
      left: 16,
      right: 16,
      bottom: bottomPadding + 80,
      child: SlideTransition(
        position: _slideAnimation,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: GestureDetector(
            onVerticalDragEnd: (details) {
              if (details.primaryVelocity != null &&
                  details.primaryVelocity! > 100) {
                _dismiss();
              }
            },
            child: Material(
              elevation: 6,
              borderRadius: BorderRadius.circular(12),
              color: widget.theme.colorScheme.inverseSurface,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title,
                            style: widget.theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color:
                                  widget.theme.colorScheme.onInverseSurface,
                            ),
                          ),
                          if (widget.subtitle != null) ...[
                            const SizedBox(height: 4),
                            Text(
                              widget.subtitle!,
                              style:
                                  widget.theme.textTheme.bodySmall?.copyWith(
                                color:
                                    widget.theme.colorScheme.onInverseSurface,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    if (widget.actionLabel != null) ...[
                      const SizedBox(width: 8),
                      TextButton(
                        onPressed: widget.onAction,
                        child: Text(
                          widget.actionLabel!,
                          style: TextStyle(
                            color: widget.theme.colorScheme.inversePrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
