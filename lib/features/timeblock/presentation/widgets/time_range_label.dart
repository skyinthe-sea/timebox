import 'package:flutter/material.dart';

import '../cubit/timeline_selection_cubit.dart';

/// 플로팅 시간 레이블
///
/// 드래그 중 선택 영역의 시간 범위를 표시
/// - 손가락 근처에 플로팅
/// - "10:00 - 11:30" 형식
class TimeRangeLabel extends StatelessWidget {
  /// 시작 슬롯 인덱스 (0-47)
  final int startSlot;

  /// 종료 슬롯 인덱스 (0-47)
  final int endSlot;

  /// 터치 위치 (글로벌 좌표)
  final Offset position;

  const TimeRangeLabel({
    super.key,
    required this.startSlot,
    required this.endSlot,
    required this.position,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;

    // 시간 범위 문자열 생성
    final startTime = TimelineSelectionCubit.slotToTimeString(startSlot);
    final endTime = TimelineSelectionCubit.slotToTimeString(endSlot + 1);
    final timeRange = '$startTime - $endTime';

    // 총 선택 시간 계산
    final totalSlots = (endSlot - startSlot + 1);
    final totalMinutes = totalSlots * 30;
    final durationText = totalMinutes >= 60
        ? '${totalMinutes ~/ 60}h ${totalMinutes % 60 > 0 ? '${totalMinutes % 60}m' : ''}'
        : '${totalMinutes}m';

    // 레이블 위치 계산 (손가락 위쪽, 화면 경계 고려)
    const labelWidth = 120.0;
    const offsetY = -60.0; // 손가락 위쪽으로
    const offsetX = -labelWidth / 2; // 중앙 정렬

    var labelX = position.dx + offsetX;
    var labelY = position.dy + offsetY;

    // 화면 경계 조정
    if (labelX < 8) labelX = 8;
    if (labelX + labelWidth > screenSize.width - 8) {
      labelX = screenSize.width - labelWidth - 8;
    }
    if (labelY < 8) labelY = position.dy + 60; // 아래로 이동

    return Positioned(
      left: labelX,
      top: labelY,
      child: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(12),
        color: theme.colorScheme.surface,
        shadowColor: theme.colorScheme.shadow.withValues(alpha: 0.3),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: theme.colorScheme.primary.withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                timeRange,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                durationText.trim(),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.outline,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
