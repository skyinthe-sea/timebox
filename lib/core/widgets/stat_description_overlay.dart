import 'package:flutter/material.dart';

import '../../config/themes/app_colors.dart';

/// 위젯을 롱프레스하면 상단에 설명 오버레이를 표시하는 래퍼
class StatDescriptionWrapper extends StatefulWidget {
  final Widget child;
  final String title;
  final String description;

  const StatDescriptionWrapper({
    super.key,
    required this.child,
    required this.title,
    required this.description,
  });

  @override
  State<StatDescriptionWrapper> createState() =>
      _StatDescriptionWrapperState();
}

class _StatDescriptionWrapperState extends State<StatDescriptionWrapper> {
  OverlayEntry? _overlayEntry;

  void _showOverlay() {
    _removeOverlay();

    final overlay = Overlay.of(context);
    final theme = Theme.of(context);

    _overlayEntry = OverlayEntry(
      builder: (context) => _DescriptionOverlay(
        title: widget.title,
        description: widget.description,
        theme: theme,
      ),
    );

    overlay.insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressStart: (_) => _showOverlay(),
      onLongPressEnd: (_) => _removeOverlay(),
      onLongPressCancel: () => _removeOverlay(),
      child: widget.child,
    );
  }
}

class _DescriptionOverlay extends StatefulWidget {
  final String title;
  final String description;
  final ThemeData theme;

  const _DescriptionOverlay({
    required this.title,
    required this.description,
    required this.theme,
  });

  @override
  State<_DescriptionOverlay> createState() => _DescriptionOverlayState();
}

class _DescriptionOverlayState extends State<_DescriptionOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _slideAnimation;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _fadeAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.theme.brightness == Brightness.dark;
    final topPadding = MediaQuery.of(context).padding.top;

    return Positioned(
      left: 24,
      right: 24,
      top: topPadding + 16,
      child: SlideTransition(
        position: _slideAnimation,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Material(
            elevation: 8,
            borderRadius: BorderRadius.circular(16),
            color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color:
                      isDark ? AppColors.borderDark : AppColors.borderLight,
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 20,
                    color: widget.theme.colorScheme.primary,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style:
                              widget.theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.description,
                          style: widget.theme.textTheme.bodyMedium?.copyWith(
                            color: widget.theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
