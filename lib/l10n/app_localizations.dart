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
