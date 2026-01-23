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
}
