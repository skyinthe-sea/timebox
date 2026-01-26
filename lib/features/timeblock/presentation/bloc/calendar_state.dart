part of 'calendar_bloc.dart';

/// Calendar BLoC 상태
enum CalendarStateStatus { initial, loading, success, failure }

class CalendarState extends Equatable {
  final CalendarStateStatus status;
  final DateTime selectedDate;
  final List<TimeBlock> timeBlocks;
  final String? errorMessage;

  /// 최근에 실패 처리된 TimeBlock ID 목록 (애니메이션용)
  final List<String> recentlySkippedIds;

  CalendarState({
    this.status = CalendarStateStatus.initial,
    DateTime? selectedDate,
    this.timeBlocks = const [],
    this.errorMessage,
    this.recentlySkippedIds = const [],
  }) : selectedDate = selectedDate ?? DateTime.now();

  /// 현재 선택된 날짜가 오늘인지
  bool get isToday {
    final now = DateTime.now();
    return selectedDate.year == now.year &&
        selectedDate.month == now.month &&
        selectedDate.day == now.day;
  }

  /// 진행 중인 TimeBlock
  TimeBlock? get currentTimeBlock {
    final now = DateTime.now();
    try {
      return timeBlocks.firstWhere(
        (tb) =>
            tb.startTime.isBefore(now) &&
            tb.endTime.isAfter(now) &&
            !tb.isCompleted,
      );
    } catch (_) {
      return null;
    }
  }

  /// 다음 예정 TimeBlock
  TimeBlock? get nextTimeBlock {
    final now = DateTime.now();
    try {
      return timeBlocks.firstWhere(
        (tb) => tb.startTime.isAfter(now) && tb.status == TimeBlockStatus.pending,
      );
    } catch (_) {
      return null;
    }
  }

  /// TimeBlock 기반 완료율 (0.0 ~ 1.0)
  double get completionRate {
    if (timeBlocks.isEmpty) return 0.0;
    final completedCount = timeBlocks.where((tb) => tb.isCompleted).length;
    return completedCount / timeBlocks.length;
  }

  CalendarState copyWith({
    CalendarStateStatus? status,
    DateTime? selectedDate,
    List<TimeBlock>? timeBlocks,
    String? errorMessage,
    bool clearError = false,
    List<String>? recentlySkippedIds,
    bool clearRecentlySkipped = false,
  }) {
    return CalendarState(
      status: status ?? this.status,
      selectedDate: selectedDate ?? this.selectedDate,
      timeBlocks: timeBlocks ?? this.timeBlocks,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      recentlySkippedIds: clearRecentlySkipped
          ? const []
          : (recentlySkippedIds ?? this.recentlySkippedIds),
    );
  }

  @override
  List<Object?> get props =>
      [status, selectedDate, timeBlocks, errorMessage, recentlySkippedIds];
}
