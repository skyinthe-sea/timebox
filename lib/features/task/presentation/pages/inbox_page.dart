import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/empty_state_widget.dart';
import '../../../../core/widgets/loading_indicator.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/task.dart';
import '../bloc/task_bloc.dart';
import '../widgets/task_list_item.dart';
import '../widgets/task_quick_add.dart';

/// 인박스 페이지
///
/// 할 일 목록을 관리하는 메인 화면
class InboxPage extends StatefulWidget {
  const InboxPage({super.key});

  @override
  State<InboxPage> createState() => _InboxPageState();
}

class _InboxPageState extends State<InboxPage> {
  @override
  void initState() {
    super.initState();
    // Task 목록 구독 시작
    context.read<TaskBloc>().add(const WatchTasksStarted());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n?.inbox ?? 'Inbox'),
        actions: [
          // 필터 메뉴
          PopupMenuButton<TaskStatus?>(
            icon: const Icon(Icons.filter_list),
            tooltip: l10n?.filter ?? 'Filter',
            onSelected: (status) {
              context.read<TaskBloc>().add(FilterChanged(status));
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: null,
                child: Text(l10n?.all ?? 'All'),
              ),
              PopupMenuItem(
                value: TaskStatus.todo,
                child: Text(l10n?.statusTodo ?? 'To Do'),
              ),
              PopupMenuItem(
                value: TaskStatus.done,
                child: Text(l10n?.statusDone ?? 'Done'),
              ),
            ],
          ),
        ],
      ),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state.status == TaskStateStatus.loading) {
            return const LoadingIndicator();
          }

          if (state.status == TaskStateStatus.failure) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 48,
                    color: theme.colorScheme.error,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    state.errorMessage ?? 'An error occurred',
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: () {
                      context.read<TaskBloc>().add(const WatchTasksStarted());
                    },
                    child: Text(l10n?.retry ?? 'Retry'),
                  ),
                ],
              ),
            );
          }

          final tasks = state.filteredTasks;

          if (tasks.isEmpty) {
            return EmptyStateWidget(
              icon: Icons.inbox_outlined,
              title: l10n?.emptyInboxTitle ?? 'No tasks yet',
              description: l10n?.emptyInboxDescription ??
                  'Add your first task to get started',
              actionText: l10n?.addTask ?? 'Add Task',
              onAction: () => TaskQuickAdd.show(context),
            );
          }

          return Column(
            children: [
              // 요약 헤더
              _buildSummaryHeader(context, state),

              // Task 목록
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: 8, bottom: 80),
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    return TaskListItem(
                      task: task,
                      onTap: () {
                        // TODO: Task 상세 페이지로 이동
                      },
                      onToggleComplete: () {
                        context
                            .read<TaskBloc>()
                            .add(ToggleTaskStatus(task.id));
                      },
                      onDelete: () {
                        context
                            .read<TaskBloc>()
                            .add(DeleteTaskEvent(task.id));
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => TaskQuickAdd.show(context),
        icon: const Icon(Icons.add),
        label: Text(l10n?.addTask ?? 'Add Task'),
      ),
    );
  }

  Widget _buildSummaryHeader(BuildContext context, TaskState state) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        border: Border(
          bottom: BorderSide(
            color: theme.colorScheme.outlineVariant,
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: [
          // 할 일 개수
          _SummaryChip(
            icon: Icons.radio_button_unchecked,
            label: '${state.todoCount} ${l10n?.toDo ?? 'to do'}',
            color: theme.colorScheme.primary,
          ),
          const SizedBox(width: 16),
          // 완료 개수
          _SummaryChip(
            icon: Icons.check_circle_outline,
            label: '${state.doneCount} ${l10n?.completed ?? 'done'}',
            color: theme.colorScheme.tertiary,
          ),
          const Spacer(),
          // 현재 필터
          if (state.filter != null)
            Chip(
              label: Text(
                state.filter == TaskStatus.todo
                    ? (l10n?.statusTodo ?? 'To Do')
                    : (l10n?.statusDone ?? 'Done'),
                style: theme.textTheme.labelSmall,
              ),
              deleteIcon: const Icon(Icons.close, size: 16),
              onDeleted: () {
                context.read<TaskBloc>().add(const FilterChanged(null));
              },
            ),
        ],
      ),
    );
  }
}

class _SummaryChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _SummaryChip({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 4),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: color,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
