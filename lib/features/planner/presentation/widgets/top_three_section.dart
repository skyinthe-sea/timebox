import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../task/domain/entities/task.dart';
import '../bloc/planner_bloc.dart';
import 'top_three_slot.dart';

/// Top 3 섹션 위젯
///
/// 가장 중요한 3가지 할 일을 표시하는 가로 배열 섹션
class TopThreeSection extends StatelessWidget {
  const TopThreeSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return BlocBuilder<PlannerBloc, PlannerState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // 섹션 제목
              Row(
                children: [
                  Icon(
                    Icons.star_rounded,
                    size: 20,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    l10n?.top3 ?? 'Top 3',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Top 3 슬롯들
              Row(
                children: [
                  Expanded(
                    child: TopThreeSlot(
                      rank: 1,
                      task: state.rank1Task,
                      color: AppColors.rank1,
                      onTaskDropped: (task) => _onTaskDropped(context, 1, task),
                      onTaskRemoved: () => _onTaskRemoved(context, 1),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TopThreeSlot(
                      rank: 2,
                      task: state.rank2Task,
                      color: AppColors.rank2,
                      onTaskDropped: (task) => _onTaskDropped(context, 2, task),
                      onTaskRemoved: () => _onTaskRemoved(context, 2),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TopThreeSlot(
                      rank: 3,
                      task: state.rank3Task,
                      color: AppColors.rank3,
                      onTaskDropped: (task) => _onTaskDropped(context, 3, task),
                      onTaskRemoved: () => _onTaskRemoved(context, 3),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _onTaskDropped(BuildContext context, int rank, Task task) {
    HapticFeedback.mediumImpact();
    context.read<PlannerBloc>().add(SetTopThreeTask(
          rank: rank,
          taskId: task.id,
        ));
  }

  void _onTaskRemoved(BuildContext context, int rank) {
    HapticFeedback.lightImpact();
    context.read<PlannerBloc>().add(RemoveTopThreeTask(rank));
  }
}
