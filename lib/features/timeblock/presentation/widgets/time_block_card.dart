import 'package:flutter/material.dart';
import '../../../../config/themes/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../task/domain/entities/task.dart';
import '../../domain/entities/time_block.dart';

/// 블록 높이에 따른 레이아웃 모드
enum _TimeBlockLayoutMode {
  /// < 25dp (~15분): 색상바만 표시
  minimal,
  /// 25-40dp (~30분): 제목만
  small,
  /// 40-55dp (~45분): 제목 + 시간
  medium,
  /// > 55dp (1시간+): 제목 + 시간 + 상태
  large,
}

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

  /// 리사이즈 콜백 (상단) - 드래그 중 매 프레임 호출
  final void Function(double delta)? onResizeTop;

  /// 리사이즈 콜백 (하단) - 드래그 중 매 프레임 호출
  final void Function(double delta)? onResizeBottom;

  /// 리사이즈 시작 콜백 (상단)
  final VoidCallback? onResizeTopStart;

  /// 리사이즈 종료 콜백 (상단)
  final VoidCallback? onResizeTopEnd;

  /// 리사이즈 시작 콜백 (하단)
  final VoidCallback? onResizeBottomStart;

  /// 리사이즈 종료 콜백 (하단)
  final VoidCallback? onResizeBottomEnd;

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
    this.onResizeTopStart,
    this.onResizeTopEnd,
    this.onResizeBottomStart,
    this.onResizeBottomEnd,
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

  bool _isFirstBuild = true;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _colorAnimation = const AlwaysStoppedAnimation(null);

    _setupPriorityAnimation();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isFirstBuild) {
      _isFirstBuild = false;
      _previousColor = _getStatusColor(widget.timeBlock.status);
      _colorAnimation = AlwaysStoppedAnimation(_previousColor);
    }
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
    final l10n = AppLocalizations.of(context);
    final title = widget.taskTitle ?? widget.timeBlock.title ?? (l10n?.noTitle ?? 'Untitled');

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

  /// 블록 높이에 따른 레이아웃 모드 결정
  _TimeBlockLayoutMode _getLayoutMode() {
    if (widget.height < 25) return _TimeBlockLayoutMode.minimal;
    if (widget.height < 40) return _TimeBlockLayoutMode.small;
    if (widget.height < 55) return _TimeBlockLayoutMode.medium;
    return _TimeBlockLayoutMode.large;
  }

  Widget _buildCardContent(ThemeData theme, String title, Color color) {
    final layoutMode = _getLayoutMode();

    return Stack(
      children: [
        // 메인 콘텐츠 (레이아웃 모드에 따라 다르게 빌드)
        switch (layoutMode) {
          _TimeBlockLayoutMode.minimal => _buildMinimalContent(),
          _TimeBlockLayoutMode.small => _buildSmallContent(theme, title),
          _TimeBlockLayoutMode.medium => _buildMediumContent(theme, title),
          _TimeBlockLayoutMode.large => _buildLargeContent(theme, title),
        },
        // 리사이즈 핸들 (상단) - 오버레이
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: _buildResizeHandle(
            onUpdate: widget.onResizeTop,
            onStart: widget.onResizeTopStart,
            onEnd: widget.onResizeTopEnd,
            isTop: true,
          ),
        ),
        // 리사이즈 핸들 (하단) - 오버레이
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: _buildResizeHandle(
            onUpdate: widget.onResizeBottom,
            onStart: widget.onResizeBottomStart,
            onEnd: widget.onResizeBottomEnd,
            isTop: false,
          ),
        ),
      ],
    );
  }

  /// Minimal 레이아웃 (< 25dp): 색상바로만 식별
  Widget _buildMinimalContent() {
    return const Padding(
      padding: EdgeInsets.all(2),
      child: SizedBox.shrink(),
    );
  }

  /// Small 레이아웃 (25-40dp): 제목만 표시
  Widget _buildSmallContent(ThemeData theme, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      child: Center(
        child: Row(
          children: [
            if (widget.priority != null) _buildCompactPriorityBadge(widget.priority!),
            Expanded(
              child: Text(
                title,
                style: theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 11,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Medium 레이아웃 (40-55dp): 제목 + 시간
  Widget _buildMediumContent(ThemeData theme, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 제목 (우선순위 배지 포함)
          Flexible(
            child: Row(
              children: [
                if (widget.priority != null) _buildPriorityBadge(widget.priority!),
                Expanded(
                  child: Text(
                    title,
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 2),
          // 시간
          Flexible(
            child: Text(
              _formatTimeRange(),
              style: theme.textTheme.bodySmall?.copyWith(fontSize: 10),
            ),
          ),
        ],
      ),
    );
  }

  /// Large 레이아웃 (> 55dp): 제목 + 시간 + 상태
  Widget _buildLargeContent(ThemeData theme, String title) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 제목 (우선순위 배지 포함)
          Flexible(
            child: Row(
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
          ),
          // 시간
          Flexible(
            child: Text(
              _formatTimeRange(),
              style: theme.textTheme.bodySmall,
            ),
          ),
          // 상태 표시
          if (widget.timeBlock.status == TimeBlockStatus.completed)
            Flexible(
              child: Row(
                children: [
                  Icon(Icons.check_circle,
                      size: 12,
                      color: theme.brightness == Brightness.dark
                          ? AppColors.successDark
                          : AppColors.successLight),
                  const SizedBox(width: 4),
                  Text(
                    l10n?.complete ?? 'Complete',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.brightness == Brightness.dark
                          ? AppColors.successDark
                          : AppColors.successLight,
                    ),
                  ),
                ],
              ),
            )
          else if (widget.timeBlock.status == TimeBlockStatus.skipped)
            Flexible(
              child: Row(
                children: [
                  Icon(Icons.cancel,
                      size: 12,
                      color: theme.brightness == Brightness.dark
                          ? AppColors.errorDark
                          : AppColors.errorLight),
                  const SizedBox(width: 4),
                  Text(
                    l10n?.incomplete ?? 'Incomplete',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.brightness == Brightness.dark
                          ? AppColors.errorDark
                          : AppColors.errorLight,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
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

  /// 컴팩트 우선순위 배지 (small 레이아웃용)
  Widget _buildCompactPriorityBadge(TaskPriority priority) {
    final priorityColor = _getPriorityColor(priority);
    final rank = switch (priority) {
      TaskPriority.high => 1,
      TaskPriority.medium => 2,
      TaskPriority.low => 3,
    };

    final badge = Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
      margin: const EdgeInsets.only(right: 4),
      decoration: BoxDecoration(
        color: priorityColor.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(3),
        border: Border.all(color: priorityColor, width: 1),
      ),
      child: Text(
        'P$rank',
        style: TextStyle(
          fontSize: 9,
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

  Widget _buildResizeHandle({
    required void Function(double)? onUpdate,
    VoidCallback? onStart,
    VoidCallback? onEnd,
    bool isTop = true,
  }) {
    if (onUpdate == null) return const SizedBox.shrink();

    // 터치 영역 확장 (UI는 8px, 터치는 24px)
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onVerticalDragStart: onStart != null ? (_) => onStart() : null,
      onVerticalDragUpdate: (details) => onUpdate(details.delta.dy),
      onVerticalDragEnd: onEnd != null ? (_) => onEnd() : null,
      child: Container(
        height: 24, // 확장된 터치 영역
        alignment: isTop ? Alignment.topCenter : Alignment.bottomCenter,
        child: Container(
          height: 8, // 실제 보이는 UI
          decoration: BoxDecoration(
            color: Colors.grey.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(4),
          ),
          child: const Center(
            child: Icon(Icons.drag_handle, size: 12),
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(TimeBlockStatus status) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return switch (status) {
      TimeBlockStatus.pending => isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280),
      TimeBlockStatus.inProgress => isDark ? const Color(0xFF60A5FA) : const Color(0xFF3B82F6),
      TimeBlockStatus.completed => isDark ? AppColors.successDark : AppColors.successLight,
      TimeBlockStatus.delayed => isDark ? AppColors.warningDark : AppColors.warningLight,
      TimeBlockStatus.skipped => isDark ? AppColors.errorDark : AppColors.errorLight,
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
