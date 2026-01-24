import 'package:flutter/material.dart';
import '../../../../config/themes/app_colors.dart';
import '../../domain/entities/time_block.dart';

/// 타임블록 카드 위젯
///
/// 타임라인에 표시되는 개별 시간 블록
///
/// 기능:
/// - 드래그 가능 (LongPressDraggable)
/// - 리사이즈 핸들 (상단/하단)
/// - 상태별 색상 표시
/// - 탭하여 포커스 모드 진입
/// - 상태 변경 시 색상 애니메이션
class TimeBlockCard extends StatefulWidget {
  /// 표시할 TimeBlock
  final TimeBlock timeBlock;

  /// 연결된 Task 제목 (Task가 연결된 경우)
  final String? taskTitle;

  /// 카드 높이 (duration에 따라 계산됨)
  final double height;

  /// 탭 콜백
  final VoidCallback? onTap;

  /// 드래그 시작 콜백
  final VoidCallback? onDragStarted;

  /// 드래그 완료 콜백
  final void Function(Offset)? onDragEnd;

  /// 리사이즈 콜백 (상단)
  final void Function(double delta)? onResizeTop;

  /// 리사이즈 콜백 (하단)
  final void Function(double delta)? onResizeBottom;

  /// 애니메이션 여부 (실패 처리 시 true)
  final bool animateToSkipped;

  const TimeBlockCard({
    super.key,
    required this.timeBlock,
    this.taskTitle,
    required this.height,
    this.onTap,
    this.onDragStarted,
    this.onDragEnd,
    this.onResizeTop,
    this.onResizeBottom,
    this.animateToSkipped = false,
  });

  @override
  State<TimeBlockCard> createState() => _TimeBlockCardState();
}

class _TimeBlockCardState extends State<TimeBlockCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Color?> _colorAnimation;
  Color? _previousColor;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _previousColor = _getStatusColor(widget.timeBlock.status);
    _colorAnimation = AlwaysStoppedAnimation(_previousColor);
  }

  @override
  void didUpdateWidget(TimeBlockCard oldWidget) {
    super.didUpdateWidget(oldWidget);

    // 상태가 변경되었거나 애니메이션 플래그가 켜진 경우
    if (oldWidget.timeBlock.status != widget.timeBlock.status ||
        (widget.animateToSkipped && !oldWidget.animateToSkipped)) {
      final newColor = _getStatusColor(widget.timeBlock.status);
      _colorAnimation = ColorTween(
        begin: _previousColor,
        end: newColor,
      ).animate(CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ));
      _animationController.forward(from: 0).then((_) {
        _previousColor = newColor;
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final title = widget.taskTitle ?? widget.timeBlock.title ?? '제목 없음';

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        final color = _colorAnimation.value ?? _getStatusColor(widget.timeBlock.status);

        return GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: widget.height,
            margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: color, width: 2),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 리사이즈 핸들 (상단)
                _buildResizeHandle(widget.onResizeTop),

                // 내용
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 제목
                        Text(
                          title,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        // 시간
                        Text(
                          _formatTimeRange(),
                          style: theme.textTheme.bodySmall,
                        ),
                        // 상태 표시
                        if (widget.timeBlock.status == TimeBlockStatus.completed)
                          Row(
                            children: [
                              Icon(Icons.check_circle,
                                  size: 12, color: AppColors.successLight),
                              const SizedBox(width: 4),
                              Text(
                                '완료',
                                style: theme.textTheme.labelSmall?.copyWith(
                                  color: AppColors.successLight,
                                ),
                              ),
                            ],
                          )
                        else if (widget.timeBlock.status == TimeBlockStatus.skipped)
                          Row(
                            children: [
                              Icon(Icons.cancel,
                                  size: 12, color: AppColors.errorLight),
                              const SizedBox(width: 4),
                              Text(
                                '미완료',
                                style: theme.textTheme.labelSmall?.copyWith(
                                  color: AppColors.errorLight,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),

                // 리사이즈 핸들 (하단)
                _buildResizeHandle(widget.onResizeBottom),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildResizeHandle(void Function(double)? onResize) {
    if (onResize == null) return const SizedBox.shrink();

    return GestureDetector(
      onVerticalDragUpdate: (details) => onResize(details.delta.dy),
      child: Container(
        height: 8,
        decoration: BoxDecoration(
          color: Colors.grey.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(4),
        ),
        child: const Center(
          child: Icon(Icons.drag_handle, size: 12),
        ),
      ),
    );
  }

  Color _getStatusColor(TimeBlockStatus status) {
    return switch (status) {
      TimeBlockStatus.pending => const Color(0xFF6B7280),
      TimeBlockStatus.inProgress => const Color(0xFF3B82F6),
      TimeBlockStatus.completed => AppColors.successLight,
      TimeBlockStatus.delayed => const Color(0xFFF59E0B),
      TimeBlockStatus.skipped => AppColors.errorLight,
    };
  }

  String _formatTimeRange() {
    final startHour = widget.timeBlock.startTime.hour.toString().padLeft(2, '0');
    final startMin = widget.timeBlock.startTime.minute.toString().padLeft(2, '0');
    final endHour = widget.timeBlock.endTime.hour.toString().padLeft(2, '0');
    final endMin = widget.timeBlock.endTime.minute.toString().padLeft(2, '0');
    return '$startHour:$startMin - $endHour:$endMin';
  }
}
