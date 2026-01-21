import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../task/domain/entities/task.dart';
import 'top_three_card.dart';

/// Top 3 슬롯 위젯
///
/// 개별 순위 슬롯 (DragTarget으로 Task를 받음)
class TopThreeSlot extends StatefulWidget {
  final int rank;
  final Task? task;
  final Color color;
  final void Function(Task task) onTaskDropped;
  final VoidCallback onTaskRemoved;

  const TopThreeSlot({
    super.key,
    required this.rank,
    required this.task,
    required this.color,
    required this.onTaskDropped,
    required this.onTaskRemoved,
  });

  @override
  State<TopThreeSlot> createState() => _TopThreeSlotState();
}

class _TopThreeSlotState extends State<TopThreeSlot>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  bool _isDragOver = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.08).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return DragTarget<Task>(
      onWillAcceptWithDetails: (details) {
        // 이미 Top 3에 있는 Task는 거부
        if (widget.task?.id == details.data.id) return false;
        setState(() => _isDragOver = true);
        _controller.forward();
        HapticFeedback.selectionClick();
        return true;
      },
      onLeave: (_) {
        setState(() => _isDragOver = false);
        _controller.reverse();
      },
      onAcceptWithDetails: (details) {
        setState(() => _isDragOver = false);
        _controller.reverse();
        widget.onTaskDropped(details.data);
      },
      builder: (context, candidateData, rejectedData) {
        return AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                height: 80,
                decoration: BoxDecoration(
                  color: _isDragOver
                      ? widget.color.withValues(alpha: 0.15)
                      : theme.colorScheme.surface,
                  border: Border.all(
                    color: _isDragOver
                        ? widget.color
                        : widget.task != null
                            ? widget.color
                            : theme.colorScheme.outline.withValues(alpha: 0.3),
                    width: _isDragOver || widget.task != null ? 2 : 1,
                    strokeAlign: BorderSide.strokeAlignInside,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: widget.task != null
                    ? TopThreeCard(
                        task: widget.task!,
                        rank: widget.rank,
                        color: widget.color,
                        onRemove: widget.onTaskRemoved,
                      )
                    : _EmptySlot(
                        rank: widget.rank,
                        color: widget.color,
                        isDragOver: _isDragOver,
                        l10n: l10n,
                      ),
              ),
            );
          },
        );
      },
    );
  }
}

class _EmptySlot extends StatelessWidget {
  final int rank;
  final Color color;
  final bool isDragOver;
  final AppLocalizations? l10n;

  const _EmptySlot({
    required this.rank,
    required this.color,
    required this.isDragOver,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final rankLabel = switch (rank) {
      1 => l10n?.rank1 ?? '1st',
      2 => l10n?.rank2 ?? '2nd',
      3 => l10n?.rank3 ?? '3rd',
      _ => '',
    };

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 150),
            child: isDragOver
                ? Icon(
                    Icons.add_circle,
                    key: const ValueKey('add'),
                    color: color,
                    size: 28,
                  )
                : Icon(
                    Icons.add,
                    key: const ValueKey('placeholder'),
                    color: theme.colorScheme.outline.withValues(alpha: 0.5),
                    size: 24,
                  ),
          ),
          const SizedBox(height: 4),
          Text(
            rankLabel,
            style: theme.textTheme.labelSmall?.copyWith(
              color: isDragOver
                  ? color
                  : theme.colorScheme.outline.withValues(alpha: 0.5),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
