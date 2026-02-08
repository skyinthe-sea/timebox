import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/duration_presets.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/task.dart';
import '../bloc/task_bloc.dart';

/// 빠른 할 일 추가 다이얼로그
///
/// 브레인 덤프 기능 - 최소한의 입력으로 빠르게 할 일 추가
class TaskQuickAdd extends StatefulWidget {
  const TaskQuickAdd({super.key});

  /// 다이얼로그 표시
  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => const TaskQuickAdd(),
    );
  }

  @override
  State<TaskQuickAdd> createState() => _TaskQuickAddState();
}

class _TaskQuickAddState extends State<TaskQuickAdd> {
  final _titleController = TextEditingController();
  final _noteController = TextEditingController();
  Duration _selectedDuration = DurationPresets.short;
  TaskPriority _selectedPriority = TaskPriority.medium;
  bool _showAdvanced = false;

  @override
  void dispose() {
    _titleController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + bottomInset),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 핸들
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: theme.colorScheme.outlineVariant,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // 제목 입력
          TextField(
            controller: _titleController,
            autofocus: true,
            decoration: InputDecoration(
              hintText: l10n?.taskTitleHint ?? 'What do you need to do?',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              prefixIcon: const Icon(Icons.add_task),
            ),
            textInputAction: TextInputAction.next,
            onSubmitted: (_) => _submit(),
          ),
          const SizedBox(height: 12),

          // 예상 시간 선택
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: DurationPresets.all.map((duration) {
                final isSelected = _selectedDuration == duration;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(DurationPresets.getLabel(duration, AppLocalizations.of(context)!)),
                    selected: isSelected,
                    onSelected: (_) {
                      setState(() => _selectedDuration = duration);
                    },
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 12),

          // 고급 옵션 토글
          TextButton.icon(
            onPressed: () => setState(() => _showAdvanced = !_showAdvanced),
            icon: Icon(_showAdvanced ? Icons.expand_less : Icons.expand_more),
            label: Text(_showAdvanced
                ? (l10n?.lessOptions ?? 'Less options')
                : (l10n?.moreOptions ?? 'More options')),
          ),

          // 고급 옵션
          if (_showAdvanced) ...[
            const SizedBox(height: 8),

            // 메모
            TextField(
              controller: _noteController,
              maxLines: 2,
              decoration: InputDecoration(
                hintText: l10n?.taskNoteHint ?? 'Add a note...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // 우선순위
            Text(
              l10n?.priority ?? 'Priority',
              style: theme.textTheme.labelLarge,
            ),
            const SizedBox(height: 8),
            SegmentedButton<TaskPriority>(
              segments: [
                ButtonSegment(
                  value: TaskPriority.low,
                  label: Text(l10n?.priorityLow ?? 'Low'),
                  icon: const Icon(Icons.arrow_downward, size: 16),
                ),
                ButtonSegment(
                  value: TaskPriority.medium,
                  label: Text(l10n?.priorityMedium ?? 'Medium'),
                ),
                ButtonSegment(
                  value: TaskPriority.high,
                  label: Text(l10n?.priorityHigh ?? 'High'),
                  icon: const Icon(Icons.arrow_upward, size: 16),
                ),
              ],
              selected: {_selectedPriority},
              onSelectionChanged: (selection) {
                setState(() => _selectedPriority = selection.first);
              },
            ),
          ],

          const SizedBox(height: 16),

          // 저장 버튼
          FilledButton.icon(
            onPressed: _submit,
            icon: const Icon(Icons.add),
            label: Text(l10n?.addTask ?? 'Add Task'),
          ),
        ],
      ),
    );
  }

  void _submit() {
    final title = _titleController.text.trim();
    if (title.isEmpty) return;

    context.read<TaskBloc>().add(CreateTaskEvent(
          title: title,
          note: _noteController.text.trim().isNotEmpty
              ? _noteController.text.trim()
              : null,
          estimatedDuration: _selectedDuration,
          priority: _selectedPriority,
        ));

    Navigator.of(context).pop();
  }
}
