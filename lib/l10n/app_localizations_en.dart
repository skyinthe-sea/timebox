// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Timebox Planner';

  @override
  String get inbox => 'Inbox';

  @override
  String get calendar => 'Calendar';

  @override
  String get focus => 'Focus';

  @override
  String get analytics => 'Analytics';

  @override
  String get settings => 'Settings';

  @override
  String get task => 'Task';

  @override
  String get tasks => 'Tasks';

  @override
  String get addTask => 'Add Task';

  @override
  String get editTask => 'Edit Task';

  @override
  String get deleteTask => 'Delete Task';

  @override
  String get taskTitle => 'Title';

  @override
  String get taskNote => 'Note';

  @override
  String get estimatedDuration => 'Estimated Duration';

  @override
  String get subtasks => 'Subtasks';

  @override
  String get addSubtask => 'Add Subtask';

  @override
  String get priority => 'Priority';

  @override
  String get priorityHigh => 'High';

  @override
  String get priorityMedium => 'Medium';

  @override
  String get priorityLow => 'Low';

  @override
  String get status => 'Status';

  @override
  String get statusTodo => 'To Do';

  @override
  String get statusInProgress => 'In Progress';

  @override
  String get statusCompleted => 'Completed';

  @override
  String get statusDelayed => 'Delayed';

  @override
  String get statusSkipped => 'Skipped';

  @override
  String get tag => 'Tag';

  @override
  String get tags => 'Tags';

  @override
  String get addTag => 'Add Tag';

  @override
  String get timeBlock => 'Time Block';

  @override
  String get createTimeBlock => 'Create Time Block';

  @override
  String get moveTimeBlock => 'Move Time Block';

  @override
  String get resizeTimeBlock => 'Resize Time Block';

  @override
  String get conflictDetected => 'Schedule conflict detected';

  @override
  String get focusMode => 'Focus Mode';

  @override
  String get startFocus => 'Start Focus';

  @override
  String get pauseFocus => 'Pause';

  @override
  String get resumeFocus => 'Resume';

  @override
  String get completeFocus => 'Complete';

  @override
  String get skipFocus => 'Skip';

  @override
  String get timeRemaining => 'Time Remaining';

  @override
  String get today => 'Today';

  @override
  String get tomorrow => 'Tomorrow';

  @override
  String get thisWeek => 'This Week';

  @override
  String get minutes => 'minutes';

  @override
  String get hours => 'hours';

  @override
  String minutesShort(int count) {
    return '${count}m';
  }

  @override
  String hoursShort(int count) {
    return '${count}h';
  }

  @override
  String get productivityScore => 'Productivity Score';

  @override
  String get plannedVsActual => 'Planned vs Actual';

  @override
  String get completionRate => 'Completion Rate';

  @override
  String get rolloverTasks => 'Rollover Tasks';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get language => 'Language';

  @override
  String get notifications => 'Notifications';

  @override
  String get calendarSync => 'Calendar Sync';

  @override
  String get profile => 'Profile';

  @override
  String get logout => 'Logout';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get confirm => 'Confirm';

  @override
  String get edit => 'Edit';

  @override
  String get done => 'Done';

  @override
  String get emptyInbox => 'Inbox is empty';

  @override
  String get emptyInboxDescription => 'Add a new task to get started';

  @override
  String get emptyCalendar => 'No schedule for today';

  @override
  String get emptyCalendarDescription => 'Drag tasks to create your schedule';

  @override
  String get error => 'Error';

  @override
  String get errorGeneric => 'Something went wrong';

  @override
  String get errorNetwork => 'Please check your network connection';

  @override
  String get retry => 'Retry';

  @override
  String get noActiveSession => 'No active session';

  @override
  String get startFocusDescription =>
      'Start a focus session to boost your productivity';

  @override
  String get quickStart => 'Quick Start';

  @override
  String get paused => 'Paused';

  @override
  String get skip => 'Skip';

  @override
  String get complete => 'Complete';

  @override
  String get sessionCompleted => 'Session Completed!';

  @override
  String get selectDuration => 'Select Duration';

  @override
  String get filter => 'Filter';

  @override
  String get all => 'All';

  @override
  String get statusDone => 'Done';

  @override
  String get emptyInboxTitle => 'Inbox is empty';

  @override
  String get toDo => 'To Do';

  @override
  String get completed => 'Completed';

  @override
  String get deleteTaskConfirm => 'Delete this task?';

  @override
  String get taskTitleHint => 'What do you need to do?';

  @override
  String get lessOptions => 'Less options';

  @override
  String get moreOptions => 'More options';

  @override
  String get taskNoteHint => 'Add a note...';

  @override
  String get title => 'Title';

  @override
  String get timeBlockTitleHint => 'Enter block name';

  @override
  String get startTime => 'Start Time';

  @override
  String get endTime => 'End Time';

  @override
  String get add => 'Add';

  @override
  String get top3 => 'Top 3 Priorities';

  @override
  String get rank1 => '1st';

  @override
  String get rank2 => '2nd';

  @override
  String get rank3 => '3rd';

  @override
  String get brainDump => 'Brain Dump';

  @override
  String get timeline => 'Timeline';

  @override
  String get dragToSchedule => 'Drag tasks here to schedule';

  @override
  String get emptyTop3Slot => 'Tap or drag to add';

  @override
  String get dayStartTime => 'Day Start Time';

  @override
  String get dayEndTime => 'Day End Time';

  @override
  String get planner => 'Timebox';

  @override
  String get copyToTomorrow => 'Copy to tomorrow';

  @override
  String get copiedToTomorrow => 'Copied to tomorrow';

  @override
  String rolloverBadge(int count) {
    return 'Rollover ${count}x';
  }

  @override
  String get appearance => 'Appearance';

  @override
  String get theme => 'Theme';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get notificationDescription => 'Receive time block notifications';

  @override
  String get notificationTiming => 'Notification Timing';

  @override
  String minutesBefore(int count) {
    return '$count min before';
  }

  @override
  String get noCalendarConnected => 'No calendar connected';

  @override
  String get comingSoon => 'Coming soon';

  @override
  String get timeSettings => 'Time Settings';

  @override
  String get dayTimeRange => 'Day Time Range';

  @override
  String get defaultTimeBlockDuration => 'Default Time Block Duration';

  @override
  String get data => 'Data';

  @override
  String get exportData => 'Export Data';

  @override
  String get exportDataDescription => 'Export to CSV file';

  @override
  String get resetSettings => 'Reset Settings';

  @override
  String get resetSettingsConfirm => 'Reset all settings to defaults?';

  @override
  String get settingsReset => 'Settings have been reset';

  @override
  String get longPressToSelect => 'Long press to select time range';

  @override
  String get selectTask => 'Select a task';

  @override
  String get noUnscheduledTasks => 'No unscheduled tasks';

  @override
  String get addNewTask => 'Add new task';

  @override
  String get addNewTaskHint => 'Enter task title...';

  @override
  String timeRangeLabel(String start, String end) {
    return '$start - $end';
  }

  @override
  String get assignToTimeBlock => 'Assign to time block';

  @override
  String get mergeBlocks => 'Merge blocks';

  @override
  String get overlapWarning => 'Warning: Time blocks overlap';

  @override
  String get taskAssigned => 'Task assigned';

  @override
  String get tapToCancel => 'Tap outside to cancel';

  @override
  String get statistics => 'Statistics';

  @override
  String get todayHighlights => 'Today\'s Highlights';

  @override
  String get completedTasksCount => 'Completed Tasks';

  @override
  String get focusTimeMinutes => 'Focus Time';

  @override
  String get timeSavedMinutes => 'Time Saved';

  @override
  String get top3Achievement => 'Top 3 Achievement';

  @override
  String get trend => 'Trend';

  @override
  String get tagAnalysis => 'Tag Analysis';

  @override
  String get insights => 'Insights';

  @override
  String get daily => 'Daily';

  @override
  String get weekly => 'Weekly';

  @override
  String get monthly => 'Monthly';

  @override
  String get focusModeTooltip => 'Focus Mode';

  @override
  String get startAlarm => 'Start Alarm';

  @override
  String get endAlarm => 'End Alarm';

  @override
  String get notifyBeforeStart => 'Notify before start';

  @override
  String get notifyBeforeEnd => 'Notify before end';

  @override
  String get selectMultipleTimings => 'You can select multiple times';

  @override
  String get dailyReminder => 'Daily Reminder';

  @override
  String get dailyReminderDesc =>
      'Get notified on days you haven\'t opened the app';

  @override
  String get dailyReminderTime => 'Reminder Time';

  @override
  String get notificationPermissionRequired =>
      'Notification permission required';

  @override
  String get notificationPermissionDesc =>
      'Please allow notification permission to receive time block alerts';

  @override
  String get openSettings => 'Open Settings';

  @override
  String get permissionGranted => 'Permission granted';

  @override
  String get permissionDenied => 'Permission denied';

  @override
  String get requestPermission => 'Request Permission';

  @override
  String hourBefore(int count) {
    return '${count}h before';
  }

  @override
  String get alarmSettings => 'Alarm Settings';

  @override
  String get alarmTimingNote => 'Multiple selection available';

  @override
  String get noonTime => 'Noon (12:00)';

  @override
  String get mathChallenge => 'Math Challenge';

  @override
  String mathChallengeProgress(int current, int total) {
    return '$current / $total';
  }

  @override
  String get enterAnswer => 'Enter answer';

  @override
  String get wrongAnswer => 'Incorrect. Please try again.';

  @override
  String get focusLockEnabled => 'Screen lock enabled';

  @override
  String get overlayPermissionRequired => 'Overlay permission required';

  @override
  String get noActiveTimeBlock => 'No active time block';

  @override
  String get createTimeBlockFirst =>
      'Create a time block first from the calendar';

  @override
  String get exitFocus => 'Exit';

  @override
  String get statsCompletionRates => 'Completion Rates';

  @override
  String get statsTaskPipeline => 'Task Pipeline';

  @override
  String get statsPlanVsActual => 'Plan vs Actual';

  @override
  String get statsPriorityBreakdown => 'Priority Performance';

  @override
  String get statsFocusSummary => 'Focus Analysis';

  @override
  String get statsTopInsights => 'Insights';

  @override
  String get statsScheduled => 'Scheduled';

  @override
  String get statsCompleted => 'Completed';

  @override
  String get statsRolledOver => 'Rolled Over';

  @override
  String get statsEfficiency => 'Efficiency';

  @override
  String get statsNoData => 'No data yet';

  @override
  String get navTimeline => 'Timeline';

  @override
  String get navReport => 'Report';

  @override
  String get suggestedTasks => 'Suggestions';

  @override
  String get taskSuggestionsHint => 'Tasks you\'ve done before';

  @override
  String get topSuccessTasks => 'Most Completed Tasks';

  @override
  String get topFailureTasks => 'Hardest to Complete';

  @override
  String get completionCount => 'Completion Count';

  @override
  String get taskRankings => 'Task Rankings';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get termsOfService => 'Terms of Service';

  @override
  String get privacyPolicyContent =>
      'Privacy Policy\n\nLast updated: January 1, 2026\n\n1. Data Collection\nThis app processes user-entered data such as tasks and time records.\n\n2. Data Storage\nAll data is stored locally on your device only. No data is transmitted to external servers.\n\n3. Third Parties\nThis app uses Google AdMob for advertising. AdMob may collect advertising identifiers. Please refer to Google\'s Privacy Policy for details.\n\n4. Data Deletion\nAll data stored on the device is automatically deleted when you uninstall the app.\n\n5. Contact\nFor privacy inquiries: myclick90@gmail.com';

  @override
  String get termsOfServiceContent =>
      'Terms of Service\n\nLast updated: January 1, 2026\n\n1. Service Description\nTimebox Planner is a mobile application that helps you manage your time and plan your schedule.\n\n2. User Responsibilities\nUsers are responsible for all data entered into the app and must use the app only for lawful purposes.\n\n3. Disclaimer\nThis app is provided \"as is\". The developer is not liable for any direct or indirect damages caused by data loss, missed schedules, or other issues.\n\n4. Intellectual Property\nAll intellectual property rights in the app\'s design, code, and content belong to the developer.\n\n5. Changes to Terms\nThese terms may be modified with prior notice. Changes will be communicated through app updates.';

  @override
  String durationFormat(int hours, int minutes) {
    return '${hours}h ${minutes}m';
  }

  @override
  String get previousDay => 'Previous day';

  @override
  String get nextDay => 'Next day';

  @override
  String get noTitle => 'No title';

  @override
  String get incomplete => 'Incomplete';

  @override
  String get revert => 'Revert';

  @override
  String get statusChange => 'Status Change';

  @override
  String get timeBlockResult => 'Time Block Result';

  @override
  String get reverted => 'Reverted';

  @override
  String get markedComplete => 'Marked as complete';

  @override
  String get markedIncomplete => 'Marked as incomplete';

  @override
  String get deleteTimeBlock => 'Delete Time Block';

  @override
  String get deleteTimeBlockConfirm =>
      'Are you sure you want to delete this time block?';

  @override
  String get removeFromTop3 => 'Remove from Top 3';

  @override
  String scoreUp(int change) {
    return '+$change from yesterday!';
  }

  @override
  String scoreDown(int change) {
    return '-$change from yesterday';
  }

  @override
  String get scoreSame => 'Same as yesterday';

  @override
  String get average => 'avg';

  @override
  String get dailyReminderTitle => 'Plan your day!';

  @override
  String get dailyReminderBody => 'The first step to achieving your goals.';

  @override
  String get monday => 'Monday';

  @override
  String get tuesday => 'Tuesday';

  @override
  String get wednesday => 'Wednesday';

  @override
  String get thursday => 'Thursday';

  @override
  String get friday => 'Friday';

  @override
  String get saturday => 'Saturday';

  @override
  String get sunday => 'Sunday';

  @override
  String get insightPeriodYesterday => 'yesterday';

  @override
  String get insightPeriodToday => 'today';

  @override
  String get insightPeriodWeekFirstHalf => 'the first half of this week';

  @override
  String insightFocusTimeTitle(String dayName, String hour) {
    return 'Peak focus at $hour:00 on $dayName';
  }

  @override
  String get insightFocusTimeDesc =>
      'Try scheduling important tasks during this time';

  @override
  String insightTagAccuracyFasterTitle(String tagName, String minutes) {
    return 'Completed $tagName tasks ${minutes}m faster';
  }

  @override
  String insightTagAccuracySlowerTitle(String tagName, String minutes) {
    return '$tagName tasks took ${minutes}m longer';
  }

  @override
  String get insightTagAccuracyFasterDesc =>
      'Your time estimates are getting more accurate';

  @override
  String get insightTagAccuracySlowerDesc =>
      'Try allocating more time for this type of task';

  @override
  String insightRolloverTitle(String rolloverCount, String taskCount) {
    return '$rolloverCount out of $taskCount tasks were rolled over';
  }

  @override
  String get insightRolloverDesc =>
      'Try breaking tasks into smaller pieces or reprioritizing';

  @override
  String insightStreakTitle(String days) {
    return '$days-day streak of executing your plan!';
  }

  @override
  String get insightStreakDesc => 'Consistency is the key to success';

  @override
  String insightScoreUpTitle(String period, String scoreDiff) {
    return 'Productivity up $scoreDiff points vs $period';
  }

  @override
  String get insightScoreUpDesc => 'Keep up the great momentum!';

  @override
  String insightScoreDownTitle(String period, String scoreDiff) {
    return 'Productivity down $scoreDiff points vs $period';
  }

  @override
  String get insightScoreDownDesc => 'Try adjusting your plan a bit';

  @override
  String insightBestDayTitle(String dayName) {
    return '$dayName is your most productive day';
  }

  @override
  String insightBestDayDesc(String score) {
    return 'Average score: $score points';
  }

  @override
  String insightTimeSavedTitle(String period, String minutes) {
    return 'Saved ${minutes}m vs $period plan';
  }

  @override
  String get insightTimeSavedDesc => 'You\'re managing your time efficiently';

  @override
  String insightTimeOverTitle(String period, String minutes) {
    return 'Exceeded plan by ${minutes}m vs $period';
  }

  @override
  String get insightTimeOverDesc => 'Try setting more generous time estimates';

  @override
  String get insightTaskFirstTitle => 'Completed your first task today!';

  @override
  String get insightTaskFirstDesc => 'Great start';

  @override
  String get insightTaskAllCompleteTitle => 'All tasks completed today!';

  @override
  String insightTaskAllCompleteDesc(String total) {
    return 'Finished all $total tasks';
  }

  @override
  String get insightTaskNoneTitle => 'No tasks completed yet';

  @override
  String get insightTaskNoneDesc => 'Start with something small';

  @override
  String insightTaskPartialTitle(String total, String completed) {
    return '$completed of $total tasks completed';
  }

  @override
  String insightTaskPartialDesc(String remaining) {
    return '$remaining to go, keep it up!';
  }

  @override
  String insightFocusEffTitle(String percent) {
    return 'Focus efficiency: $percent%';
  }

  @override
  String get insightFocusEffHighDesc => 'Maintaining high focus';

  @override
  String get insightFocusEffMedDesc => 'Focus level is moderate';

  @override
  String get insightFocusEffLowDesc => 'Try improving your focus environment';

  @override
  String insightTimeEstTitle(String percent) {
    return 'Time estimation accuracy: $percent%';
  }

  @override
  String get insightTimeEstHighDesc => 'Your time estimates are accurate';

  @override
  String get insightTimeEstMedDesc => 'Consider adjusting your time estimates';

  @override
  String get insightTimeEstLowDesc =>
      'Record actual times to improve estimation';

  @override
  String get insightTop3AllCompleteTitle => 'All Top 3 achieved!';

  @override
  String get insightTop3AllCompleteDesc => 'Focused on what matters most';

  @override
  String insightTop3PartialTitle(String completed) {
    return '$completed of Top 3 achieved';
  }

  @override
  String insightTop3PartialDesc(String remaining) {
    return '$remaining more to go';
  }

  @override
  String get insightScoreGreatTitle => 'What a great day!';

  @override
  String insightScoreGreatDesc(String score) {
    return 'Productivity score: $score';
  }

  @override
  String get insightScoreNormalTitle => 'Good work today';

  @override
  String insightScoreNormalDesc(String score) {
    return 'Productivity score: $score';
  }

  @override
  String insightWeekAvgTitle(String score) {
    return 'Weekly average: $score points';
  }

  @override
  String get insightWeekAvgHighDesc => 'Great performance all week';

  @override
  String get insightWeekAvgLowDesc => 'Next week will be better';

  @override
  String insightMonthAvgTitle(String score) {
    return 'Monthly average: $score points';
  }

  @override
  String get insightMonthAvgHighDesc => 'Consistent performance all month';

  @override
  String get insightMonthAvgLowDesc => 'Reset your goals and try again';

  @override
  String insightMonthBestTitle(String month, String day) {
    return 'Best day this month: $month/$day';
  }

  @override
  String insightMonthBestDesc(String score) {
    return 'Score that day: $score points';
  }
}
