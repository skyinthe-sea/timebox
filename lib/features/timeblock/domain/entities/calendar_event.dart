/// CalendarEvent 엔티티
///
/// 외부 캘린더(Google, Outlook, Apple)에서 가져온 일정
///
/// TimeBlock으로 변환되어 캘린더에 '점유된 시간'으로 표시됨
class CalendarEvent {
  /// 외부 일정 고유 ID
  final String id;

  /// 제공자 (google, outlook, apple)
  final String provider;

  /// 일정 제목
  final String title;

  /// 일정 설명 (선택)
  final String? description;

  /// 시작 시간
  final DateTime startTime;

  /// 종료 시간
  final DateTime endTime;

  /// 종일 일정 여부
  final bool isAllDay;

  /// 위치 (선택)
  final String? location;

  /// 색상 코드 (선택)
  final int? colorValue;

  /// 읽기 전용 여부 (외부 일정은 보통 읽기 전용)
  final bool isReadOnly;

  /// 반복 일정 여부
  final bool isRecurring;

  /// 원본 캘린더 이름
  final String? calendarName;

  const CalendarEvent({
    required this.id,
    required this.provider,
    required this.title,
    this.description,
    required this.startTime,
    required this.endTime,
    this.isAllDay = false,
    this.location,
    this.colorValue,
    this.isReadOnly = true,
    this.isRecurring = false,
    this.calendarName,
  });

  /// 소요 시간
  Duration get duration => endTime.difference(startTime);

  /// TimeBlock으로 변환
  // TimeBlock toTimeBlock() {
  //   return TimeBlock(
  //     id: 'external_$id',
  //     startTime: startTime,
  //     endTime: endTime,
  //     isExternal: true,
  //     externalEventId: id,
  //     externalProvider: provider,
  //     title: title,
  //     colorValue: colorValue,
  //   );
  // }

  // TODO: copyWith, props (Equatable), toJson/fromJson 구현
}
