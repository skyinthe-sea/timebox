import 'package:flutter/material.dart';
import '../../domain/entities/time_block.dart';

/// 타임라인 뷰 위젯
///
/// 수직 시간축에 TimeBlock들을 표시하는 핵심 UI 컴포넌트
///
/// 기능:
/// - 시간 눈금 표시 (1시간 단위)
/// - 현재 시간 표시선
/// - TimeBlock 카드 렌더링
/// - 드롭 타겟 (DragTarget)
/// - 스크롤 및 줌
class TimelineView extends StatefulWidget {
  /// 표시할 날짜
  final DateTime date;

  /// TimeBlock 목록
  final List<TimeBlock> timeBlocks;

  /// 시작 시간 (기본: 6시)
  final int startHour;

  /// 종료 시간 (기본: 24시)
  final int endHour;

  /// 1시간당 높이 (dp)
  final double hourHeight;

  /// TimeBlock 탭 콜백
  final void Function(TimeBlock)? onTimeBlockTap;

  /// Task 드롭 콜백
  final void Function(String taskId, DateTime dropTime)? onTaskDropped;

  /// TimeBlock 이동 콜백
  final void Function(String id, DateTime newStartTime)? onTimeBlockMoved;

  /// TimeBlock 리사이즈 콜백
  final void Function(String id, DateTime newStart, DateTime newEnd)?
      onTimeBlockResized;

  const TimelineView({
    super.key,
    required this.date,
    required this.timeBlocks,
    this.startHour = 6,
    this.endHour = 24,
    this.hourHeight = 60,
    this.onTimeBlockTap,
    this.onTaskDropped,
    this.onTimeBlockMoved,
    this.onTimeBlockResized,
  });

  @override
  State<TimelineView> createState() => _TimelineViewState();
}

class _TimelineViewState extends State<TimelineView> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    // 현재 시간으로 스크롤
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToCurrentTime();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToCurrentTime() {
    final now = DateTime.now();
    if (now.hour >= widget.startHour && now.hour < widget.endHour) {
      final offset = (now.hour - widget.startHour) * widget.hourHeight;
      _scrollController.animateTo(
        offset,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final totalHours = widget.endHour - widget.startHour;

    // TODO: 실제 구현
    // - 시간 눈금 (왼쪽)
    // - 타임블록 영역 (오른쪽)
    // - DragTarget으로 드롭 처리
    // - 현재 시간 표시선
    return SingleChildScrollView(
      controller: _scrollController,
      child: SizedBox(
        height: totalHours * widget.hourHeight,
        child: Row(
          children: [
            // 시간 눈금
            SizedBox(
              width: 50,
              child: Column(
                children: List.generate(
                  totalHours,
                  (index) => SizedBox(
                    height: widget.hourHeight,
                    child: Text(
                      '${widget.startHour + index}:00',
                      style: theme.textTheme.bodySmall,
                    ),
                  ),
                ),
              ),
            ),
            // 타임블록 영역
            Expanded(
              child: Stack(
                children: [
                  // 시간 구분선
                  ...List.generate(
                    totalHours,
                    (index) => Positioned(
                      top: index * widget.hourHeight,
                      left: 0,
                      right: 0,
                      child: const Divider(height: 1),
                    ),
                  ),
                  // TODO: TimeBlock 카드들
                  // TODO: 현재 시간 표시선
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
