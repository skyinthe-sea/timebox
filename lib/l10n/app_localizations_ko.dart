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

  @override
  String get noActiveSession => '진행 중인 세션이 없습니다';

  @override
  String get startFocusDescription => '집중 세션을 시작하여 생산성을 높여보세요';

  @override
  String get quickStart => '빠른 시작';

  @override
  String get paused => '일시 정지됨';

  @override
  String get skip => '건너뛰기';

  @override
  String get complete => '완료';

  @override
  String get sessionCompleted => '세션 완료!';

  @override
  String get selectDuration => '시간 선택';

  @override
  String get filter => '필터';

  @override
  String get all => '전체';

  @override
  String get statusDone => '완료됨';

  @override
  String get emptyInboxTitle => '인박스가 비어있습니다';

  @override
  String get toDo => '할 일';

  @override
  String get completed => '완료됨';

  @override
  String get deleteTaskConfirm => '이 할 일을 삭제하시겠습니까?';

  @override
  String get taskTitleHint => '무엇을 해야 하나요?';

  @override
  String get lessOptions => '옵션 숨기기';

  @override
  String get moreOptions => '더 많은 옵션';

  @override
  String get taskNoteHint => '메모 추가...';

  @override
  String get title => '제목';

  @override
  String get timeBlockTitleHint => '블록 이름 입력';

  @override
  String get startTime => '시작 시간';

  @override
  String get endTime => '종료 시간';

  @override
  String get add => '추가';

  @override
  String get top3 => '가장 중요한 3가지';

  @override
  String get rank1 => '1순위';

  @override
  String get rank2 => '2순위';

  @override
  String get rank3 => '3순위';

  @override
  String get brainDump => '브레인 덤프';

  @override
  String get timeline => '타임라인';

  @override
  String get dragToSchedule => '끌어서 일정 추가';

  @override
  String get emptyTop3Slot => '탭하거나 드래그하여 추가';

  @override
  String get dayStartTime => '하루 시작 시간';

  @override
  String get dayEndTime => '하루 종료 시간';

  @override
  String get planner => '타임박스';

  @override
  String get copyToTomorrow => '내일도 하기';

  @override
  String get copiedToTomorrow => '내일로 복사되었습니다';

  @override
  String rolloverBadge(int count) {
    return '이월 $count회';
  }

  @override
  String get appearance => '외관';

  @override
  String get theme => '테마';

  @override
  String get themeSystem => '시스템 설정';

  @override
  String get themeLight => '라이트';

  @override
  String get themeDark => '다크';

  @override
  String get notificationDescription => '타임박스 알림 받기';

  @override
  String get notificationTiming => '알림 시간';

  @override
  String minutesBefore(int count) {
    return '$count분 전';
  }

  @override
  String get noCalendarConnected => '연결된 캘린더 없음';

  @override
  String get comingSoon => '준비 중입니다';

  @override
  String get timeSettings => '시간 설정';

  @override
  String get dayTimeRange => '하루 시간 범위';

  @override
  String get defaultTimeBlockDuration => '기본 타임박스 길이';

  @override
  String get data => '데이터';

  @override
  String get exportData => '데이터 내보내기';

  @override
  String get exportDataDescription => 'CSV 파일로 내보내기';

  @override
  String get resetSettings => '설정 초기화';

  @override
  String get resetSettingsConfirm => '모든 설정을 초기화하시겠습니까?';

  @override
  String get settingsReset => '설정이 초기화되었습니다';

  @override
  String get longPressToSelect => '길게 눌러서 시간 범위 선택';

  @override
  String get selectTask => '할 일 선택';

  @override
  String get noUnscheduledTasks => '미배정 할 일이 없습니다';

  @override
  String get addNewTask => '새 할 일 추가';

  @override
  String get addNewTaskHint => '할 일 제목 입력...';

  @override
  String timeRangeLabel(String start, String end) {
    return '$start - $end';
  }

  @override
  String get assignToTimeBlock => '타임블록에 할당';

  @override
  String get mergeBlocks => '블록 병합';

  @override
  String get overlapWarning => '경고: 타임블록이 겹칩니다';

  @override
  String get taskAssigned => '할 일이 할당되었습니다';

  @override
  String get tapToCancel => '바깥을 탭하여 취소';

  @override
  String get statistics => '통계';

  @override
  String get todayHighlights => '오늘의 하이라이트';

  @override
  String get completedTasksCount => '완료한 Task';

  @override
  String get focusTimeMinutes => '집중 시간';

  @override
  String get timeSavedMinutes => '절약한 시간';

  @override
  String get top3Achievement => 'Top 3 달성';

  @override
  String get trend => '트렌드';

  @override
  String get tagAnalysis => '태그별 분석';

  @override
  String get insights => '인사이트';

  @override
  String get daily => '일간';

  @override
  String get weekly => '주간';

  @override
  String get monthly => '월간';

  @override
  String get focusModeTooltip => '집중 모드';

  @override
  String get startAlarm => '시작 알림';

  @override
  String get endAlarm => '종료 알림';

  @override
  String get notifyBeforeStart => '시작 전 알림';

  @override
  String get notifyBeforeEnd => '종료 전 알림';

  @override
  String get selectMultipleTimings => '여러 시간을 선택할 수 있습니다';

  @override
  String get dailyReminder => '일일 리마인더';

  @override
  String get dailyReminderDesc => '앱을 열지 않은 날 알림 받기';

  @override
  String get dailyReminderTime => '리마인더 시간';

  @override
  String get notificationPermissionRequired => '알림 권한이 필요합니다';

  @override
  String get notificationPermissionDesc => '타임블록 알림을 받으려면 알림 권한을 허용해주세요';

  @override
  String get openSettings => '설정 열기';

  @override
  String get permissionGranted => '권한 허용됨';

  @override
  String get permissionDenied => '권한 거부됨';

  @override
  String get requestPermission => '권한 요청';

  @override
  String hourBefore(int count) {
    return '$count시간 전';
  }

  @override
  String get alarmSettings => '알림 설정';

  @override
  String get alarmTimingNote => '다중 선택 가능';

  @override
  String get noonTime => '정오 (12:00)';

  @override
  String get mathChallenge => '수학 문제';

  @override
  String mathChallengeProgress(int current, int total) {
    return '$current / $total';
  }

  @override
  String get enterAnswer => '답 입력';

  @override
  String get wrongAnswer => '틀렸습니다. 다시 시도하세요.';

  @override
  String get focusLockEnabled => '화면 잠금 활성화됨';

  @override
  String get overlayPermissionRequired => '오버레이 권한이 필요합니다';

  @override
  String get noActiveTimeBlock => '진행 중인 타임블록이 없습니다';

  @override
  String get createTimeBlockFirst => '캘린더에서 타임블록을 먼저 생성하세요';

  @override
  String get exitFocus => '종료하기';

  @override
  String get statsCompletionRates => '완료율';

  @override
  String get statsTaskPipeline => 'Task 흐름';

  @override
  String get statsPlanVsActual => '계획 vs 실제';

  @override
  String get statsPriorityBreakdown => '우선순위별 성과';

  @override
  String get statsFocusSummary => '집중 분석';

  @override
  String get statsTopInsights => '인사이트';

  @override
  String get statsScheduled => '스케줄';

  @override
  String get statsCompleted => '완료';

  @override
  String get statsRolledOver => '이월';

  @override
  String get statsEfficiency => '효율';

  @override
  String get statsNoData => '아직 데이터가 없어요';

  @override
  String get navTimeline => '타임라인';

  @override
  String get navReport => '리포트';

  @override
  String get suggestedTasks => '추천 할 일';

  @override
  String get taskSuggestionsHint => '이전에 자주 했던 할 일이에요';

  @override
  String get topSuccessTasks => '가장 잘 완료하는 Task';

  @override
  String get topFailureTasks => '완료가 어려운 Task';

  @override
  String get completionCount => '완료 횟수';

  @override
  String get taskRankings => 'Task 랭킹';

  @override
  String get privacyPolicy => '개인정보처리방침';

  @override
  String get termsOfService => '이용약관';

  @override
  String get privacyPolicyContent =>
      '개인정보처리방침\n\n최종 수정일: 2026년 1월 1일\n\n1. 수집 항목\n본 앱은 할 일, 시간 기록 등 사용자가 직접 입력한 앱 사용 데이터를 처리합니다.\n\n2. 저장 방식\n모든 데이터는 사용자의 기기 내에 로컬로만 저장되며, 외부 서버로 전송되지 않습니다.\n\n3. 제3자 제공\n본 앱은 광고 표시를 위해 Google AdMob을 사용합니다. AdMob은 광고 식별자를 수집할 수 있습니다. 자세한 내용은 Google 개인정보처리방침을 참고하세요.\n\n4. 데이터 삭제\n앱을 삭제하면 기기에 저장된 모든 데이터가 자동으로 삭제됩니다.\n\n5. 문의\n개인정보 관련 문의: myclick90@gmail.com';

  @override
  String get termsOfServiceContent =>
      '이용약관\n\n최종 수정일: 2026년 1월 1일\n\n1. 서비스 설명\nTimebox Planner는 시간 관리 및 일정 계획을 돕는 모바일 애플리케이션입니다.\n\n2. 사용자 책임\n사용자는 앱에 입력하는 모든 데이터에 대한 책임을 지며, 앱을 합법적인 목적으로만 사용해야 합니다.\n\n3. 면책 조항\n본 앱은 \"있는 그대로\" 제공됩니다. 데이터 손실, 일정 누락 등으로 인한 직간접적 손해에 대해 개발자는 책임을 지지 않습니다.\n\n4. 지적재산권\n본 앱의 디자인, 코드, 콘텐츠에 대한 모든 지적재산권은 개발자에게 귀속됩니다.\n\n5. 약관 변경\n본 약관은 사전 고지 후 변경될 수 있으며, 변경 사항은 앱 업데이트를 통해 공지됩니다.';

  @override
  String durationFormat(int hours, int minutes) {
    return '$hours시간 $minutes분';
  }

  @override
  String get previousDay => '이전 날';

  @override
  String get nextDay => '다음 날';

  @override
  String get noTitle => '제목 없음';

  @override
  String get incomplete => '미완료';

  @override
  String get revert => '되돌리기';

  @override
  String get statusChange => '상태 변경';

  @override
  String get timeBlockResult => '타임블록 결과';

  @override
  String get reverted => '되돌림 처리되었습니다';

  @override
  String get markedComplete => '완료 처리되었습니다';

  @override
  String get markedIncomplete => '미완료 처리되었습니다';

  @override
  String get deleteTimeBlock => '타임블록 삭제';

  @override
  String get deleteTimeBlockConfirm => '이 타임블록을 삭제하시겠습니까?';

  @override
  String get removeFromTop3 => 'Top 3에서 제거';

  @override
  String scoreUp(int change) {
    return '어제보다 $change점 상승!';
  }

  @override
  String scoreDown(int change) {
    return '어제보다 $change점 하락';
  }

  @override
  String get scoreSame => '어제와 동일';

  @override
  String get average => '평균';

  @override
  String get dailyReminderTitle => '오늘의 계획을 세워보세요!';

  @override
  String get dailyReminderBody => '목표 달성을 위한 첫 걸음입니다.';

  @override
  String get monday => '월요일';

  @override
  String get tuesday => '화요일';

  @override
  String get wednesday => '수요일';

  @override
  String get thursday => '목요일';

  @override
  String get friday => '금요일';

  @override
  String get saturday => '토요일';

  @override
  String get sunday => '일요일';

  @override
  String get insightPeriodYesterday => '어제';

  @override
  String get insightPeriodToday => '오늘';

  @override
  String get insightPeriodWeekFirstHalf => '이번 주 전반';

  @override
  String insightFocusTimeTitle(String dayName, String hour) {
    return '$dayName $hour시에 가장 집중력이 높았어요';
  }

  @override
  String get insightFocusTimeDesc => '이 시간대에 중요한 작업을 배치해보세요';

  @override
  String insightTagAccuracyFasterTitle(String tagName, String minutes) {
    return '$tagName 태그 작업을 $minutes분 빠르게 완료했어요';
  }

  @override
  String insightTagAccuracySlowerTitle(String tagName, String minutes) {
    return '$tagName 태그 작업에 $minutes분 더 걸렸어요';
  }

  @override
  String get insightTagAccuracyFasterDesc => '예상 시간 산정이 정확해지고 있어요';

  @override
  String get insightTagAccuracySlowerDesc => '이 유형의 작업에 더 넉넉한 시간을 배분해보세요';

  @override
  String insightRolloverTitle(String rolloverCount, String taskCount) {
    return '이월 작업이 $rolloverCount건 중 $taskCount건이에요';
  }

  @override
  String get insightRolloverDesc => '작업을 더 작게 나누거나 우선순위를 재조정해보세요';

  @override
  String insightStreakTitle(String days) {
    return '$days일 연속으로 계획을 실행하고 있어요!';
  }

  @override
  String get insightStreakDesc => '꾸준함이 성공의 열쇠입니다';

  @override
  String insightScoreUpTitle(String period, String scoreDiff) {
    return '$period 대비 생산성이 $scoreDiff점 올랐어요';
  }

  @override
  String get insightScoreUpDesc => '좋은 흐름을 유지하세요!';

  @override
  String insightScoreDownTitle(String period, String scoreDiff) {
    return '$period 대비 생산성이 $scoreDiff점 떨어졌어요';
  }

  @override
  String get insightScoreDownDesc => '계획을 조금 조정해보세요';

  @override
  String insightBestDayTitle(String dayName) {
    return '$dayName이 가장 생산적인 요일이에요';
  }

  @override
  String insightBestDayDesc(String score) {
    return '평균 점수: $score점';
  }

  @override
  String insightTimeSavedTitle(String period, String minutes) {
    return '$period 계획보다 $minutes분 절약했어요';
  }

  @override
  String get insightTimeSavedDesc => '효율적인 시간 관리를 하고 있어요';

  @override
  String insightTimeOverTitle(String period, String minutes) {
    return '$period 계획보다 $minutes분 초과했어요';
  }

  @override
  String get insightTimeOverDesc => '시간 예측을 조금 여유 있게 설정해보세요';

  @override
  String get insightTaskFirstTitle => '오늘 첫 번째 작업을 완료했어요!';

  @override
  String get insightTaskFirstDesc => '좋은 시작이에요';

  @override
  String get insightTaskAllCompleteTitle => '오늘의 모든 작업을 완료했어요!';

  @override
  String insightTaskAllCompleteDesc(String total) {
    return '총 $total개의 작업을 해냈어요';
  }

  @override
  String get insightTaskNoneTitle => '아직 완료한 작업이 없어요';

  @override
  String get insightTaskNoneDesc => '작은 것부터 시작해보세요';

  @override
  String insightTaskPartialTitle(String total, String completed) {
    return '$total개 중 $completed개 작업 완료';
  }

  @override
  String insightTaskPartialDesc(String remaining) {
    return '$remaining개 남았어요, 힘내세요!';
  }

  @override
  String insightFocusEffTitle(String percent) {
    return '집중 효율 $percent%';
  }

  @override
  String get insightFocusEffHighDesc => '높은 집중력을 유지하고 있어요';

  @override
  String get insightFocusEffMedDesc => '집중력이 보통 수준이에요';

  @override
  String get insightFocusEffLowDesc => '집중 환경을 개선해보세요';

  @override
  String insightTimeEstTitle(String percent) {
    return '시간 예측 정확도 $percent%';
  }

  @override
  String get insightTimeEstHighDesc => '시간 예측이 정확해요';

  @override
  String get insightTimeEstMedDesc => '시간 예측을 조금 조정해보세요';

  @override
  String get insightTimeEstLowDesc => '실제 소요 시간을 기록하여 예측을 개선해보세요';

  @override
  String get insightTop3AllCompleteTitle => 'Top 3를 모두 달성했어요!';

  @override
  String get insightTop3AllCompleteDesc => '가장 중요한 일에 집중했어요';

  @override
  String insightTop3PartialTitle(String completed) {
    return 'Top 3 중 $completed개 달성';
  }

  @override
  String insightTop3PartialDesc(String remaining) {
    return '$remaining개 더 달성해보세요';
  }

  @override
  String get insightScoreGreatTitle => '훌륭한 하루였어요!';

  @override
  String insightScoreGreatDesc(String score) {
    return '생산성 점수 $score점';
  }

  @override
  String get insightScoreNormalTitle => '오늘도 수고했어요';

  @override
  String insightScoreNormalDesc(String score) {
    return '생산성 점수 $score점';
  }

  @override
  String insightWeekAvgTitle(String score) {
    return '이번 주 평균 점수: $score점';
  }

  @override
  String get insightWeekAvgHighDesc => '일주일 내내 훌륭했어요';

  @override
  String get insightWeekAvgLowDesc => '다음 주는 더 나아질 거에요';

  @override
  String insightMonthAvgTitle(String score) {
    return '이번 달 평균 점수: $score점';
  }

  @override
  String get insightMonthAvgHighDesc => '한 달 동안 꾸준히 잘 해왔어요';

  @override
  String get insightMonthAvgLowDesc => '목표를 재설정하고 다시 시작해보세요';

  @override
  String insightMonthBestTitle(String month, String day) {
    return '이번 달 최고의 날: $month월 $day일';
  }

  @override
  String insightMonthBestDesc(String score) {
    return '그날의 점수: $score점';
  }
}
