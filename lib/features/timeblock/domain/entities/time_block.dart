/// TimeBlock 엔티티
///
/// 캘린더에 배치된 시간 블록을 나타내는 도메인 객체
///
/// Task를 특정 시간에 배치하면 TimeBlock이 생성됨
/// 드래그 앤 드롭, 리사이징의 대상
class TimeBlock {
  /// 고유 식별자
  final String id;

  /// 연결된 Task ID (외부 일정인 경우 null)
  final String? taskId;

  /// 시작 시간 (계획)
  final DateTime startTime;

  /// 종료 시간 (계획)
  final DateTime endTime;

  /// 실제 시작 시간 (실행 후 기록)
  final DateTime? actualStart;

  /// 실제 종료 시간 (실행 후 기록)
  final DateTime? actualEnd;

  /// 외부 캘린더 일정 여부
  final bool isExternal;

  /// 외부 일정 ID (Google Calendar 등)
  final String? externalEventId;

  /// 외부 일정 제공자 (google, outlook, apple)
  final String? externalProvider;

  /// 실행 상태
  final TimeBlockStatus status;

  /// 블록 색상 (Task 또는 외부 캘린더에서 상속)
  final int? colorValue;

  /// 블록 제목 (외부 일정용, Task 연결 시 Task.title 사용)
  final String? title;

  const TimeBlock({
    required this.id,
    this.taskId,
    required this.startTime,
    required this.endTime,
    this.actualStart,
    this.actualEnd,
    this.isExternal = false,
    this.externalEventId,
    this.externalProvider,
    this.status = TimeBlockStatus.pending,
    this.colorValue,
    this.title,
  });

  /// 계획된 소요 시간
  Duration get plannedDuration => endTime.difference(startTime);

  /// 실제 소요 시간 (완료된 경우만)
  Duration? get actualDuration {
    if (actualStart == null || actualEnd == null) return null;
    return actualEnd!.difference(actualStart!);
  }

  /// 시간 오차 (실제 - 계획)
  Duration? get timeDifference {
    if (actualDuration == null) return null;
    return actualDuration! - plannedDuration;
  }

  /// 진행 중인지 확인
  bool get isInProgress => status == TimeBlockStatus.inProgress;

  /// 완료되었는지 확인
  bool get isCompleted => status == TimeBlockStatus.completed;

  TimeBlock copyWith({
    String? id,
    String? taskId,
    DateTime? startTime,
    DateTime? endTime,
    DateTime? actualStart,
    DateTime? actualEnd,
    bool? isExternal,
    String? externalEventId,
    String? externalProvider,
    TimeBlockStatus? status,
    int? colorValue,
    String? title,
  }) {
    return TimeBlock(
      id: id ?? this.id,
      taskId: taskId ?? this.taskId,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      actualStart: actualStart ?? this.actualStart,
      actualEnd: actualEnd ?? this.actualEnd,
      isExternal: isExternal ?? this.isExternal,
      externalEventId: externalEventId ?? this.externalEventId,
      externalProvider: externalProvider ?? this.externalProvider,
      status: status ?? this.status,
      colorValue: colorValue ?? this.colorValue,
      title: title ?? this.title,
    );
  }
}

/// 타임블록 실행 상태
enum TimeBlockStatus {
  /// 예정됨 (시작 전)
  pending,

  /// 진행 중
  inProgress,

  /// 완료됨
  completed,

  /// 지연됨 (예정 시간 초과)
  delayed,

  /// 건너뜀
  skipped,
}
