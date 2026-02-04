import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('fr'),
    Locale('hi'),
    Locale('ja'),
    Locale('ko'),
    Locale('ru'),
    Locale('zh'),
  ];

  /// 앱 이름
  ///
  /// In ko, this message translates to:
  /// **'타임박스 플래너'**
  String get appName;

  /// No description provided for @inbox.
  ///
  /// In ko, this message translates to:
  /// **'인박스'**
  String get inbox;

  /// No description provided for @calendar.
  ///
  /// In ko, this message translates to:
  /// **'캘린더'**
  String get calendar;

  /// No description provided for @focus.
  ///
  /// In ko, this message translates to:
  /// **'집중'**
  String get focus;

  /// No description provided for @analytics.
  ///
  /// In ko, this message translates to:
  /// **'분석'**
  String get analytics;

  /// No description provided for @settings.
  ///
  /// In ko, this message translates to:
  /// **'설정'**
  String get settings;

  /// No description provided for @task.
  ///
  /// In ko, this message translates to:
  /// **'할 일'**
  String get task;

  /// No description provided for @tasks.
  ///
  /// In ko, this message translates to:
  /// **'할 일 목록'**
  String get tasks;

  /// No description provided for @addTask.
  ///
  /// In ko, this message translates to:
  /// **'할 일 추가'**
  String get addTask;

  /// No description provided for @editTask.
  ///
  /// In ko, this message translates to:
  /// **'할 일 편집'**
  String get editTask;

  /// No description provided for @deleteTask.
  ///
  /// In ko, this message translates to:
  /// **'할 일 삭제'**
  String get deleteTask;

  /// No description provided for @taskTitle.
  ///
  /// In ko, this message translates to:
  /// **'제목'**
  String get taskTitle;

  /// No description provided for @taskNote.
  ///
  /// In ko, this message translates to:
  /// **'메모'**
  String get taskNote;

  /// No description provided for @estimatedDuration.
  ///
  /// In ko, this message translates to:
  /// **'예상 소요 시간'**
  String get estimatedDuration;

  /// No description provided for @subtasks.
  ///
  /// In ko, this message translates to:
  /// **'하위 할 일'**
  String get subtasks;

  /// No description provided for @addSubtask.
  ///
  /// In ko, this message translates to:
  /// **'하위 할 일 추가'**
  String get addSubtask;

  /// No description provided for @priority.
  ///
  /// In ko, this message translates to:
  /// **'우선순위'**
  String get priority;

  /// No description provided for @priorityHigh.
  ///
  /// In ko, this message translates to:
  /// **'높음'**
  String get priorityHigh;

  /// No description provided for @priorityMedium.
  ///
  /// In ko, this message translates to:
  /// **'보통'**
  String get priorityMedium;

  /// No description provided for @priorityLow.
  ///
  /// In ko, this message translates to:
  /// **'낮음'**
  String get priorityLow;

  /// No description provided for @status.
  ///
  /// In ko, this message translates to:
  /// **'상태'**
  String get status;

  /// No description provided for @statusTodo.
  ///
  /// In ko, this message translates to:
  /// **'할 일'**
  String get statusTodo;

  /// No description provided for @statusInProgress.
  ///
  /// In ko, this message translates to:
  /// **'진행 중'**
  String get statusInProgress;

  /// No description provided for @statusCompleted.
  ///
  /// In ko, this message translates to:
  /// **'완료'**
  String get statusCompleted;

  /// No description provided for @statusDelayed.
  ///
  /// In ko, this message translates to:
  /// **'지연됨'**
  String get statusDelayed;

  /// No description provided for @statusSkipped.
  ///
  /// In ko, this message translates to:
  /// **'건너뜀'**
  String get statusSkipped;

  /// No description provided for @tag.
  ///
  /// In ko, this message translates to:
  /// **'태그'**
  String get tag;

  /// No description provided for @tags.
  ///
  /// In ko, this message translates to:
  /// **'태그들'**
  String get tags;

  /// No description provided for @addTag.
  ///
  /// In ko, this message translates to:
  /// **'태그 추가'**
  String get addTag;

  /// No description provided for @timeBlock.
  ///
  /// In ko, this message translates to:
  /// **'타임 블록'**
  String get timeBlock;

  /// No description provided for @createTimeBlock.
  ///
  /// In ko, this message translates to:
  /// **'타임 블록 생성'**
  String get createTimeBlock;

  /// No description provided for @moveTimeBlock.
  ///
  /// In ko, this message translates to:
  /// **'타임 블록 이동'**
  String get moveTimeBlock;

  /// No description provided for @resizeTimeBlock.
  ///
  /// In ko, this message translates to:
  /// **'타임 블록 크기 조정'**
  String get resizeTimeBlock;

  /// No description provided for @conflictDetected.
  ///
  /// In ko, this message translates to:
  /// **'일정 충돌이 감지되었습니다'**
  String get conflictDetected;

  /// No description provided for @focusMode.
  ///
  /// In ko, this message translates to:
  /// **'집중 모드'**
  String get focusMode;

  /// No description provided for @startFocus.
  ///
  /// In ko, this message translates to:
  /// **'집중 시작'**
  String get startFocus;

  /// No description provided for @pauseFocus.
  ///
  /// In ko, this message translates to:
  /// **'일시 정지'**
  String get pauseFocus;

  /// No description provided for @resumeFocus.
  ///
  /// In ko, this message translates to:
  /// **'재개'**
  String get resumeFocus;

  /// No description provided for @completeFocus.
  ///
  /// In ko, this message translates to:
  /// **'완료'**
  String get completeFocus;

  /// No description provided for @skipFocus.
  ///
  /// In ko, this message translates to:
  /// **'건너뛰기'**
  String get skipFocus;

  /// No description provided for @timeRemaining.
  ///
  /// In ko, this message translates to:
  /// **'남은 시간'**
  String get timeRemaining;

  /// No description provided for @today.
  ///
  /// In ko, this message translates to:
  /// **'오늘'**
  String get today;

  /// No description provided for @tomorrow.
  ///
  /// In ko, this message translates to:
  /// **'내일'**
  String get tomorrow;

  /// No description provided for @thisWeek.
  ///
  /// In ko, this message translates to:
  /// **'이번 주'**
  String get thisWeek;

  /// No description provided for @minutes.
  ///
  /// In ko, this message translates to:
  /// **'분'**
  String get minutes;

  /// No description provided for @hours.
  ///
  /// In ko, this message translates to:
  /// **'시간'**
  String get hours;

  /// No description provided for @minutesShort.
  ///
  /// In ko, this message translates to:
  /// **'{count}분'**
  String minutesShort(int count);

  /// No description provided for @hoursShort.
  ///
  /// In ko, this message translates to:
  /// **'{count}시간'**
  String hoursShort(int count);

  /// No description provided for @productivityScore.
  ///
  /// In ko, this message translates to:
  /// **'생산성 점수'**
  String get productivityScore;

  /// No description provided for @plannedVsActual.
  ///
  /// In ko, this message translates to:
  /// **'계획 vs 실제'**
  String get plannedVsActual;

  /// No description provided for @completionRate.
  ///
  /// In ko, this message translates to:
  /// **'완료율'**
  String get completionRate;

  /// No description provided for @rolloverTasks.
  ///
  /// In ko, this message translates to:
  /// **'이월된 할 일'**
  String get rolloverTasks;

  /// No description provided for @darkMode.
  ///
  /// In ko, this message translates to:
  /// **'다크 모드'**
  String get darkMode;

  /// No description provided for @language.
  ///
  /// In ko, this message translates to:
  /// **'언어'**
  String get language;

  /// No description provided for @notifications.
  ///
  /// In ko, this message translates to:
  /// **'알림'**
  String get notifications;

  /// No description provided for @calendarSync.
  ///
  /// In ko, this message translates to:
  /// **'캘린더 동기화'**
  String get calendarSync;

  /// No description provided for @profile.
  ///
  /// In ko, this message translates to:
  /// **'프로필'**
  String get profile;

  /// No description provided for @logout.
  ///
  /// In ko, this message translates to:
  /// **'로그아웃'**
  String get logout;

  /// No description provided for @save.
  ///
  /// In ko, this message translates to:
  /// **'저장'**
  String get save;

  /// No description provided for @cancel.
  ///
  /// In ko, this message translates to:
  /// **'취소'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In ko, this message translates to:
  /// **'삭제'**
  String get delete;

  /// No description provided for @confirm.
  ///
  /// In ko, this message translates to:
  /// **'확인'**
  String get confirm;

  /// No description provided for @edit.
  ///
  /// In ko, this message translates to:
  /// **'편집'**
  String get edit;

  /// No description provided for @done.
  ///
  /// In ko, this message translates to:
  /// **'완료'**
  String get done;

  /// No description provided for @emptyInbox.
  ///
  /// In ko, this message translates to:
  /// **'인박스가 비어있습니다'**
  String get emptyInbox;

  /// No description provided for @emptyInboxDescription.
  ///
  /// In ko, this message translates to:
  /// **'새로운 할 일을 추가해보세요'**
  String get emptyInboxDescription;

  /// No description provided for @emptyCalendar.
  ///
  /// In ko, this message translates to:
  /// **'오늘 일정이 없습니다'**
  String get emptyCalendar;

  /// No description provided for @emptyCalendarDescription.
  ///
  /// In ko, this message translates to:
  /// **'할 일을 드래그하여 일정을 만들어보세요'**
  String get emptyCalendarDescription;

  /// No description provided for @error.
  ///
  /// In ko, this message translates to:
  /// **'오류'**
  String get error;

  /// No description provided for @errorGeneric.
  ///
  /// In ko, this message translates to:
  /// **'문제가 발생했습니다'**
  String get errorGeneric;

  /// No description provided for @errorNetwork.
  ///
  /// In ko, this message translates to:
  /// **'네트워크 연결을 확인해주세요'**
  String get errorNetwork;

  /// No description provided for @retry.
  ///
  /// In ko, this message translates to:
  /// **'다시 시도'**
  String get retry;

  /// No description provided for @noActiveSession.
  ///
  /// In ko, this message translates to:
  /// **'진행 중인 세션이 없습니다'**
  String get noActiveSession;

  /// No description provided for @startFocusDescription.
  ///
  /// In ko, this message translates to:
  /// **'집중 세션을 시작하여 생산성을 높여보세요'**
  String get startFocusDescription;

  /// No description provided for @quickStart.
  ///
  /// In ko, this message translates to:
  /// **'빠른 시작'**
  String get quickStart;

  /// No description provided for @paused.
  ///
  /// In ko, this message translates to:
  /// **'일시 정지됨'**
  String get paused;

  /// No description provided for @skip.
  ///
  /// In ko, this message translates to:
  /// **'건너뛰기'**
  String get skip;

  /// No description provided for @complete.
  ///
  /// In ko, this message translates to:
  /// **'완료'**
  String get complete;

  /// No description provided for @sessionCompleted.
  ///
  /// In ko, this message translates to:
  /// **'세션 완료!'**
  String get sessionCompleted;

  /// No description provided for @selectDuration.
  ///
  /// In ko, this message translates to:
  /// **'시간 선택'**
  String get selectDuration;

  /// No description provided for @filter.
  ///
  /// In ko, this message translates to:
  /// **'필터'**
  String get filter;

  /// No description provided for @all.
  ///
  /// In ko, this message translates to:
  /// **'전체'**
  String get all;

  /// No description provided for @statusDone.
  ///
  /// In ko, this message translates to:
  /// **'완료됨'**
  String get statusDone;

  /// No description provided for @emptyInboxTitle.
  ///
  /// In ko, this message translates to:
  /// **'인박스가 비어있습니다'**
  String get emptyInboxTitle;

  /// No description provided for @toDo.
  ///
  /// In ko, this message translates to:
  /// **'할 일'**
  String get toDo;

  /// No description provided for @completed.
  ///
  /// In ko, this message translates to:
  /// **'완료됨'**
  String get completed;

  /// No description provided for @deleteTaskConfirm.
  ///
  /// In ko, this message translates to:
  /// **'이 할 일을 삭제하시겠습니까?'**
  String get deleteTaskConfirm;

  /// No description provided for @taskTitleHint.
  ///
  /// In ko, this message translates to:
  /// **'무엇을 해야 하나요?'**
  String get taskTitleHint;

  /// No description provided for @lessOptions.
  ///
  /// In ko, this message translates to:
  /// **'옵션 숨기기'**
  String get lessOptions;

  /// No description provided for @moreOptions.
  ///
  /// In ko, this message translates to:
  /// **'더 많은 옵션'**
  String get moreOptions;

  /// No description provided for @taskNoteHint.
  ///
  /// In ko, this message translates to:
  /// **'메모 추가...'**
  String get taskNoteHint;

  /// No description provided for @title.
  ///
  /// In ko, this message translates to:
  /// **'제목'**
  String get title;

  /// No description provided for @timeBlockTitleHint.
  ///
  /// In ko, this message translates to:
  /// **'블록 이름 입력'**
  String get timeBlockTitleHint;

  /// No description provided for @startTime.
  ///
  /// In ko, this message translates to:
  /// **'시작 시간'**
  String get startTime;

  /// No description provided for @endTime.
  ///
  /// In ko, this message translates to:
  /// **'종료 시간'**
  String get endTime;

  /// No description provided for @add.
  ///
  /// In ko, this message translates to:
  /// **'추가'**
  String get add;

  /// No description provided for @top3.
  ///
  /// In ko, this message translates to:
  /// **'가장 중요한 3가지'**
  String get top3;

  /// No description provided for @rank1.
  ///
  /// In ko, this message translates to:
  /// **'1순위'**
  String get rank1;

  /// No description provided for @rank2.
  ///
  /// In ko, this message translates to:
  /// **'2순위'**
  String get rank2;

  /// No description provided for @rank3.
  ///
  /// In ko, this message translates to:
  /// **'3순위'**
  String get rank3;

  /// No description provided for @brainDump.
  ///
  /// In ko, this message translates to:
  /// **'브레인 덤프'**
  String get brainDump;

  /// No description provided for @timeline.
  ///
  /// In ko, this message translates to:
  /// **'타임라인'**
  String get timeline;

  /// No description provided for @dragToSchedule.
  ///
  /// In ko, this message translates to:
  /// **'끌어서 일정 추가'**
  String get dragToSchedule;

  /// No description provided for @emptyTop3Slot.
  ///
  /// In ko, this message translates to:
  /// **'탭하거나 드래그하여 추가'**
  String get emptyTop3Slot;

  /// No description provided for @dayStartTime.
  ///
  /// In ko, this message translates to:
  /// **'하루 시작 시간'**
  String get dayStartTime;

  /// No description provided for @dayEndTime.
  ///
  /// In ko, this message translates to:
  /// **'하루 종료 시간'**
  String get dayEndTime;

  /// No description provided for @planner.
  ///
  /// In ko, this message translates to:
  /// **'타임박스'**
  String get planner;

  /// No description provided for @copyToTomorrow.
  ///
  /// In ko, this message translates to:
  /// **'내일도 하기'**
  String get copyToTomorrow;

  /// No description provided for @copiedToTomorrow.
  ///
  /// In ko, this message translates to:
  /// **'내일로 복사되었습니다'**
  String get copiedToTomorrow;

  /// No description provided for @rolloverBadge.
  ///
  /// In ko, this message translates to:
  /// **'이월 {count}회'**
  String rolloverBadge(int count);

  /// No description provided for @appearance.
  ///
  /// In ko, this message translates to:
  /// **'외관'**
  String get appearance;

  /// No description provided for @theme.
  ///
  /// In ko, this message translates to:
  /// **'테마'**
  String get theme;

  /// No description provided for @themeSystem.
  ///
  /// In ko, this message translates to:
  /// **'시스템 설정'**
  String get themeSystem;

  /// No description provided for @themeLight.
  ///
  /// In ko, this message translates to:
  /// **'라이트'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In ko, this message translates to:
  /// **'다크'**
  String get themeDark;

  /// No description provided for @notificationDescription.
  ///
  /// In ko, this message translates to:
  /// **'타임박스 알림 받기'**
  String get notificationDescription;

  /// No description provided for @notificationTiming.
  ///
  /// In ko, this message translates to:
  /// **'알림 시간'**
  String get notificationTiming;

  /// No description provided for @minutesBefore.
  ///
  /// In ko, this message translates to:
  /// **'{count}분 전'**
  String minutesBefore(int count);

  /// No description provided for @noCalendarConnected.
  ///
  /// In ko, this message translates to:
  /// **'연결된 캘린더 없음'**
  String get noCalendarConnected;

  /// No description provided for @comingSoon.
  ///
  /// In ko, this message translates to:
  /// **'준비 중입니다'**
  String get comingSoon;

  /// No description provided for @timeSettings.
  ///
  /// In ko, this message translates to:
  /// **'시간 설정'**
  String get timeSettings;

  /// No description provided for @dayTimeRange.
  ///
  /// In ko, this message translates to:
  /// **'하루 시간 범위'**
  String get dayTimeRange;

  /// No description provided for @defaultTimeBlockDuration.
  ///
  /// In ko, this message translates to:
  /// **'기본 타임박스 길이'**
  String get defaultTimeBlockDuration;

  /// No description provided for @data.
  ///
  /// In ko, this message translates to:
  /// **'데이터'**
  String get data;

  /// No description provided for @exportData.
  ///
  /// In ko, this message translates to:
  /// **'데이터 내보내기'**
  String get exportData;

  /// No description provided for @exportDataDescription.
  ///
  /// In ko, this message translates to:
  /// **'CSV 파일로 내보내기'**
  String get exportDataDescription;

  /// No description provided for @resetSettings.
  ///
  /// In ko, this message translates to:
  /// **'설정 초기화'**
  String get resetSettings;

  /// No description provided for @resetSettingsConfirm.
  ///
  /// In ko, this message translates to:
  /// **'모든 설정을 초기화하시겠습니까?'**
  String get resetSettingsConfirm;

  /// No description provided for @settingsReset.
  ///
  /// In ko, this message translates to:
  /// **'설정이 초기화되었습니다'**
  String get settingsReset;

  /// No description provided for @longPressToSelect.
  ///
  /// In ko, this message translates to:
  /// **'길게 눌러서 시간 범위 선택'**
  String get longPressToSelect;

  /// No description provided for @selectTask.
  ///
  /// In ko, this message translates to:
  /// **'할 일 선택'**
  String get selectTask;

  /// No description provided for @noUnscheduledTasks.
  ///
  /// In ko, this message translates to:
  /// **'미배정 할 일이 없습니다'**
  String get noUnscheduledTasks;

  /// No description provided for @addNewTask.
  ///
  /// In ko, this message translates to:
  /// **'새 할 일 추가'**
  String get addNewTask;

  /// No description provided for @addNewTaskHint.
  ///
  /// In ko, this message translates to:
  /// **'할 일 제목 입력...'**
  String get addNewTaskHint;

  /// No description provided for @timeRangeLabel.
  ///
  /// In ko, this message translates to:
  /// **'{start} - {end}'**
  String timeRangeLabel(String start, String end);

  /// No description provided for @assignToTimeBlock.
  ///
  /// In ko, this message translates to:
  /// **'타임블록에 할당'**
  String get assignToTimeBlock;

  /// No description provided for @mergeBlocks.
  ///
  /// In ko, this message translates to:
  /// **'블록 병합'**
  String get mergeBlocks;

  /// No description provided for @overlapWarning.
  ///
  /// In ko, this message translates to:
  /// **'경고: 타임블록이 겹칩니다'**
  String get overlapWarning;

  /// No description provided for @taskAssigned.
  ///
  /// In ko, this message translates to:
  /// **'할 일이 할당되었습니다'**
  String get taskAssigned;

  /// No description provided for @tapToCancel.
  ///
  /// In ko, this message translates to:
  /// **'바깥을 탭하여 취소'**
  String get tapToCancel;

  /// No description provided for @statistics.
  ///
  /// In ko, this message translates to:
  /// **'통계'**
  String get statistics;

  /// No description provided for @todayHighlights.
  ///
  /// In ko, this message translates to:
  /// **'오늘의 하이라이트'**
  String get todayHighlights;

  /// No description provided for @completedTasksCount.
  ///
  /// In ko, this message translates to:
  /// **'완료한 Task'**
  String get completedTasksCount;

  /// No description provided for @focusTimeMinutes.
  ///
  /// In ko, this message translates to:
  /// **'집중 시간'**
  String get focusTimeMinutes;

  /// No description provided for @timeSavedMinutes.
  ///
  /// In ko, this message translates to:
  /// **'절약한 시간'**
  String get timeSavedMinutes;

  /// No description provided for @top3Achievement.
  ///
  /// In ko, this message translates to:
  /// **'Top 3 달성'**
  String get top3Achievement;

  /// No description provided for @trend.
  ///
  /// In ko, this message translates to:
  /// **'트렌드'**
  String get trend;

  /// No description provided for @tagAnalysis.
  ///
  /// In ko, this message translates to:
  /// **'태그별 분석'**
  String get tagAnalysis;

  /// No description provided for @insights.
  ///
  /// In ko, this message translates to:
  /// **'인사이트'**
  String get insights;

  /// No description provided for @daily.
  ///
  /// In ko, this message translates to:
  /// **'일간'**
  String get daily;

  /// No description provided for @weekly.
  ///
  /// In ko, this message translates to:
  /// **'주간'**
  String get weekly;

  /// No description provided for @monthly.
  ///
  /// In ko, this message translates to:
  /// **'월간'**
  String get monthly;

  /// No description provided for @focusModeTooltip.
  ///
  /// In ko, this message translates to:
  /// **'집중 모드'**
  String get focusModeTooltip;

  /// No description provided for @startAlarm.
  ///
  /// In ko, this message translates to:
  /// **'시작 알림'**
  String get startAlarm;

  /// No description provided for @endAlarm.
  ///
  /// In ko, this message translates to:
  /// **'종료 알림'**
  String get endAlarm;

  /// No description provided for @notifyBeforeStart.
  ///
  /// In ko, this message translates to:
  /// **'시작 전 알림'**
  String get notifyBeforeStart;

  /// No description provided for @notifyBeforeEnd.
  ///
  /// In ko, this message translates to:
  /// **'종료 전 알림'**
  String get notifyBeforeEnd;

  /// No description provided for @selectMultipleTimings.
  ///
  /// In ko, this message translates to:
  /// **'여러 시간을 선택할 수 있습니다'**
  String get selectMultipleTimings;

  /// No description provided for @dailyReminder.
  ///
  /// In ko, this message translates to:
  /// **'일일 리마인더'**
  String get dailyReminder;

  /// No description provided for @dailyReminderDesc.
  ///
  /// In ko, this message translates to:
  /// **'앱을 열지 않은 날 알림 받기'**
  String get dailyReminderDesc;

  /// No description provided for @dailyReminderTime.
  ///
  /// In ko, this message translates to:
  /// **'리마인더 시간'**
  String get dailyReminderTime;

  /// No description provided for @notificationPermissionRequired.
  ///
  /// In ko, this message translates to:
  /// **'알림 권한이 필요합니다'**
  String get notificationPermissionRequired;

  /// No description provided for @notificationPermissionDesc.
  ///
  /// In ko, this message translates to:
  /// **'타임블록 알림을 받으려면 알림 권한을 허용해주세요'**
  String get notificationPermissionDesc;

  /// No description provided for @openSettings.
  ///
  /// In ko, this message translates to:
  /// **'설정 열기'**
  String get openSettings;

  /// No description provided for @permissionGranted.
  ///
  /// In ko, this message translates to:
  /// **'권한 허용됨'**
  String get permissionGranted;

  /// No description provided for @permissionDenied.
  ///
  /// In ko, this message translates to:
  /// **'권한 거부됨'**
  String get permissionDenied;

  /// No description provided for @requestPermission.
  ///
  /// In ko, this message translates to:
  /// **'권한 요청'**
  String get requestPermission;

  /// No description provided for @hourBefore.
  ///
  /// In ko, this message translates to:
  /// **'{count}시간 전'**
  String hourBefore(int count);

  /// No description provided for @alarmSettings.
  ///
  /// In ko, this message translates to:
  /// **'알림 설정'**
  String get alarmSettings;

  /// No description provided for @alarmTimingNote.
  ///
  /// In ko, this message translates to:
  /// **'다중 선택 가능'**
  String get alarmTimingNote;

  /// No description provided for @noonTime.
  ///
  /// In ko, this message translates to:
  /// **'정오 (12:00)'**
  String get noonTime;

  /// No description provided for @mathChallenge.
  ///
  /// In ko, this message translates to:
  /// **'수학 문제'**
  String get mathChallenge;

  /// No description provided for @mathChallengeProgress.
  ///
  /// In ko, this message translates to:
  /// **'{current} / {total}'**
  String mathChallengeProgress(int current, int total);

  /// No description provided for @enterAnswer.
  ///
  /// In ko, this message translates to:
  /// **'답 입력'**
  String get enterAnswer;

  /// No description provided for @wrongAnswer.
  ///
  /// In ko, this message translates to:
  /// **'틀렸습니다. 다시 시도하세요.'**
  String get wrongAnswer;

  /// No description provided for @focusLockEnabled.
  ///
  /// In ko, this message translates to:
  /// **'화면 잠금 활성화됨'**
  String get focusLockEnabled;

  /// No description provided for @overlayPermissionRequired.
  ///
  /// In ko, this message translates to:
  /// **'오버레이 권한이 필요합니다'**
  String get overlayPermissionRequired;

  /// No description provided for @noActiveTimeBlock.
  ///
  /// In ko, this message translates to:
  /// **'진행 중인 타임블록이 없습니다'**
  String get noActiveTimeBlock;

  /// No description provided for @createTimeBlockFirst.
  ///
  /// In ko, this message translates to:
  /// **'캘린더에서 타임블록을 먼저 생성하세요'**
  String get createTimeBlockFirst;

  /// No description provided for @exitFocus.
  ///
  /// In ko, this message translates to:
  /// **'종료하기'**
  String get exitFocus;

  /// No description provided for @statsCompletionRates.
  ///
  /// In ko, this message translates to:
  /// **'완료율'**
  String get statsCompletionRates;

  /// No description provided for @statsTaskPipeline.
  ///
  /// In ko, this message translates to:
  /// **'Task 흐름'**
  String get statsTaskPipeline;

  /// No description provided for @statsPlanVsActual.
  ///
  /// In ko, this message translates to:
  /// **'계획 vs 실제'**
  String get statsPlanVsActual;

  /// No description provided for @statsPriorityBreakdown.
  ///
  /// In ko, this message translates to:
  /// **'우선순위별 성과'**
  String get statsPriorityBreakdown;

  /// No description provided for @statsFocusSummary.
  ///
  /// In ko, this message translates to:
  /// **'집중 분석'**
  String get statsFocusSummary;

  /// No description provided for @statsTopInsights.
  ///
  /// In ko, this message translates to:
  /// **'인사이트'**
  String get statsTopInsights;

  /// No description provided for @statsScheduled.
  ///
  /// In ko, this message translates to:
  /// **'스케줄'**
  String get statsScheduled;

  /// No description provided for @statsCompleted.
  ///
  /// In ko, this message translates to:
  /// **'완료'**
  String get statsCompleted;

  /// No description provided for @statsRolledOver.
  ///
  /// In ko, this message translates to:
  /// **'이월'**
  String get statsRolledOver;

  /// No description provided for @statsEfficiency.
  ///
  /// In ko, this message translates to:
  /// **'효율'**
  String get statsEfficiency;

  /// No description provided for @statsNoData.
  ///
  /// In ko, this message translates to:
  /// **'아직 데이터가 없어요'**
  String get statsNoData;

  /// No description provided for @navTimeline.
  ///
  /// In ko, this message translates to:
  /// **'타임라인'**
  String get navTimeline;

  /// No description provided for @navReport.
  ///
  /// In ko, this message translates to:
  /// **'리포트'**
  String get navReport;

  /// No description provided for @suggestedTasks.
  ///
  /// In ko, this message translates to:
  /// **'추천 할 일'**
  String get suggestedTasks;

  /// No description provided for @taskSuggestionsHint.
  ///
  /// In ko, this message translates to:
  /// **'이전에 자주 했던 할 일이에요'**
  String get taskSuggestionsHint;

  /// No description provided for @topSuccessTasks.
  ///
  /// In ko, this message translates to:
  /// **'가장 잘 완료하는 Task'**
  String get topSuccessTasks;

  /// No description provided for @topFailureTasks.
  ///
  /// In ko, this message translates to:
  /// **'완료가 어려운 Task'**
  String get topFailureTasks;

  /// No description provided for @completionCount.
  ///
  /// In ko, this message translates to:
  /// **'완료 횟수'**
  String get completionCount;

  /// No description provided for @taskRankings.
  ///
  /// In ko, this message translates to:
  /// **'Task 랭킹'**
  String get taskRankings;

  /// No description provided for @privacyPolicy.
  ///
  /// In ko, this message translates to:
  /// **'개인정보처리방침'**
  String get privacyPolicy;

  /// No description provided for @termsOfService.
  ///
  /// In ko, this message translates to:
  /// **'이용약관'**
  String get termsOfService;

  /// No description provided for @privacyPolicyContent.
  ///
  /// In ko, this message translates to:
  /// **'개인정보처리방침\n\n최종 수정일: 2026년 1월 1일\n\n1. 수집 항목\n본 앱은 할 일, 시간 기록 등 사용자가 직접 입력한 앱 사용 데이터를 처리합니다.\n\n2. 저장 방식\n모든 데이터는 사용자의 기기 내에 로컬로만 저장되며, 외부 서버로 전송되지 않습니다.\n\n3. 제3자 제공\n본 앱은 광고 표시를 위해 Google AdMob을 사용합니다. AdMob은 광고 식별자를 수집할 수 있습니다. 자세한 내용은 Google 개인정보처리방침을 참고하세요.\n\n4. 데이터 삭제\n앱을 삭제하면 기기에 저장된 모든 데이터가 자동으로 삭제됩니다.\n\n5. 문의\n개인정보 관련 문의: myclick90@gmail.com'**
  String get privacyPolicyContent;

  /// No description provided for @termsOfServiceContent.
  ///
  /// In ko, this message translates to:
  /// **'이용약관\n\n최종 수정일: 2026년 1월 1일\n\n1. 서비스 설명\nTimebox Planner는 시간 관리 및 일정 계획을 돕는 모바일 애플리케이션입니다.\n\n2. 사용자 책임\n사용자는 앱에 입력하는 모든 데이터에 대한 책임을 지며, 앱을 합법적인 목적으로만 사용해야 합니다.\n\n3. 면책 조항\n본 앱은 \"있는 그대로\" 제공됩니다. 데이터 손실, 일정 누락 등으로 인한 직간접적 손해에 대해 개발자는 책임을 지지 않습니다.\n\n4. 지적재산권\n본 앱의 디자인, 코드, 콘텐츠에 대한 모든 지적재산권은 개발자에게 귀속됩니다.\n\n5. 약관 변경\n본 약관은 사전 고지 후 변경될 수 있으며, 변경 사항은 앱 업데이트를 통해 공지됩니다.'**
  String get termsOfServiceContent;

  /// No description provided for @durationFormat.
  ///
  /// In ko, this message translates to:
  /// **'{hours}시간 {minutes}분'**
  String durationFormat(int hours, int minutes);

  /// No description provided for @previousDay.
  ///
  /// In ko, this message translates to:
  /// **'이전 날'**
  String get previousDay;

  /// No description provided for @nextDay.
  ///
  /// In ko, this message translates to:
  /// **'다음 날'**
  String get nextDay;

  /// No description provided for @noTitle.
  ///
  /// In ko, this message translates to:
  /// **'제목 없음'**
  String get noTitle;

  /// No description provided for @incomplete.
  ///
  /// In ko, this message translates to:
  /// **'미완료'**
  String get incomplete;

  /// No description provided for @revert.
  ///
  /// In ko, this message translates to:
  /// **'되돌리기'**
  String get revert;

  /// No description provided for @statusChange.
  ///
  /// In ko, this message translates to:
  /// **'상태 변경'**
  String get statusChange;

  /// No description provided for @timeBlockResult.
  ///
  /// In ko, this message translates to:
  /// **'타임블록 결과'**
  String get timeBlockResult;

  /// No description provided for @reverted.
  ///
  /// In ko, this message translates to:
  /// **'되돌림 처리되었습니다'**
  String get reverted;

  /// No description provided for @markedComplete.
  ///
  /// In ko, this message translates to:
  /// **'완료 처리되었습니다'**
  String get markedComplete;

  /// No description provided for @markedIncomplete.
  ///
  /// In ko, this message translates to:
  /// **'미완료 처리되었습니다'**
  String get markedIncomplete;

  /// No description provided for @deleteTimeBlock.
  ///
  /// In ko, this message translates to:
  /// **'타임블록 삭제'**
  String get deleteTimeBlock;

  /// No description provided for @deleteTimeBlockConfirm.
  ///
  /// In ko, this message translates to:
  /// **'이 타임블록을 삭제하시겠습니까?'**
  String get deleteTimeBlockConfirm;

  /// No description provided for @removeFromTop3.
  ///
  /// In ko, this message translates to:
  /// **'Top 3에서 제거'**
  String get removeFromTop3;

  /// No description provided for @scoreUp.
  ///
  /// In ko, this message translates to:
  /// **'어제보다 {change}점 상승!'**
  String scoreUp(int change);

  /// No description provided for @scoreDown.
  ///
  /// In ko, this message translates to:
  /// **'어제보다 {change}점 하락'**
  String scoreDown(int change);

  /// No description provided for @scoreSame.
  ///
  /// In ko, this message translates to:
  /// **'어제와 동일'**
  String get scoreSame;

  /// No description provided for @average.
  ///
  /// In ko, this message translates to:
  /// **'평균'**
  String get average;

  /// No description provided for @dailyReminderTitle.
  ///
  /// In ko, this message translates to:
  /// **'오늘의 계획을 세워보세요!'**
  String get dailyReminderTitle;

  /// No description provided for @dailyReminderBody.
  ///
  /// In ko, this message translates to:
  /// **'목표 달성을 위한 첫 걸음입니다.'**
  String get dailyReminderBody;

  /// No description provided for @monday.
  ///
  /// In ko, this message translates to:
  /// **'월요일'**
  String get monday;

  /// No description provided for @tuesday.
  ///
  /// In ko, this message translates to:
  /// **'화요일'**
  String get tuesday;

  /// No description provided for @wednesday.
  ///
  /// In ko, this message translates to:
  /// **'수요일'**
  String get wednesday;

  /// No description provided for @thursday.
  ///
  /// In ko, this message translates to:
  /// **'목요일'**
  String get thursday;

  /// No description provided for @friday.
  ///
  /// In ko, this message translates to:
  /// **'금요일'**
  String get friday;

  /// No description provided for @saturday.
  ///
  /// In ko, this message translates to:
  /// **'토요일'**
  String get saturday;

  /// No description provided for @sunday.
  ///
  /// In ko, this message translates to:
  /// **'일요일'**
  String get sunday;

  /// No description provided for @insightPeriodYesterday.
  ///
  /// In ko, this message translates to:
  /// **'어제'**
  String get insightPeriodYesterday;

  /// No description provided for @insightPeriodToday.
  ///
  /// In ko, this message translates to:
  /// **'오늘'**
  String get insightPeriodToday;

  /// No description provided for @insightPeriodWeekFirstHalf.
  ///
  /// In ko, this message translates to:
  /// **'이번 주 전반'**
  String get insightPeriodWeekFirstHalf;

  /// No description provided for @insightFocusTimeTitle.
  ///
  /// In ko, this message translates to:
  /// **'{dayName} {hour}시에 가장 집중력이 높았어요'**
  String insightFocusTimeTitle(String dayName, String hour);

  /// No description provided for @insightFocusTimeDesc.
  ///
  /// In ko, this message translates to:
  /// **'이 시간대에 중요한 작업을 배치해보세요'**
  String get insightFocusTimeDesc;

  /// No description provided for @insightTagAccuracyFasterTitle.
  ///
  /// In ko, this message translates to:
  /// **'{tagName} 태그 작업을 {minutes}분 빠르게 완료했어요'**
  String insightTagAccuracyFasterTitle(String tagName, String minutes);

  /// No description provided for @insightTagAccuracySlowerTitle.
  ///
  /// In ko, this message translates to:
  /// **'{tagName} 태그 작업에 {minutes}분 더 걸렸어요'**
  String insightTagAccuracySlowerTitle(String tagName, String minutes);

  /// No description provided for @insightTagAccuracyFasterDesc.
  ///
  /// In ko, this message translates to:
  /// **'예상 시간 산정이 정확해지고 있어요'**
  String get insightTagAccuracyFasterDesc;

  /// No description provided for @insightTagAccuracySlowerDesc.
  ///
  /// In ko, this message translates to:
  /// **'이 유형의 작업에 더 넉넉한 시간을 배분해보세요'**
  String get insightTagAccuracySlowerDesc;

  /// No description provided for @insightRolloverTitle.
  ///
  /// In ko, this message translates to:
  /// **'이월 작업이 {rolloverCount}건 중 {taskCount}건이에요'**
  String insightRolloverTitle(String rolloverCount, String taskCount);

  /// No description provided for @insightRolloverDesc.
  ///
  /// In ko, this message translates to:
  /// **'작업을 더 작게 나누거나 우선순위를 재조정해보세요'**
  String get insightRolloverDesc;

  /// No description provided for @insightStreakTitle.
  ///
  /// In ko, this message translates to:
  /// **'{days}일 연속으로 계획을 실행하고 있어요!'**
  String insightStreakTitle(String days);

  /// No description provided for @insightStreakDesc.
  ///
  /// In ko, this message translates to:
  /// **'꾸준함이 성공의 열쇠입니다'**
  String get insightStreakDesc;

  /// No description provided for @insightScoreUpTitle.
  ///
  /// In ko, this message translates to:
  /// **'{period} 대비 생산성이 {scoreDiff}점 올랐어요'**
  String insightScoreUpTitle(String period, String scoreDiff);

  /// No description provided for @insightScoreUpDesc.
  ///
  /// In ko, this message translates to:
  /// **'좋은 흐름을 유지하세요!'**
  String get insightScoreUpDesc;

  /// No description provided for @insightScoreDownTitle.
  ///
  /// In ko, this message translates to:
  /// **'{period} 대비 생산성이 {scoreDiff}점 떨어졌어요'**
  String insightScoreDownTitle(String period, String scoreDiff);

  /// No description provided for @insightScoreDownDesc.
  ///
  /// In ko, this message translates to:
  /// **'계획을 조금 조정해보세요'**
  String get insightScoreDownDesc;

  /// No description provided for @insightBestDayTitle.
  ///
  /// In ko, this message translates to:
  /// **'{dayName}이 가장 생산적인 요일이에요'**
  String insightBestDayTitle(String dayName);

  /// No description provided for @insightBestDayDesc.
  ///
  /// In ko, this message translates to:
  /// **'평균 점수: {score}점'**
  String insightBestDayDesc(String score);

  /// No description provided for @insightTimeSavedTitle.
  ///
  /// In ko, this message translates to:
  /// **'{period} 계획보다 {minutes}분 절약했어요'**
  String insightTimeSavedTitle(String period, String minutes);

  /// No description provided for @insightTimeSavedDesc.
  ///
  /// In ko, this message translates to:
  /// **'효율적인 시간 관리를 하고 있어요'**
  String get insightTimeSavedDesc;

  /// No description provided for @insightTimeOverTitle.
  ///
  /// In ko, this message translates to:
  /// **'{period} 계획보다 {minutes}분 초과했어요'**
  String insightTimeOverTitle(String period, String minutes);

  /// No description provided for @insightTimeOverDesc.
  ///
  /// In ko, this message translates to:
  /// **'시간 예측을 조금 여유 있게 설정해보세요'**
  String get insightTimeOverDesc;

  /// No description provided for @insightTaskFirstTitle.
  ///
  /// In ko, this message translates to:
  /// **'오늘 첫 번째 작업을 완료했어요!'**
  String get insightTaskFirstTitle;

  /// No description provided for @insightTaskFirstDesc.
  ///
  /// In ko, this message translates to:
  /// **'좋은 시작이에요'**
  String get insightTaskFirstDesc;

  /// No description provided for @insightTaskAllCompleteTitle.
  ///
  /// In ko, this message translates to:
  /// **'오늘의 모든 작업을 완료했어요!'**
  String get insightTaskAllCompleteTitle;

  /// No description provided for @insightTaskAllCompleteDesc.
  ///
  /// In ko, this message translates to:
  /// **'총 {total}개의 작업을 해냈어요'**
  String insightTaskAllCompleteDesc(String total);

  /// No description provided for @insightTaskNoneTitle.
  ///
  /// In ko, this message translates to:
  /// **'아직 완료한 작업이 없어요'**
  String get insightTaskNoneTitle;

  /// No description provided for @insightTaskNoneDesc.
  ///
  /// In ko, this message translates to:
  /// **'작은 것부터 시작해보세요'**
  String get insightTaskNoneDesc;

  /// No description provided for @insightTaskPartialTitle.
  ///
  /// In ko, this message translates to:
  /// **'{total}개 중 {completed}개 작업 완료'**
  String insightTaskPartialTitle(String total, String completed);

  /// No description provided for @insightTaskPartialDesc.
  ///
  /// In ko, this message translates to:
  /// **'{remaining}개 남았어요, 힘내세요!'**
  String insightTaskPartialDesc(String remaining);

  /// No description provided for @insightFocusEffTitle.
  ///
  /// In ko, this message translates to:
  /// **'집중 효율 {percent}%'**
  String insightFocusEffTitle(String percent);

  /// No description provided for @insightFocusEffHighDesc.
  ///
  /// In ko, this message translates to:
  /// **'높은 집중력을 유지하고 있어요'**
  String get insightFocusEffHighDesc;

  /// No description provided for @insightFocusEffMedDesc.
  ///
  /// In ko, this message translates to:
  /// **'집중력이 보통 수준이에요'**
  String get insightFocusEffMedDesc;

  /// No description provided for @insightFocusEffLowDesc.
  ///
  /// In ko, this message translates to:
  /// **'집중 환경을 개선해보세요'**
  String get insightFocusEffLowDesc;

  /// No description provided for @insightTimeEstTitle.
  ///
  /// In ko, this message translates to:
  /// **'시간 예측 정확도 {percent}%'**
  String insightTimeEstTitle(String percent);

  /// No description provided for @insightTimeEstHighDesc.
  ///
  /// In ko, this message translates to:
  /// **'시간 예측이 정확해요'**
  String get insightTimeEstHighDesc;

  /// No description provided for @insightTimeEstMedDesc.
  ///
  /// In ko, this message translates to:
  /// **'시간 예측을 조금 조정해보세요'**
  String get insightTimeEstMedDesc;

  /// No description provided for @insightTimeEstLowDesc.
  ///
  /// In ko, this message translates to:
  /// **'실제 소요 시간을 기록하여 예측을 개선해보세요'**
  String get insightTimeEstLowDesc;

  /// No description provided for @insightTop3AllCompleteTitle.
  ///
  /// In ko, this message translates to:
  /// **'Top 3를 모두 달성했어요!'**
  String get insightTop3AllCompleteTitle;

  /// No description provided for @insightTop3AllCompleteDesc.
  ///
  /// In ko, this message translates to:
  /// **'가장 중요한 일에 집중했어요'**
  String get insightTop3AllCompleteDesc;

  /// No description provided for @insightTop3PartialTitle.
  ///
  /// In ko, this message translates to:
  /// **'Top 3 중 {completed}개 달성'**
  String insightTop3PartialTitle(String completed);

  /// No description provided for @insightTop3PartialDesc.
  ///
  /// In ko, this message translates to:
  /// **'{remaining}개 더 달성해보세요'**
  String insightTop3PartialDesc(String remaining);

  /// No description provided for @insightScoreGreatTitle.
  ///
  /// In ko, this message translates to:
  /// **'훌륭한 하루였어요!'**
  String get insightScoreGreatTitle;

  /// No description provided for @insightScoreGreatDesc.
  ///
  /// In ko, this message translates to:
  /// **'생산성 점수 {score}점'**
  String insightScoreGreatDesc(String score);

  /// No description provided for @insightScoreNormalTitle.
  ///
  /// In ko, this message translates to:
  /// **'오늘도 수고했어요'**
  String get insightScoreNormalTitle;

  /// No description provided for @insightScoreNormalDesc.
  ///
  /// In ko, this message translates to:
  /// **'생산성 점수 {score}점'**
  String insightScoreNormalDesc(String score);

  /// No description provided for @insightWeekAvgTitle.
  ///
  /// In ko, this message translates to:
  /// **'이번 주 평균 점수: {score}점'**
  String insightWeekAvgTitle(String score);

  /// No description provided for @insightWeekAvgHighDesc.
  ///
  /// In ko, this message translates to:
  /// **'일주일 내내 훌륭했어요'**
  String get insightWeekAvgHighDesc;

  /// No description provided for @insightWeekAvgLowDesc.
  ///
  /// In ko, this message translates to:
  /// **'다음 주는 더 나아질 거에요'**
  String get insightWeekAvgLowDesc;

  /// No description provided for @insightMonthAvgTitle.
  ///
  /// In ko, this message translates to:
  /// **'이번 달 평균 점수: {score}점'**
  String insightMonthAvgTitle(String score);

  /// No description provided for @insightMonthAvgHighDesc.
  ///
  /// In ko, this message translates to:
  /// **'한 달 동안 꾸준히 잘 해왔어요'**
  String get insightMonthAvgHighDesc;

  /// No description provided for @insightMonthAvgLowDesc.
  ///
  /// In ko, this message translates to:
  /// **'목표를 재설정하고 다시 시작해보세요'**
  String get insightMonthAvgLowDesc;

  /// No description provided for @insightMonthBestTitle.
  ///
  /// In ko, this message translates to:
  /// **'이번 달 최고의 날: {month}월 {day}일'**
  String insightMonthBestTitle(String month, String day);

  /// No description provided for @insightMonthBestDesc.
  ///
  /// In ko, this message translates to:
  /// **'그날의 점수: {score}점'**
  String insightMonthBestDesc(String score);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'de',
    'en',
    'fr',
    'hi',
    'ja',
    'ko',
    'ru',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
    case 'hi':
      return AppLocalizationsHi();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
    case 'ru':
      return AppLocalizationsRu();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
