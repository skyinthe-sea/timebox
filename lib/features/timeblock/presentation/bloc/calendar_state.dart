part of 'calendar_bloc.dart';

/// Calendar BLoC 상태
enum CalendarStateStatus { initial, loading, success, failure }

class CalendarState extends Equatable {
  final CalendarStateStatus status;
  final DateTime selectedDate;
  final List<TimeBlock> timeBlocks;
  final String? errorMessage;

  CalendarState({
    this.status = CalendarStateStatus.initial,
    DateTime? selectedDate,
    this.timeBlocks = const [],
    this.errorMessage,
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

  CalendarState copyWith({
    CalendarStateStatus? status,
    DateTime? selectedDate,
    List<TimeBlock>? timeBlocks,
    String? errorMessage,
    bool clearError = false,
  }) {
    return CalendarState(
      status: status ?? this.status,
      selectedDate: selectedDate ?? this.selectedDate,
      timeBlocks: timeBlocks ?? this.timeBlocks,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [status, selectedDate, timeBlocks, errorMessage];
}
