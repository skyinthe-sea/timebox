// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appName => '타임박스 플래너';

  @override
  String get inbox => '인박스';

  @override
  String get calendar => '캘린더';

  @override
  String get focus => '집중';

  @override
  String get analytics => '분석';

  @override
  String get settings => '설정';

  @override
  String get task => '할 일';

  @override
  String get tasks => '할 일 목록';

  @override
  String get addTask => '할 일 추가';

  @override
  String get editTask => '할 일 편집';

  @override
  String get deleteTask => '할 일 삭제';

  @override
  String get taskTitle => '제목';

  @override
  String get taskNote => '메모';

  @override
  String get estimatedDuration => '예상 소요 시간';

  @override
  String get subtasks => '하위 할 일';

  @override
  String get addSubtask => '하위 할 일 추가';

  @override
  String get priority => '우선순위';

  @override
  String get priorityHigh => '높음';

  @override
  String get priorityMedium => '보통';

  @override
  String get priorityLow => '낮음';

  @override
  String get status => '상태';

  @override
  String get statusTodo => '할 일';

  @override
  String get statusInProgress => '진행 중';

  @override
  String get statusCompleted => '완료';

  @override
  String get statusDelayed => '지연됨';

  @override
  String get statusSkipped => '건너뜀';

  @override
  String get tag => '태그';

  @override
  String get tags => '태그들';

  @override
  String get addTag => '태그 추가';

  @override
  String get timeBlock => '타임 블록';

  @override
  String get createTimeBlock => '타임 블록 생성';

  @override
  String get moveTimeBlock => '타임 블록 이동';

  @override
  String get resizeTimeBlock => '타임 블록 크기 조정';

  @override
  String get conflictDetected => '일정 충돌이 감지되었습니다';

  @override
  String get focusMode => '집중 모드';

  @override
  String get startFocus => '집중 시작';

  @override
  String get pauseFocus => '일시 정지';

  @override
  String get resumeFocus => '재개';

  @override
  String get completeFocus => '완료';

  @override
  String get skipFocus => '건너뛰기';

  @override
  String get timeRemaining => '남은 시간';

  @override
  String get today => '오늘';

  @override
  String get tomorrow => '내일';

  @override
  String get thisWeek => '이번 주';

  @override
  String get minutes => '분';

  @override
  String get hours => '시간';

  @override
  String minutesShort(int count) {
    return '$count분';
  }

  @override
  String hoursShort(int count) {
    return '$count시간';
  }

  @override
  String get productivityScore => '생산성 점수';

  @override
  String get plannedVsActual => '계획 vs 실제';

  @override
  String get completionRate => '완료율';

  @override
  String get rolloverTasks => '이월된 할 일';

  @override
  String get darkMode => '다크 모드';

  @override
  String get language => '언어';

  @override
  String get notifications => '알림';

  @override
  String get calendarSync => '캘린더 동기화';

  @override
  String get profile => '프로필';

  @override
  String get logout => '로그아웃';

  @override
  String get save => '저장';

  @override
  String get cancel => '취소';

  @override
  String get delete => '삭제';

  @override
  String get confirm => '확인';

  @override
  String get edit => '편집';

  @override
  String get done => '완료';

  @override
  String get emptyInbox => '인박스가 비어있습니다';

  @override
  String get emptyInboxDescription => '새로운 할 일을 추가해보세요';

  @override
  String get emptyCalendar => '오늘 일정이 없습니다';

  @override
  String get emptyCalendarDescription => '할 일을 드래그하여 일정을 만들어보세요';

  @override
  String get error => '오류';

  @override
  String get errorGeneric => '문제가 발생했습니다';

  @override
  String get errorNetwork => '네트워크 연결을 확인해주세요';

  @override
  String get retry => '다시 시도';
}
