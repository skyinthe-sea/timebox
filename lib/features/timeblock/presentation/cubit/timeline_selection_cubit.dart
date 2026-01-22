import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'timeline_selection_state.dart';

/// 타임라인 선택 Cubit
///
/// 롱프레스-드래그 기반 시간 범위 선택 상태 관리
class TimelineSelectionCubit extends Cubit<TimelineSelectionState> {
  TimelineSelectionCubit() : super(const TimelineSelectionState());

  /// 슬롯 높이 (픽셀) - 30분 = 30dp
  static const double slotHeight = 30.0;

  /// 시간당 높이 (픽셀)
  static const double hourHeight = slotHeight * 2;

  /// 롱프레스 시작 - 선택 모드 활성화
  void startSelection({
    required int slotIndex,
    required DateTime date,
    required Offset touchPosition,
  }) {
    // 햅틱 피드백 (미디엄 임팩트)
    HapticFeedback.mediumImpact();

    emit(TimelineSelectionState(
      mode: SelectionMode.selecting,
      startSlotIndex: slotIndex,
      endSlotIndex: slotIndex,
      touchPosition: touchPosition,
      selectedDate: date,
      isAnimating: true,
    ));

    // 애니메이션 완료 후 플래그 해제
    Future.delayed(const Duration(milliseconds: 300), () {
      if (state.mode == SelectionMode.selecting) {
        emit(state.copyWith(isAnimating: false));
      }
    });
  }

  /// 드래그로 선택 영역 업데이트
  void updateSelection({
    required int slotIndex,
    required Offset touchPosition,
  }) {
    if (state.mode != SelectionMode.selecting) return;

    // 슬롯 범위 제한 (0-47)
    final clampedSlot = slotIndex.clamp(0, 47);

    emit(state.copyWith(
      endSlotIndex: clampedSlot,
      touchPosition: touchPosition,
    ));

    // 가벼운 햅틱 피드백 (슬롯 변경 시)
    if (clampedSlot != state.endSlotIndex) {
      HapticFeedback.selectionClick();
    }
  }

  /// 선택 완료 - 팝업 표시
  void finishSelection() {
    if (state.mode != SelectionMode.selecting) return;
    if (!state.hasValidSelection) {
      cancelSelection();
      return;
    }

    // 햅틱 피드백 (라이트 임팩트)
    HapticFeedback.lightImpact();

    emit(state.copyWith(
      mode: SelectionMode.popupVisible,
      isAnimating: true,
      clearTouchPosition: true,
    ));

    // 애니메이션 완료 후 플래그 해제
    Future.delayed(const Duration(milliseconds: 400), () {
      if (state.mode == SelectionMode.popupVisible) {
        emit(state.copyWith(isAnimating: false));
      }
    });
  }

  /// 선택 취소
  void cancelSelection() {
    HapticFeedback.lightImpact();

    emit(state.copyWith(
      mode: SelectionMode.idle,
      isAnimating: true,
      clearStartSlot: true,
      clearEndSlot: true,
      clearTouchPosition: true,
    ));

    // 애니메이션 완료 후 플래그 해제
    Future.delayed(const Duration(milliseconds: 200), () {
      emit(state.copyWith(isAnimating: false));
    });
  }

  /// 태스크 할당 완료 - 선택 초기화
  void completeAssignment() {
    HapticFeedback.heavyImpact();

    emit(state.copyWith(
      mode: SelectionMode.idle,
      isAnimating: true,
      clearStartSlot: true,
      clearEndSlot: true,
      clearTouchPosition: true,
    ));

    // 애니메이션 완료 후 플래그 해제
    Future.delayed(const Duration(milliseconds: 400), () {
      emit(state.copyWith(isAnimating: false));
    });
  }

  /// Y 좌표를 슬롯 인덱스로 변환
  /// [yPosition] 타임라인 뷰 내에서의 Y 좌표
  /// [startHour] 타임라인 시작 시간 (기본 0)
  static int yPositionToSlot(double yPosition, {int startHour = 0}) {
    final slotFromViewTop = (yPosition / slotHeight).floor();
    final totalSlot = (startHour * 2) + slotFromViewTop;
    return totalSlot.clamp(0, 47);
  }

  /// 슬롯 인덱스를 Y 좌표로 변환
  /// [slotIndex] 슬롯 인덱스 (0-47)
  /// [startHour] 타임라인 시작 시간 (기본 0)
  static double slotToYPosition(int slotIndex, {int startHour = 0}) {
    final adjustedSlot = slotIndex - (startHour * 2);
    return adjustedSlot * slotHeight;
  }

  /// 슬롯 인덱스를 시간 문자열로 변환
  static String slotToTimeString(int slotIndex) {
    final hours = slotIndex ~/ 2;
    final minutes = (slotIndex % 2) * 30;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
  }

  /// 선택 영역의 시간 범위 문자열
  String? get selectedTimeRangeString {
    if (!state.hasValidSelection) return null;
    final start = slotToTimeString(state.normalizedStartSlot!);
    final end = slotToTimeString(state.normalizedEndSlot! + 1);
    return '$start - $end';
  }
}
