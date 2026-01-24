import 'package:flutter/material.dart';
import '../../../../config/themes/app_colors.dart';
import '../../../task/domain/entities/task.dart';
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
/// - 우선순위별 좌측 컬러바 + P1/P2/P3 배지 (스케일 펄스 애니메이션)
class TimeBlockCard extends StatefulWidget {
  /// 표시할 TimeBlock
  final TimeBlock timeBlock;

  /// 연결된 Task 제목 (Task가 연결된 경우)
  final String? taskTitle;

  /// 연결된 Task의 우선순위 (강조 표시용)
  final TaskPriority? priority;

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
    this.priority,
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
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Color?> _colorAnimation;
  Color? _previousColor;

  // 우선순위 스케일 펄스 애니메이션 (배지용)
  AnimationController? _priorityAnimationController;
  Animation<double>? _priorityScaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _previousColor = _getStatusColor(widget.timeBlock.status);
    _colorAnimation = AlwaysStoppedAnimation(_previousColor);

    _setupPriorityAnimation();
  }

  void _setupPriorityAnimation() {
    if (widget.priority != null) {
      // 우선순위별 애니메이션 속도 차등화
      final duration = _getPriorityAnimationDuration(widget.priority!);
      _priorityAnimationController = AnimationController(
        duration: duration,
        vsync: this,
      );

      // 스케일 펄스 애니메이션 (0.9 ~ 1.1 범위)
      _priorityScaleAnimation = Tween<double>(
        begin: 0.9,
        end: 1.1,
      ).animate(CurvedAnimation(
        parent: _priorityAnimationController!,
        curve: Curves.easeInOut,
      ));

      _priorityAnimationController!.repeat(reverse: true);
    }
  }

  Duration _getPriorityAnimationDuration(TaskPriority priority) {
    return switch (priority) {
      TaskPriority.high => const Duration(milliseconds: 1500),
      TaskPriority.medium => const Duration(milliseconds: 2500),
      TaskPriority.low => const Duration(milliseconds: 4000),
    };
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

    // 우선순위 변경 시 애니메이션 재설정
    if (oldWidget.priority != widget.priority) {
      _priorityAnimationController?.dispose();
      _priorityAnimationController = null;
      _priorityScaleAnimation = null;
      _setupPriorityAnimation();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _priorityAnimationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final title = widget.taskTitle ?? widget.timeBlock.title ?? '제목 없음';

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        final statusColor = _colorAnimation.value ?? _getStatusColor(widget.timeBlock.status);
        final priorityColor = widget.priority != null ? _getPriorityColor(widget.priority!) : null;
        final priorityBarWidth = widget.priority != null ? _getPriorityBarWidth(widget.priority!) : 0.0;

        return Hero(
          tag: 'timeblock_${widget.timeBlock.id}',
          child: Material(
            type: MaterialType.transparency,
            child: GestureDetector(
              onTap: widget.onTap,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: widget.height,
                margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Row(
                children: [
                  // 좌측 우선순위 컬러바
                  if (priorityColor != null)
                    Container(
                      width: priorityBarWidth,
                      color: priorityColor,
                    ),
                  // 메인 카드 콘텐츠
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: statusColor.withValues(alpha: 0.2),
                        border: Border(
                          left: priorityColor == null
                              ? BorderSide(color: statusColor, width: 2)
                              : BorderSide.none,
                          top: BorderSide(color: statusColor, width: 2),
                          right: BorderSide(color: statusColor, width: 2),
                          bottom: BorderSide(color: statusColor, width: 2),
                        ),
                      ),
                        child: _buildCardContent(theme, title, statusColor),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        );
      },
    );
  }

  Widget _buildCardContent(ThemeData theme, String title, Color color) {
    return Column(
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
                // 제목 (우선순위 배지 포함)
                Row(
                  children: [
                    if (widget.priority != null) _buildPriorityBadge(widget.priority!),
                    Expanded(
                      child: Text(
                        title,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
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
    );
  }

  /// 우선순위 P1/P2/P3 배지 (스케일 펄스 애니메이션 적용)
  Widget _buildPriorityBadge(TaskPriority priority) {
    final priorityColor = _getPriorityColor(priority);
    final rank = switch (priority) {
      TaskPriority.high => 1,
      TaskPriority.medium => 2,
      TaskPriority.low => 3,
    };

    final badge = Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      margin: const EdgeInsets.only(right: 6),
      decoration: BoxDecoration(
        color: priorityColor.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: priorityColor, width: 1),
      ),
      child: Text(
        'P$rank',
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: priorityColor,
        ),
      ),
    );

    // 스케일 애니메이션이 있으면 적용
    if (_priorityScaleAnimation != null) {
      return ScaleTransition(
        scale: _priorityScaleAnimation!,
        child: badge,
      );
    }

    return badge;
  }

  Color _getPriorityColor(TaskPriority priority) {
    return switch (priority) {
      TaskPriority.high => const Color(0xFFEF4444),    // Red
      TaskPriority.medium => const Color(0xFFF59E0B), // Amber
      TaskPriority.low => const Color(0xFF3B82F6),    // Blue
    };
  }

  /// 우선순위별 좌측 컬러바 너비
  double _getPriorityBarWidth(TaskPriority priority) {
    return switch (priority) {
      TaskPriority.high => 6.0,
      TaskPriority.medium => 5.0,
      TaskPriority.low => 4.0,
    };
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
