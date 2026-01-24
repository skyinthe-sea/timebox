import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../task/domain/entities/task.dart';
import '../bloc/planner_bloc.dart';

/// 드래그 가능한 Task 카드
///
/// 브레인덤프에서 Top 3 또는 타임라인으로 드래그할 수 있는 카드
class DraggableTaskCard extends StatelessWidget {
  final Task task;
  final int? rank; // Top 3 순위 (null이면 Top 3 아님)
  final VoidCallback? onDelete;
  final VoidCallback? onToggleComplete;

  const DraggableTaskCard({
    super.key,
    required this.task,
    this.rank,
    this.onDelete,
    this.onToggleComplete,
  });

  Color? get _rankColor => switch (rank) {
        1 => AppColors.rank1,
        2 => AppColors.rank2,
        3 => AppColors.rank3,
        _ => null,
      };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    return Dismissible(
      key: Key(task.id),
      direction: DismissDirection.horizontal, // 양방향 스와이프
      // 왼쪽→오른쪽 스와이프 (완료 토글) 배경
      background: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 20),
        decoration: BoxDecoration(
          color: isDark ? AppColors.successDark : AppColors.successLight,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          task.isCompleted ? Icons.undo : Icons.check,
          color: Colors.white,
        ),
      ),
      // 오른쪽→왼쪽 스와이프 (삭제) 배경
      secondaryBackground: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: isDark ? AppColors.errorDark : AppColors.errorLight,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          // 왼쪽→오른쪽: 완료 토글 (확인 없이 바로 실행)
          onToggleComplete?.call();
          return false; // dismiss 하지 않음 (제자리에 유지)
        } else {
          // 오른쪽→왼쪽: 삭제 확인
          return await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(l10n?.deleteTask ?? 'Delete Task'),
                  content: Text(
                      l10n?.deleteTaskConfirm ?? 'Delete this task?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text(l10n?.cancel ?? 'Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: Text(l10n?.delete ?? 'Delete'),
                    ),
                  ],
                ),
              ) ??
              false;
        }
      },
      onDismissed: (_) => onDelete?.call(),
      child: LongPressDraggable<Task>(
      data: task,
      delay: const Duration(milliseconds: 150),
      hapticFeedbackOnStart: true,
      onDragStarted: () => HapticFeedback.mediumImpact(),
      feedback: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(12),
        child: Transform.scale(
          scale: 1.05,
          child: SizedBox(
            width: MediaQuery.of(context).size.width - 64,
            child: _TaskCardContent(
              task: task,
              rank: rank,
              rankColor: _rankColor,
              isDragging: true,
            ),
          ),
        ),
      ),
      childWhenDragging: Opacity(
        opacity: 0.3,
        child: _TaskCardContent(
          task: task,
          rank: rank,
          rankColor: _rankColor,
        ),
      ),
      child: _TaskCardContent(
        task: task,
        rank: rank,
        rankColor: _rankColor,
      ),
    ),
    );
  }
}

class _TaskCardContent extends StatelessWidget {
  final Task task;
  final int? rank;
  final Color? rankColor;
  final bool isDragging;

  const _TaskCardContent({
    required this.task,
    this.rank,
    this.rankColor,
    this.isDragging = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: rankColor ??
              (isDark ? AppColors.borderDark : AppColors.borderLight),
          width: rank != null ? 2 : 1,
        ),
        boxShadow: isDragging
            ? [
                BoxShadow(
                  color: (rankColor ?? theme.colorScheme.primary)
                      .withValues(alpha: 0.3),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ]
            : null,
      ),
      child: Stack(
        children: [
          Row(
            children: [
              // 순위 표시 (Top 3인 경우)
              if (rank != null) ...[
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: rankColor,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '$rank',
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
              ],

              // Task 정보
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // 제목
                    Text(
                      task.title,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                        decoration: task.isCompleted
                            ? TextDecoration.lineThrough
                            : null,
                        color: task.isCompleted
                            ? theme.colorScheme.onSurface.withValues(alpha: 0.5)
                            : null,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              // 내일도 하기 버튼
              if (!isDragging)
                IconButton(
                  icon: const Icon(Icons.arrow_forward, size: 18),
                  tooltip: l10n?.copyToTomorrow ?? 'Copy to tomorrow',
                  onPressed: () {
                    context.read<PlannerBloc>().add(
                      CopyTaskToTomorrow(task.id),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(l10n?.copiedToTomorrow ?? 'Copied to tomorrow'),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                  visualDensity: VisualDensity.compact,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(
                    minWidth: 32,
                    minHeight: 32,
                  ),
                ),

              // 드래그 핸들
              Icon(
                Icons.drag_indicator,
                color: theme.colorScheme.outline.withValues(alpha: 0.5),
              ),
            ],
          ),

          // 이월 뱃지
          if (task.rolloverCount > 0)
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: theme.colorScheme.error,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  l10n?.rolloverBadge(task.rolloverCount) ??
                      'Rollover ${task.rolloverCount}x',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onError,
                    fontWeight: FontWeight.w500,
                    fontSize: 10,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

}
