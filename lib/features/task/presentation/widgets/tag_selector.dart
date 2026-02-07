import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/services/custom_tag_service.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/tag.dart';

/// 태그 선택 위젯
///
/// 기본 태그 + 커스텀 태그를 심플한 컬러 칩으로 표시
/// 다중 선택 가능, 커스텀 태그 추가 지원
class TagSelector extends StatefulWidget {
  /// 선택된 태그 목록
  final List<Tag> selectedTags;

  /// 선택 변경 콜백
  final ValueChanged<List<Tag>> onChanged;

  /// 커스텀 태그 서비스 (null이면 커스텀 태그 추가 불가)
  final CustomTagService? customTagService;

  /// 컴팩트 모드 (작은 크기)
  final bool compact;

  const TagSelector({
    super.key,
    required this.selectedTags,
    required this.onChanged,
    this.customTagService,
    this.compact = false,
  });

  /// 태그 ID로 다국어 이름 반환 (기본 태그만)
  static String getLocalizedTagName(BuildContext context, Tag tag) {
    final l10n = AppLocalizations.of(context);
    switch (tag.id) {
      case 'work':
        return l10n?.tagWork ?? '업무';
      case 'personal':
        return l10n?.tagPersonal ?? '개인';
      case 'health':
        return l10n?.tagHealth ?? '건강';
      case 'study':
        return l10n?.tagStudy ?? '학습';
      default:
        // 커스텀 태그는 저장된 이름 사용
        return tag.name;
    }
  }

  @override
  State<TagSelector> createState() => _TagSelectorState();
}

class _TagSelectorState extends State<TagSelector> {
  List<Tag> _allTags = [];

  @override
  void initState() {
    super.initState();
    _loadTags();
  }

  void _loadTags() {
    if (widget.customTagService != null) {
      _allTags = widget.customTagService!.getAllTags();
    } else {
      _allTags = DefaultTags.all;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: widget.compact ? 6 : 8,
      runSpacing: widget.compact ? 6 : 8,
      children: [
        // 기존 태그들
        ..._allTags.map((tag) {
          final isSelected = widget.selectedTags.any((t) => t.id == tag.id);
          return _buildTagChip(context, tag, isSelected);
        }),
        // 커스텀 태그 추가 버튼
        if (widget.customTagService != null) _buildAddTagButton(context),
      ],
    );
  }

  Widget _buildTagChip(BuildContext context, Tag tag, bool isSelected) {
    final theme = Theme.of(context);
    final localizedName = TagSelector.getLocalizedTagName(context, tag);

    return GestureDetector(
      onTap: () {
        final newSelection = List<Tag>.from(widget.selectedTags);
        if (isSelected) {
          newSelection.removeWhere((t) => t.id == tag.id);
        } else {
          if (!newSelection.any((t) => t.id == tag.id)) {
            newSelection.add(tag);
          }
        }
        widget.onChanged(newSelection);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: EdgeInsets.symmetric(
          horizontal: widget.compact ? 12 : 16,
          vertical: widget.compact ? 6 : 10,
        ),
        decoration: BoxDecoration(
          color: isSelected ? tag.color : theme.colorScheme.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(widget.compact ? 16 : 20),
          border: Border.all(
            color: isSelected ? tag.color : theme.colorScheme.outline.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 컬러 도트 (선택되지 않았을 때만)
            if (!isSelected) ...[
              Container(
                width: widget.compact ? 8 : 10,
                height: widget.compact ? 8 : 10,
                decoration: BoxDecoration(
                  color: tag.color,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: widget.compact ? 6 : 8),
            ],
            Text(
              localizedName,
              style: TextStyle(
                fontSize: widget.compact ? 12 : 14,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected
                    ? Colors.white
                    : theme.colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddTagButton(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    return GestureDetector(
      onTap: () => _showAddTagDialog(context),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: widget.compact ? 12 : 16,
          vertical: widget.compact ? 6 : 10,
        ),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(widget.compact ? 16 : 20),
          border: Border.all(
            color: theme.colorScheme.outline.withValues(alpha: 0.2),
            width: 1,
            style: BorderStyle.solid,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.add,
              size: widget.compact ? 14 : 18,
              color: theme.colorScheme.primary,
            ),
            SizedBox(width: widget.compact ? 4 : 6),
            Text(
              l10n?.addTag ?? '태그 추가',
              style: TextStyle(
                fontSize: widget.compact ? 12 : 14,
                fontWeight: FontWeight.w500,
                color: theme.colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showAddTagDialog(BuildContext context) async {
    final result = await showDialog<Tag>(
      context: context,
      builder: (context) => const _AddTagDialog(),
    );

    if (result != null && widget.customTagService != null) {
      await widget.customTagService!.addCustomTag(result);
      _loadTags();
      // 새로 만든 태그 자동 선택
      final newSelection = List<Tag>.from(widget.selectedTags)..add(result);
      widget.onChanged(newSelection);
    }
  }
}

/// 커스텀 태그 추가 다이얼로그
class _AddTagDialog extends StatefulWidget {
  const _AddTagDialog();

  @override
  State<_AddTagDialog> createState() => _AddTagDialogState();
}

class _AddTagDialogState extends State<_AddTagDialog> {
  final TextEditingController _nameController = TextEditingController();
  Color _selectedColor = TagColorPalette.colors[0];

  @override
  void initState() {
    super.initState();
    _nameController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Text(
        l10n?.newTag ?? '새 태그',
        style: theme.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 태그 이름 입력
          TextField(
            controller: _nameController,
            autofocus: true,
            decoration: InputDecoration(
              hintText: l10n?.tagNameHint ?? '태그 이름',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
            textCapitalization: TextCapitalization.words,
          ),
          const SizedBox(height: 20),

          // 색상 선택
          Text(
            l10n?.selectColor ?? '색상 선택',
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: theme.colorScheme.outline,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: TagColorPalette.colors.map((color) {
              final isSelected = _selectedColor == color;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedColor = color;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected
                          ? theme.colorScheme.onSurface
                          : Colors.transparent,
                      width: 3,
                    ),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: color.withValues(alpha: 0.4),
                              blurRadius: 8,
                              spreadRadius: 1,
                            )
                          ]
                        : null,
                  ),
                  child: isSelected
                      ? const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 20,
                        )
                      : null,
                ),
              );
            }).toList(),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n?.cancel ?? '취소'),
        ),
        FilledButton(
          onPressed: _nameController.text.trim().isEmpty
              ? null
              : () {
                  final name = _nameController.text.trim();
                  if (name.isNotEmpty) {
                    final tag = Tag(
                      id: 'custom_${const Uuid().v4()}',
                      name: name,
                      color: _selectedColor,
                    );
                    Navigator.of(context).pop(tag);
                  }
                },
          child: Text(l10n?.add ?? '추가'),
        ),
      ],
    );
  }
}
