import 'package:flutter/material.dart';

/// 브레인 덤프 / 빠른 할 일 추가 위젯
///
/// 날짜 지정 없이 빠르게 할 일을 입력하는 기능
///
/// 특징:
/// - 최소한의 입력 필드 (제목만 필수)
/// - 예상 시간 빠른 선택
/// - 키보드 단축키 지원 (Enter로 추가)
class TaskQuickAdd extends StatefulWidget {
  /// 할 일 추가 완료 콜백
  final void Function(String title, Duration? duration)? onAdd;

  /// 취소 콜백
  final VoidCallback? onCancel;

  const TaskQuickAdd({
    super.key,
    this.onAdd,
    this.onCancel,
  });

  @override
  State<TaskQuickAdd> createState() => _TaskQuickAddState();
}

class _TaskQuickAddState extends State<TaskQuickAdd> {
  final _titleController = TextEditingController();
  Duration? _selectedDuration;

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _submit() {
    final title = _titleController.text.trim();
    if (title.isEmpty) return;

    widget.onAdd?.call(title, _selectedDuration);
    _titleController.clear();
    _selectedDuration = null;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: 실제 UI 구현
    // - TextField (제목 입력)
    // - Duration 프리셋 칩들
    // - 추가 버튼
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(
              hintText: '할 일을 입력하세요...', // TODO: l10n
              border: OutlineInputBorder(),
            ),
            onSubmitted: (_) => _submit(),
            autofocus: true,
          ),
          const SizedBox(height: 12),
          // TODO: Duration 프리셋 칩들
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: widget.onCancel,
                child: const Text('취소'), // TODO: l10n
              ),
              const SizedBox(width: 8),
              FilledButton(
                onPressed: _submit,
                child: const Text('추가'), // TODO: l10n
              ),
            ],
          ),
        ],
      ),
    );
  }
}
