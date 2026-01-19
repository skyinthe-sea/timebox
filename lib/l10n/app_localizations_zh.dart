// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appName => '时间盒规划器';

  @override
  String get inbox => '收件箱';

  @override
  String get calendar => '日历';

  @override
  String get focus => '专注';

  @override
  String get analytics => '分析';

  @override
  String get settings => '设置';

  @override
  String get task => '任务';

  @override
  String get tasks => '任务列表';

  @override
  String get addTask => '添加任务';

  @override
  String get editTask => '编辑任务';

  @override
  String get deleteTask => '删除任务';

  @override
  String get taskTitle => '标题';

  @override
  String get taskNote => '备注';

  @override
  String get estimatedDuration => '预计时长';

  @override
  String get subtasks => '子任务';

  @override
  String get addSubtask => '添加子任务';

  @override
  String get priority => '优先级';

  @override
  String get priorityHigh => '高';

  @override
  String get priorityMedium => '中';

  @override
  String get priorityLow => '低';

  @override
  String get status => '状态';

  @override
  String get statusTodo => '待办';

  @override
  String get statusInProgress => '进行中';

  @override
  String get statusCompleted => '已完成';

  @override
  String get statusDelayed => '已延迟';

  @override
  String get statusSkipped => '已跳过';

  @override
  String get tag => '标签';

  @override
  String get tags => '标签列表';

  @override
  String get addTag => '添加标签';

  @override
  String get timeBlock => '时间块';

  @override
  String get createTimeBlock => '创建时间块';

  @override
  String get moveTimeBlock => '移动时间块';

  @override
  String get resizeTimeBlock => '调整时间块大小';

  @override
  String get conflictDetected => '检测到日程冲突';

  @override
  String get focusMode => '专注模式';

  @override
  String get startFocus => '开始专注';

  @override
  String get pauseFocus => '暂停';

  @override
  String get resumeFocus => '继续';

  @override
  String get completeFocus => '完成';

  @override
  String get skipFocus => '跳过';

  @override
  String get timeRemaining => '剩余时间';

  @override
  String get today => '今天';

  @override
  String get tomorrow => '明天';

  @override
  String get thisWeek => '本周';

  @override
  String get minutes => '分钟';

  @override
  String get hours => '小时';

  @override
  String minutesShort(int count) {
    return '$count分';
  }

  @override
  String hoursShort(int count) {
    return '$count时';
  }

  @override
  String get productivityScore => '生产力评分';

  @override
  String get plannedVsActual => '计划 vs 实际';

  @override
  String get completionRate => '完成率';

  @override
  String get rolloverTasks => '顺延任务';

  @override
  String get darkMode => '深色模式';

  @override
  String get language => '语言';

  @override
  String get notifications => '通知';

  @override
  String get calendarSync => '日历同步';

  @override
  String get profile => '个人资料';

  @override
  String get logout => '退出登录';

  @override
  String get save => '保存';

  @override
  String get cancel => '取消';

  @override
  String get delete => '删除';

  @override
  String get confirm => '确认';

  @override
  String get edit => '编辑';

  @override
  String get done => '完成';

  @override
  String get emptyInbox => '收件箱为空';

  @override
  String get emptyInboxDescription => '添加新任务开始使用';

  @override
  String get emptyCalendar => '今天没有日程';

  @override
  String get emptyCalendarDescription => '拖动任务创建您的日程';

  @override
  String get error => '错误';

  @override
  String get errorGeneric => '出了点问题';

  @override
  String get errorNetwork => '请检查网络连接';

  @override
  String get retry => '重试';
}
