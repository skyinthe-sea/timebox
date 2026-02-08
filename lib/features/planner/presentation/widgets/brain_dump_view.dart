import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../task/domain/entities/task_suggestion.dart';
import '../bloc/planner_bloc.dart';
import 'animated_task_entry.dart';
import 'draggable_task_card.dart';

/// 브레인 덤프 뷰 위젯
///
/// 아직 일정에 배치되지 않은 Task 목록을 표시
class BrainDumpView extends StatefulWidget {
  const BrainDumpView({super.key});

  @override
  State<BrainDumpView> createState() => _BrainDumpViewState();
}

class _BrainDumpViewState extends State<BrainDumpView> {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    _textController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _textController.removeListener(_onTextChanged);
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    _debounceTimer?.cancel();
    final query = _textController.text.trim();
    if (query.isEmpty) {
      context.read<PlannerBloc>().add(const ClearTaskSuggestions());
      return;
    }
    _debounceTimer = Timer(const Duration(milliseconds: 300), () {
      context.read<PlannerBloc>().add(RequestTaskSuggestions(query));
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return BlocBuilder<PlannerBloc, PlannerState>(
      builder: (context, state) {
        final tasks = state.brainDumpTasks;
        final suggestions = state.suggestions;

        return Column(
          children: [
            // Quick Add 영역
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                border: Border(
                  bottom: BorderSide(
                    color: isDark ? AppColors.borderDark : AppColors.borderLight,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n?.brainDump ?? 'Brain Dump',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      // 입력 필드
                      Expanded(
                        child: TextField(
                          controller: _textController,
                          focusNode: _focusNode,
                          decoration: InputDecoration(
                            hintText: l10n?.taskTitleHint ?? 'What needs to be done?',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.send_rounded),
                              onPressed: _submitTask,
                            ),
                          ),
                          textInputAction: TextInputAction.send,
                          onSubmitted: (_) => _submitTask(),
                        ),
                      ),
                    ],
                  ),
                  // 자동완성 제안 목록
                  if (suggestions.isNotEmpty)
                    _SuggestionList(
                      suggestions: suggestions,
                      onTap: _selectSuggestion,
                    ),
                ],
              ),
            ),

            // Task 목록
            Expanded(
              child: tasks.isEmpty
                  ? _EmptyState(l10n: l10n, theme: theme)
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        final task = tasks[index];
                        final isNewlyCreated =
                            state.lastCreatedTaskId == task.id;

                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 4,
                          ),
                          child: AnimatedTaskEntry(
                            animate: isNewlyCreated,
                            onAnimationComplete: () {
                              context
                                  .read<PlannerBloc>()
                                  .add(const ClearLastCreatedTask());
                            },
                            child: DraggableTaskCard(
                              task: task,
                              rank: state.getTaskRank(task.id),
                              isScheduled: state.isTaskScheduled(task.id),
                              onDelete: () {
                                context
                                    .read<PlannerBloc>()
                                    .add(DeleteBrainDumpTask(task.id));
                              },
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        );
      },
    );
  }

  void _selectSuggestion(TaskSuggestion suggestion) {
    _textController.removeListener(_onTextChanged);
    _textController.text = suggestion.title;
    _textController.addListener(_onTextChanged);

    context.read<PlannerBloc>().add(const ClearTaskSuggestions());
    context.read<PlannerBloc>().add(QuickCreateTask(
          title: suggestion.title,
          estimatedDuration: suggestion.avgEstimatedDuration,
        ));

    _textController.clear();
    _focusNode.requestFocus();
  }

  void _submitTask() {
    final title = _textController.text.trim();
    if (title.isEmpty) return;

    context.read<PlannerBloc>().add(const ClearTaskSuggestions());
    context.read<PlannerBloc>().add(QuickCreateTask(
          title: title,
          // 기본값 사용: estimatedDuration = 30분, priority = medium
        ));

    _textController.clear();
    _focusNode.requestFocus();
  }
}

class _SuggestionList extends StatelessWidget {
  final List<TaskSuggestion> suggestions;
  final ValueChanged<TaskSuggestion> onTap;

  const _SuggestionList({
    required this.suggestions,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Container(
        decoration: BoxDecoration(
          color: isDark
              ? AppColors.surfaceDark
              : AppColors.surfaceLight,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isDark ? AppColors.borderDark : AppColors.borderLight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
              child: Text(
                l10n?.suggestedTasks ?? 'Suggestions',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.outline,
                ),
              ),
            ),
            ...suggestions.map((suggestion) {
              return InkWell(
                onTap: () => onTap(suggestion),
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.history_rounded,
                        size: 16,
                        color: theme.colorScheme.outline,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          suggestion.title,
                          style: theme.textTheme.bodyMedium,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primaryContainer
                              .withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '${suggestion.frequency}x',
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final AppLocalizations? l10n;
  final ThemeData theme;

  const _EmptyState({
    required this.l10n,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.lightbulb_outline_rounded,
              size: 64,
              color: theme.colorScheme.outline.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 16),
            Text(
              l10n?.emptyInboxTitle ?? 'No tasks yet',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.outline,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              l10n?.emptyInboxDescription ?? 'Add your first task above',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.outline.withValues(alpha: 0.7),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
