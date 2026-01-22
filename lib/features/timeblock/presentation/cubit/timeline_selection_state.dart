import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// 타임라인 선택 모드
enum SelectionMode {
  /// 대기 상태 (선택 없음)
  idle,

  /// 선택 중 (롱프레스 + 드래그)
  selecting,

  /// 팝업 표시 중
  popupVisible,
}

/// 타임라인 선택 상태
///
/// 롱프레스-드래그 기반 시간 범위 선택 상태 관리
class TimelineSelectionState extends Equatable {
  final SelectionMode mode;

  /// 선택 시작 슬롯 인덱스 (0-47)
  /// 각 슬롯은 30분 단위
  final int? startSlotIndex;

  /// 선택 종료 슬롯 인덱스 (0-47)
  final int? endSlotIndex;

  /// 터치 위치 (드래그 중 시간 레이블 표시용)
  final Offset? touchPosition;

  /// 애니메이션 진행 중 여부
  final bool isAnimating;

  /// 선택 영역의 기준 날짜
  final DateTime? selectedDate;

  const TimelineSelectionState({
    this.mode = SelectionMode.idle,
    this.startSlotIndex,
    this.endSlotIndex,
    this.touchPosition,
    this.isAnimating = false,
    this.selectedDate,
  });

  /// 선택이 활성화되어 있는지
  bool get isSelecting => mode == SelectionMode.selecting;

  /// 팝업이 표시 중인지
  bool get isPopupVisible => mode == SelectionMode.popupVisible;

  /// 선택된 슬롯 범위가 유효한지
  bool get hasValidSelection =>
      startSlotIndex != null && endSlotIndex != null;

  /// 정렬된 시작 슬롯 (드래그 방향과 무관하게)
  int? get normalizedStartSlot {
    if (!hasValidSelection) return null;
    return startSlotIndex! < endSlotIndex!
        ? startSlotIndex
        : endSlotIndex;
  }

  /// 정렬된 종료 슬롯 (드래그 방향과 무관하게)
  int? get normalizedEndSlot {
    if (!hasValidSelection) return null;
    return startSlotIndex! < endSlotIndex!
        ? endSlotIndex
        : startSlotIndex;
  }

  /// 선택된 슬롯 개수
  int get selectedSlotCount {
    if (!hasValidSelection) return 0;
    return (normalizedEndSlot! - normalizedStartSlot!) + 1;
  }

  /// 선택된 총 시간 (분)
  int get selectedDurationMinutes => selectedSlotCount * 30;

  /// 슬롯 인덱스를 시간으로 변환
  /// 슬롯 0 = 00:00, 슬롯 1 = 00:30, 슬롯 2 = 01:00, ...
  static DateTime slotToTime(int slotIndex, DateTime date) {
    final hours = slotIndex ~/ 2;
    final minutes = (slotIndex % 2) * 30;
    return DateTime(date.year, date.month, date.day, hours, minutes);
  }

  /// 시간을 슬롯 인덱스로 변환
  static int timeToSlot(DateTime time) {
    return time.hour * 2 + (time.minute >= 30 ? 1 : 0);
  }

  /// 선택 시작 시간
  DateTime? get startTime {
    if (selectedDate == null || normalizedStartSlot == null) return null;
    return slotToTime(normalizedStartSlot!, selectedDate!);
  }

  /// 선택 종료 시간
  DateTime? get endTime {
    if (selectedDate == null || normalizedEndSlot == null) return null;
    // 종료 슬롯의 끝 시간 (슬롯 + 30분)
    return slotToTime(normalizedEndSlot! + 1, selectedDate!);
  }

  TimelineSelectionState copyWith({
    SelectionMode? mode,
    int? startSlotIndex,
    int? endSlotIndex,
    Offset? touchPosition,
    bool? isAnimating,
    DateTime? selectedDate,
    bool clearStartSlot = false,
    bool clearEndSlot = false,
    bool clearTouchPosition = false,
  }) {
    return TimelineSelectionState(
      mode: mode ?? this.mode,
      startSlotIndex:
          clearStartSlot ? null : (startSlotIndex ?? this.startSlotIndex),
      endSlotIndex:
          clearEndSlot ? null : (endSlotIndex ?? this.endSlotIndex),
      touchPosition:
          clearTouchPosition ? null : (touchPosition ?? this.touchPosition),
      isAnimating: isAnimating ?? this.isAnimating,
      selectedDate: selectedDate ?? this.selectedDate,
    );
  }

  @override
  List<Object?> get props => [
        mode,
        startSlotIndex,
        endSlotIndex,
        touchPosition,
        isAnimating,
        selectedDate,
      ];
}
