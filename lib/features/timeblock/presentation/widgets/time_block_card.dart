import 'package:flutter/material.dart';
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
class TimeBlockCard extends StatelessWidget {
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
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final title = taskTitle ?? timeBlock.title ?? '제목 없음';
    final color = _getStatusColor(timeBlock.status);

    // TODO: LongPressDraggable 래핑
    // TODO: GestureDetector로 리사이즈 핸들 구현
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
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
            _buildResizeHandle(onResizeTop),

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
                  ],
                ),
              ),
            ),

            // 리사이즈 핸들 (하단)
            _buildResizeHandle(onResizeBottom),
          ],
        ),
      ),
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
      TimeBlockStatus.completed => const Color(0xFF10B981),
      TimeBlockStatus.delayed => const Color(0xFFF59E0B),
      TimeBlockStatus.skipped => const Color(0xFFEF4444),
    };
  }

  String _formatTimeRange() {
    final startHour = timeBlock.startTime.hour.toString().padLeft(2, '0');
    final startMin = timeBlock.startTime.minute.toString().padLeft(2, '0');
    final endHour = timeBlock.endTime.hour.toString().padLeft(2, '0');
    final endMin = timeBlock.endTime.minute.toString().padLeft(2, '0');
    return '$startHour:$startMin - $endHour:$endMin';
  }
}
