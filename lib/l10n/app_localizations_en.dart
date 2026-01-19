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
}
