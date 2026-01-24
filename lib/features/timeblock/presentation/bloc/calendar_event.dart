part of 'calendar_bloc.dart';

/// Calendar BLoC 이벤트
sealed class CalendarEvent {
  const CalendarEvent();
}

/// 특정 날짜의 TimeBlock 로드
class LoadTimeBlocks extends CalendarEvent {
  final DateTime date;
  const LoadTimeBlocks(this.date);
}

/// TimeBlock 실시간 구독 시작
class WatchTimeBlocksStarted extends CalendarEvent {
  final DateTime date;
  const WatchTimeBlocksStarted(this.date);
}

/// TimeBlock 목록 업데이트 (내부용)
class TimeBlocksUpdated extends CalendarEvent {
  final List<TimeBlock> timeBlocks;
  const TimeBlocksUpdated(this.timeBlocks);
}

/// 날짜 변경
class DateChanged extends CalendarEvent {
  final DateTime date;
  const DateChanged(this.date);
}

/// 오늘로 이동
class GoToToday extends CalendarEvent {
  const GoToToday();
}

/// TimeBlock 생성 (Task를 시간에 배치)
class CreateTimeBlockEvent extends CalendarEvent {
  final String? taskId;
  final String? title;
  final DateTime startTime;
  final DateTime endTime;
  final int? colorValue;

  const CreateTimeBlockEvent({
    this.taskId,
    this.title,
    required this.startTime,
    required this.endTime,
    this.colorValue,
  });
}

/// TimeBlock 이동 (드래그)
class MoveTimeBlockEvent extends CalendarEvent {
  final String id;
  final DateTime newStartTime;

  const MoveTimeBlockEvent({required this.id, required this.newStartTime});
}

/// TimeBlock 크기 조정
class ResizeTimeBlockEvent extends CalendarEvent {
  final String id;
  final DateTime newStartTime;
  final DateTime newEndTime;

  const ResizeTimeBlockEvent({
    required this.id,
    required this.newStartTime,
    required this.newEndTime,
  });
}

/// TimeBlock 삭제
class DeleteTimeBlockEvent extends CalendarEvent {
  final String id;
  const DeleteTimeBlockEvent(this.id);
}

/// TimeBlock 상태 변경
class UpdateTimeBlockStatusEvent extends CalendarEvent {
  final String id;
  final TimeBlockStatus status;

  const UpdateTimeBlockStatusEvent({required this.id, required this.status});
}

/// 인접 TimeBlock 병합
/// 같은 Task를 가진 인접한 블록들을 하나로 합침
class MergeTimeBlocksEvent extends CalendarEvent {
  final String taskId;
  final DateTime startTime;
  final DateTime endTime;

  const MergeTimeBlocksEvent({
    required this.taskId,
    required this.startTime,
    required this.endTime,
  });
}

/// TimeBlock 확장 (기존 블록에 시간 추가)
class ExtendTimeBlockEvent extends CalendarEvent {
  final String id;
  final DateTime newStartTime;
  final DateTime newEndTime;

  const ExtendTimeBlockEvent({
    required this.id,
    required this.newStartTime,
    required this.newEndTime,
  });
}

/// 만료된 TimeBlock 일괄 실패 처리
/// 종료 시간이 현재 시간보다 과거인데 완료되지 않은 블록들을 skipped로 변경
class MarkExpiredAsSkippedEvent extends CalendarEvent {
  const MarkExpiredAsSkippedEvent();
}
