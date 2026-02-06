import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/services/custom_tag_service.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../task/domain/entities/tag.dart';
import '../../../task/domain/entities/task.dart';
import '../../../task/presentation/widgets/tag_selector.dart';
import '../cubit/timeline_selection_cubit.dart';
import '../cubit/timeline_selection_state.dart';
import 'jiggling_task_button.dart';

/// 브레인덤프 팝업
///
/// 선택 영역 옆에 플로팅으로 표시되는 태스크 선택 팝업
/// 2단계 흐름: 1) 태스크 선택 → 2) 태그 선택
class BrainDumpPopup extends StatefulWidget {
  final List<Task> unscheduledTasks;
  final TimelineSelectionState selectionState;
  final void Function(Task task, DateTime startTime, DateTime endTime,
      List<Tag> tags)? onTaskSelected;
  final void Function(String title, DateTime startTime, DateTime endTime,
      List<Tag> tags)? onNewTaskCreated;
  final VoidCallback? onCancel;

  const BrainDumpPopup({
    super.key,
    required this.unscheduledTasks,
    required this.selectionState,
    this.onTaskSelected,
    this.onNewTaskCreated,
    this.onCancel,
  });

  @override
  State<BrainDumpPopup> createState() => _BrainDumpPopupState();
}

class _BrainDumpPopupState extends State<BrainDumpPopup>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  final TextEditingController _newTaskController = TextEditingController();
  final FocusNode _newTaskFocusNode = FocusNode();
  bool _showNewTaskInput = false;

  // 2단계 태그 선택을 위한 상태
  bool _showTagSelection = false;
  Task? _selectedTask;
  String? _newTaskTitle;
  List<Tag> _selectedTags = [];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.95,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));

    _controller.forward();

    if (widget.unscheduledTasks.isEmpty) {
      _showNewTaskInput = true;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _newTaskController.dispose();
    _newTaskFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selectionState = widget.selectionState;
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;

    return GestureDetector(
      onTap: widget.onCancel,
      behavior: HitTestBehavior.opaque,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Container(
          color: Colors.black38,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                left: 24,
                right: 24,
                top: 24,
                bottom: 24 + bottomPadding,
              ),
              child: Center(
                child: GestureDetector(
                  onTap: () {}, // 내부 탭 이벤트 소비
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: Material(
                      elevation: 16,
                      borderRadius: BorderRadius.circular(20),
                      color: theme.colorScheme.surface,
                      child: Container(
                        width: double.infinity,
                        constraints: const BoxConstraints(
                          maxWidth: 400,
                          maxHeight: 450,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: theme.colorScheme.outlineVariant
                                .withValues(alpha: 0.5),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // 헤더
                            _buildHeader(context, selectionState),

                            Divider(
                              height: 1,
                              color: theme.colorScheme.outlineVariant,
                            ),

                            // 2단계 태그 선택 또는 1단계 태스크 선택
                            Flexible(
                              child: _showTagSelection
                                  ? _buildTagSelectionContent(
                                      context, selectionState)
                                  : _showNewTaskInput
                                      ? _buildNewTaskInput(
                                          context, selectionState)
                                      : _buildTaskList(context, selectionState),
                            ),

                            // 새 태스크 추가 버튼 (1단계에서만)
                            if (!_showNewTaskInput && !_showTagSelection)
                              _buildAddNewButton(context),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(
      BuildContext context, TimelineSelectionState selectionState) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    final startTime = TimelineSelectionCubit.slotToTimeString(
        selectionState.normalizedStartSlot!);
    final endTime = TimelineSelectionCubit.slotToTimeString(
        selectionState.normalizedEndSlot! + 1);

    // 2단계에서는 선택된 태스크 표시
    final headerTitle = _showTagSelection
        ? (_selectedTask?.title ?? _newTaskTitle ?? '')
        : null;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 시간대 표시
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.schedule,
                        size: 18,
                        color: theme.colorScheme.onPrimaryContainer,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '$startTime - $endTime',
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ],
                  ),
                ),
                // 2단계: 선택된 태스크명 표시
                if (_showTagSelection && headerTitle != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    headerTitle,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    l10n?.selectTag ?? '태그 선택',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.outline,
                    ),
                  ),
                ],
              ],
            ),
          ),
          IconButton(
            onPressed:
                _showTagSelection ? _goBackToTaskSelection : widget.onCancel,
            icon: Icon(_showTagSelection ? Icons.arrow_back : Icons.close),
            iconSize: 20,
            style: IconButton.styleFrom(
              backgroundColor: theme.colorScheme.surfaceContainerHighest,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskList(
      BuildContext context, TimelineSelectionState selectionState) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    if (widget.unscheduledTasks.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Text(
            l10n?.noUnscheduledTasks ?? 'No unscheduled tasks',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.outline,
            ),
          ),
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: widget.unscheduledTasks.asMap().entries.map((entry) {
          final index = entry.key;
          final task = entry.value;

          return JigglingTaskButton(
            task: task,
            isJiggling: true,
            jiggleDelay: index * 50,
            onTap: () => _onTaskTapped(task),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildNewTaskInput(
      BuildContext context, TimelineSelectionState selectionState) {
    final l10n = AppLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _newTaskController,
            focusNode: _newTaskFocusNode,
            autofocus: true,
            decoration: InputDecoration(
              hintText: l10n?.addNewTaskHint ?? 'Enter task title...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
            textInputAction: TextInputAction.done,
            onSubmitted: (value) =>
                _onNewTaskInputSubmitted(value, selectionState),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              if (widget.unscheduledTasks.isNotEmpty)
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        _showNewTaskInput = false;
                        _newTaskController.clear();
                      });
                    },
                    child: Text(l10n?.cancel ?? 'Cancel'),
                  ),
                ),
              if (widget.unscheduledTasks.isNotEmpty) const SizedBox(width: 12),
              Expanded(
                child: FilledButton(
                  onPressed: () => _onNewTaskInputSubmitted(
                    _newTaskController.text,
                    selectionState,
                  ),
                  child: Text(l10n?.add ?? 'Add'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 태그 선택 화면 (2단계)
  Widget _buildTagSelectionContent(
      BuildContext context, TimelineSelectionState selectionState) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 태그 선택 위젯
          TagSelector(
            selectedTags: _selectedTags,
            onChanged: (tags) {
              setState(() {
                _selectedTags = tags;
              });
            },
            customTagService: GetIt.instance<CustomTagService>(),
          ),

          const SizedBox(height: 24),

          // 확인/취소 버튼
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _goBackToTaskSelection,
                  child: Text(l10n?.cancel ?? 'Cancel'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton(
                  onPressed: () => _confirmSelection(selectionState),
                  style: FilledButton.styleFrom(
                    backgroundColor: _selectedTags.isNotEmpty
                        ? _selectedTags.first.color
                        : theme.colorScheme.primary,
                  ),
                  child: Text(l10n?.confirm ?? 'Confirm'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 태스크 선택 시 호출
  void _onTaskTapped(Task task) {
    setState(() {
      _selectedTask = task;
      _newTaskTitle = null;
      // 태스크에 이미 태그가 있으면 해당 태그 선택
      _selectedTags = task.tags.isNotEmpty
          ? task.tags
          : [];
      _showTagSelection = true;
    });
  }

  /// 새 태스크 입력 후 호출
  void _onNewTaskInputSubmitted(
      String value, TimelineSelectionState selectionState) {
    final trimmed = value.trim();
    if (trimmed.isNotEmpty) {
      setState(() {
        _newTaskTitle = trimmed;
        _selectedTask = null;
        _selectedTags = [];
        _showTagSelection = true;
        _newTaskController.clear();
      });
    }
  }

  /// 태스크 선택 화면으로 돌아가기
  void _goBackToTaskSelection() {
    setState(() {
      _showTagSelection = false;
      _selectedTask = null;
      _newTaskTitle = null;
      _selectedTags = [];
    });
  }

  /// 최종 확인 (태그와 함께 타임블록 생성)
  void _confirmSelection(TimelineSelectionState selectionState) {
    if (selectionState.startTime == null || selectionState.endTime == null) {
      return;
    }

    if (_selectedTask != null) {
      widget.onTaskSelected?.call(
        _selectedTask!,
        selectionState.startTime!,
        selectionState.endTime!,
        _selectedTags,
      );
    } else if (_newTaskTitle != null) {
      widget.onNewTaskCreated?.call(
        _newTaskTitle!,
        selectionState.startTime!,
        selectionState.endTime!,
        _selectedTags,
      );
    }
  }

  Widget _buildAddNewButton(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: theme.colorScheme.outlineVariant),
        ),
      ),
      child: TextButton.icon(
        onPressed: () {
          setState(() {
            _showNewTaskInput = true;
          });
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _newTaskFocusNode.requestFocus();
          });
        },
        icon: const Icon(Icons.add, size: 20),
        label: Text(l10n?.addNewTask ?? 'Add new task'),
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }
}
