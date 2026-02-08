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
  String get tagWork => '工作';

  @override
  String get tagPersonal => '个人';

  @override
  String get tagHealth => '健康';

  @override
  String get tagStudy => '学习';

  @override
  String get selectTag => '选择标签';

  @override
  String get newTag => '新标签';

  @override
  String get tagNameHint => '标签名称';

  @override
  String get selectColor => '选择颜色';

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

  @override
  String get noActiveSession => '没有进行中的会话';

  @override
  String get startFocusDescription => '开始专注会话以提高生产力';

  @override
  String get quickStart => '快速开始';

  @override
  String get paused => '已暂停';

  @override
  String get skip => '跳过';

  @override
  String get complete => '完成';

  @override
  String get sessionCompleted => '会话完成！';

  @override
  String get selectDuration => '选择时长';

  @override
  String get filter => '筛选';

  @override
  String get all => '全部';

  @override
  String get statusDone => '已完成';

  @override
  String get emptyInboxTitle => '收件箱为空';

  @override
  String get toDo => '待办';

  @override
  String get completed => '已完成';

  @override
  String get deleteTaskConfirm => '删除此任务？';

  @override
  String get taskTitleHint => '你需要做什么？';

  @override
  String get lessOptions => '收起选项';

  @override
  String get moreOptions => '更多选项';

  @override
  String get taskNoteHint => '添加备注...';

  @override
  String get title => '标题';

  @override
  String get timeBlockTitleHint => '输入时间块名称';

  @override
  String get startTime => '开始时间';

  @override
  String get endTime => '结束时间';

  @override
  String get add => '添加';

  @override
  String get top3 => '最重要的3件事';

  @override
  String get rank1 => '第1';

  @override
  String get rank2 => '第2';

  @override
  String get rank3 => '第3';

  @override
  String get brainDump => '头脑风暴';

  @override
  String get timeline => '时间轴';

  @override
  String get dragToSchedule => '拖拽到此处安排日程';

  @override
  String get emptyTop3Slot => '点击或拖拽添加';

  @override
  String get dayStartTime => '一天开始时间';

  @override
  String get dayEndTime => '一天结束时间';

  @override
  String get planner => '时间盒';

  @override
  String get copyToTomorrow => '移至明天';

  @override
  String get copiedToTomorrow => '已移至明天';

  @override
  String rolloverBadge(int count) {
    return '顺延 $count次';
  }

  @override
  String get appearance => '外观';

  @override
  String get theme => '主题';

  @override
  String get themeSystem => '跟随系统';

  @override
  String get themeLight => '浅色';

  @override
  String get themeDark => '深色';

  @override
  String get notificationDescription => '接收时间块通知';

  @override
  String get notificationTiming => '通知时间';

  @override
  String minutesBefore(int count) {
    return '$count分钟前';
  }

  @override
  String get noCalendarConnected => '未连接日历';

  @override
  String get comingSoon => '即将推出';

  @override
  String get timeSettings => '时间设置';

  @override
  String get dayTimeRange => '每日时间范围';

  @override
  String get defaultTimeBlockDuration => '默认时间块时长';

  @override
  String get data => '数据';

  @override
  String get exportData => '导出数据';

  @override
  String get exportDataDescription => '导出为CSV文件';

  @override
  String get resetSettings => '重置设置';

  @override
  String get resetSettingsConfirm => '将所有设置恢复为默认值？';

  @override
  String get settingsReset => '设置已重置';

  @override
  String get longPressToSelect => '长按选择时间范围';

  @override
  String get selectTask => '选择任务';

  @override
  String get noUnscheduledTasks => '没有未安排的任务';

  @override
  String get addNewTask => '添加新任务';

  @override
  String get addNewTaskHint => '输入任务标题...';

  @override
  String timeRangeLabel(String start, String end) {
    return '$start - $end';
  }

  @override
  String get assignToTimeBlock => '分配到时间块';

  @override
  String get mergeBlocks => '合并时间块';

  @override
  String get overlapWarning => '警告：时间块重叠';

  @override
  String get taskAssigned => '任务已分配';

  @override
  String get tapToCancel => '点击外部取消';

  @override
  String get statistics => '统计';

  @override
  String get todayHighlights => '今日亮点';

  @override
  String get completedTasksCount => '完成任务';

  @override
  String get focusTimeMinutes => '专注时间';

  @override
  String get timeSavedMinutes => '节省时间';

  @override
  String get top3Achievement => 'Top 3 达成';

  @override
  String get trend => '生产力趋势';

  @override
  String get tagAnalysis => '标签分析';

  @override
  String get insights => '洞察';

  @override
  String get daily => '每日';

  @override
  String get weekly => '每周';

  @override
  String get monthly => '每月';

  @override
  String get focusModeTooltip => '专注模式';

  @override
  String get startAlarm => '开始提醒';

  @override
  String get endAlarm => '结束提醒';

  @override
  String get notifyBeforeStart => '开始前通知';

  @override
  String get notifyBeforeEnd => '结束前通知';

  @override
  String get selectMultipleTimings => '可以选择多个时间';

  @override
  String get dailyReminder => '每日提醒';

  @override
  String get dailyReminderDesc => '未打开应用的日子接收通知';

  @override
  String get dailyReminderTime => '提醒时间';

  @override
  String get notificationPermissionRequired => '需要通知权限';

  @override
  String get notificationPermissionDesc => '请允许通知权限以接收时间块提醒';

  @override
  String get openSettings => '打开设置';

  @override
  String get permissionGranted => '已授权';

  @override
  String get permissionDenied => '已拒绝';

  @override
  String get requestPermission => '请求权限';

  @override
  String hourBefore(int count) {
    return '$count小时前';
  }

  @override
  String get alarmSettings => '提醒设置';

  @override
  String get alarmTimingNote => '可多选';

  @override
  String get noonTime => '中午 (12:00)';

  @override
  String get mathChallenge => '数学题';

  @override
  String mathChallengeProgress(int current, int total) {
    return '$current / $total';
  }

  @override
  String get enterAnswer => '输入答案';

  @override
  String get wrongAnswer => '答案错误，请重试。';

  @override
  String get focusLockEnabled => '屏幕锁定已启用';

  @override
  String get overlayPermissionRequired => '需要悬浮窗权限';

  @override
  String get noActiveTimeBlock => '没有正在进行的时间块';

  @override
  String get createTimeBlockFirst => '请先在日历中创建时间块';

  @override
  String get exitFocus => '退出';

  @override
  String get statsCompletionRates => '完成率';

  @override
  String get statsTaskPipeline => '任务流程';

  @override
  String get statsPlanVsActual => '计划 vs 实际';

  @override
  String get statsPriorityBreakdown => '优先级表现';

  @override
  String get statsFocusSummary => '专注分析';

  @override
  String get statsTopInsights => '洞察';

  @override
  String get statsScheduled => '已安排';

  @override
  String get statsCompleted => '已完成';

  @override
  String get statsRolledOver => '已顺延';

  @override
  String get statsEfficiency => '准确度';

  @override
  String get statsAccomplished => '达成';

  @override
  String get statsNoData => '暂无数据';

  @override
  String get statsTop3Performance => 'Top 3 达成情况';

  @override
  String get statsTop3Completed => '已完成';

  @override
  String get statsTop3Days => '设置Top 3的天数';

  @override
  String get statsTop3PerfectDays => '全部完成的天数';

  @override
  String get statsTop3Daily => '每日达成情况';

  @override
  String get days => '天';

  @override
  String get navTimeline => '时间线';

  @override
  String get navReport => '报告';

  @override
  String get suggestedTasks => '推荐任务';

  @override
  String get taskSuggestionsHint => '您之前做过的任务';

  @override
  String get topSuccessTasks => '完成率最高的任务';

  @override
  String get topFailureTasks => '最难完成的任务';

  @override
  String get completionCount => '完成次数';

  @override
  String get taskRankings => '任务排名';

  @override
  String get privacyPolicy => '隐私政策';

  @override
  String get termsOfService => '服务条款';

  @override
  String get privacyPolicyContent =>
      '隐私政策\n\n最后更新：2026年1月1日\n\n1. 数据收集\n本应用处理用户输入的数据，如任务和时间记录。\n\n2. 数据存储\n所有数据仅存储在您的设备本地，不会传输到外部服务器。\n\n3. 第三方\n本应用使用Google AdMob进行广告展示。AdMob可能会收集广告标识符。详情请参阅Google隐私政策。\n\n4. 数据删除\n卸载应用时，设备上存储的所有数据将自动删除。\n\n5. 联系方式\n隐私相关咨询：myclick90@gmail.com';

  @override
  String get termsOfServiceContent =>
      '服务条款\n\n最后更新：2026年1月1日\n\n1. 服务说明\nTimebox Planner是一款帮助您管理时间和规划日程的移动应用程序。\n\n2. 用户责任\n用户对输入到应用中的所有数据负责，且只能将应用用于合法目的。\n\n3. 免责声明\n本应用按\"原样\"提供。对于数据丢失、日程遗漏等问题造成的直接或间接损失，开发者不承担责任。\n\n4. 知识产权\n应用的设计、代码和内容的所有知识产权归开发者所有。\n\n5. 条款变更\n本条款可能会在事先通知后进行修改。变更将通过应用更新进行通知。';

  @override
  String durationFormat(int hours, int minutes) {
    return '$hours时$minutes分';
  }

  @override
  String get previousDay => '前一天';

  @override
  String get nextDay => '后一天';

  @override
  String get noTitle => '无标题';

  @override
  String get incomplete => '未完成';

  @override
  String get revert => '恢复';

  @override
  String get statusChange => '状态变更';

  @override
  String get timeBlockResult => '时间块结果';

  @override
  String get reverted => '已恢复';

  @override
  String get markedComplete => '已标记为完成';

  @override
  String get markedIncomplete => '已标记为未完成';

  @override
  String get deleteTimeBlock => '删除时间块';

  @override
  String get deleteTimeBlockConfirm => '确定要删除此时间块吗？';

  @override
  String get removeFromTop3 => '从Top 3中移除';

  @override
  String scoreUp(int change) {
    return '比昨天提高$change分！';
  }

  @override
  String scoreDown(int change) {
    return '比昨天降低$change分';
  }

  @override
  String get scoreSame => '与昨天持平';

  @override
  String get average => '平均';

  @override
  String get dailyReminderTitle => '来制定今天的计划吧！';

  @override
  String get dailyReminderBody => '实现目标的第一步。';

  @override
  String get monday => '星期一';

  @override
  String get tuesday => '星期二';

  @override
  String get wednesday => '星期三';

  @override
  String get thursday => '星期四';

  @override
  String get friday => '星期五';

  @override
  String get saturday => '星期六';

  @override
  String get sunday => '星期日';

  @override
  String get insightPeriodYesterday => '昨天';

  @override
  String get insightPeriodToday => '今天';

  @override
  String get insightPeriodWeekFirstHalf => '本周前半段';

  @override
  String insightFocusTimeTitle(String dayName, String hour) {
    return '$dayName$hour点专注力最高';
  }

  @override
  String get insightFocusTimeDesc => '尝试在这个时间段安排重要任务';

  @override
  String insightTagAccuracyFasterTitle(String tagName, String minutes) {
    return '$tagName类任务提前$minutes分钟完成';
  }

  @override
  String insightTagAccuracySlowerTitle(String tagName, String minutes) {
    return '$tagName类任务多用了$minutes分钟';
  }

  @override
  String get insightTagAccuracyFasterDesc => '你的时间估算越来越准确了';

  @override
  String get insightTagAccuracySlowerDesc => '尝试为这类任务分配更多时间';

  @override
  String insightRolloverTitle(String rolloverCount, String taskCount) {
    return '$taskCount个任务中有$rolloverCount个被顺延';
  }

  @override
  String get insightRolloverDesc => '尝试将任务拆分或重新排列优先级';

  @override
  String insightStreakTitle(String days) {
    return '连续$days天执行计划！';
  }

  @override
  String get insightStreakDesc => '坚持是成功的关键';

  @override
  String insightScoreUpTitle(String period, String scoreDiff) {
    return '相比$period，生产力提高了$scoreDiff分';
  }

  @override
  String get insightScoreUpDesc => '保持这个好势头！';

  @override
  String insightScoreDownTitle(String period, String scoreDiff) {
    return '相比$period，生产力下降了$scoreDiff分';
  }

  @override
  String get insightScoreDownDesc => '尝试调整一下计划';

  @override
  String insightBestDayTitle(String dayName) {
    return '$dayName是你最高效的一天';
  }

  @override
  String insightBestDayDesc(String score) {
    return '平均得分：$score分';
  }

  @override
  String insightTimeSavedTitle(String period, String minutes) {
    return '比$period计划节省了$minutes分钟';
  }

  @override
  String get insightTimeSavedDesc => '你的时间管理很高效';

  @override
  String insightTimeOverTitle(String period, String minutes) {
    return '比$period计划超出$minutes分钟';
  }

  @override
  String get insightTimeOverDesc => '尝试设置更宽裕的时间估算';

  @override
  String get insightTaskFirstTitle => '完成了今天的第一个任务！';

  @override
  String get insightTaskFirstDesc => '好的开始';

  @override
  String get insightTaskAllCompleteTitle => '今天所有任务都完成了！';

  @override
  String insightTaskAllCompleteDesc(String total) {
    return '共完成$total个任务';
  }

  @override
  String get insightTaskNoneTitle => '还没有完成的任务';

  @override
  String get insightTaskNoneDesc => '从小事做起';

  @override
  String insightTaskPartialTitle(String total, String completed) {
    return '$total个中完成了$completed个任务';
  }

  @override
  String insightTaskPartialDesc(String remaining) {
    return '还剩$remaining个，加油！';
  }

  @override
  String insightFocusEffTitle(String percent) {
    return '专注效率 $percent%';
  }

  @override
  String get insightFocusEffHighDesc => '保持着高度专注';

  @override
  String get insightFocusEffMedDesc => '专注力处于中等水平';

  @override
  String get insightFocusEffLowDesc => '尝试改善专注环境';

  @override
  String insightTimeEstTitle(String percent) {
    return '时间估算准确度 $percent%';
  }

  @override
  String get insightTimeEstHighDesc => '时间估算很准确';

  @override
  String get insightTimeEstMedDesc => '考虑调整时间估算';

  @override
  String get insightTimeEstLowDesc => '记录实际用时来改善估算';

  @override
  String get insightTop3AllCompleteTitle => 'Top 3全部达成！';

  @override
  String get insightTop3AllCompleteDesc => '专注于最重要的事情';

  @override
  String insightTop3PartialTitle(String completed) {
    return 'Top 3中完成了$completed个';
  }

  @override
  String insightTop3PartialDesc(String remaining) {
    return '还有$remaining个待完成';
  }

  @override
  String get insightScoreGreatTitle => '太棒了！';

  @override
  String insightScoreGreatDesc(String score) {
    return '生产力得分 $score分';
  }

  @override
  String get insightScoreNormalTitle => '今天辛苦了';

  @override
  String insightScoreNormalDesc(String score) {
    return '生产力得分 $score分';
  }

  @override
  String insightWeekAvgTitle(String score) {
    return '本周平均：$score分';
  }

  @override
  String get insightWeekAvgHighDesc => '整周表现出色';

  @override
  String get insightWeekAvgLowDesc => '下周会更好';

  @override
  String insightMonthAvgTitle(String score) {
    return '本月平均：$score分';
  }

  @override
  String get insightMonthAvgHighDesc => '一整个月都很稳定';

  @override
  String get insightMonthAvgLowDesc => '重新设定目标再出发';

  @override
  String insightMonthBestTitle(String month, String day) {
    return '本月最佳日：$month月$day日';
  }

  @override
  String insightMonthBestDesc(String score) {
    return '当天得分：$score分';
  }

  @override
  String get demoMode => '演示模式';

  @override
  String get demoModeDescription => '用于App Store截图的示例数据';

  @override
  String get demoModeEnable => '启用演示模式';

  @override
  String get demoModeDisable => '禁用演示模式';

  @override
  String get demoModeEnabled => '演示模式已启用';

  @override
  String get demoModeDisabled => '演示模式已禁用';

  @override
  String get demoModeGenerating => '正在生成示例数据...';

  @override
  String get demoModeClearing => '正在清除演示数据...';

  @override
  String timeBlockStartAlarmTitle(String title, String time) {
    return '$title - 开始前$time';
  }

  @override
  String get timeBlockStartAlarmBody => '即将开始，请做好准备！';

  @override
  String timeBlockEndAlarmTitle(String title, String time) {
    return '$title - 结束前$time';
  }

  @override
  String get timeBlockEndAlarmBody => '该收尾了。';

  @override
  String get focusSessionCompleteTitle => '专注时间完成！';

  @override
  String get focusSessionCompleteBody => '辛苦了，休息一下吧。';

  @override
  String get statDescProductivityScoreTitle => '生产力评分';

  @override
  String get statDescProductivityScoreBody => '综合完成率、时间准确度和时间块执行率的0-100分评分。';

  @override
  String get statDescCompletionRingsTitle => '完成率环';

  @override
  String get statDescCompletionRingsBody => '显示任务完成率、时间块执行率和时间准确度。';

  @override
  String get statDescTaskPipelineTitle => '任务流程';

  @override
  String get statDescTaskPipelineBody => '显示总数→已安排→已完成→已顺延的流程。';

  @override
  String get statDescTop3StatsTitle => 'Top 3 达成';

  @override
  String get statDescTop3StatsBody => '显示最重要的3个任务的达成情况。';

  @override
  String get statDescTaskRankingTitle => '任务排名';

  @override
  String get statDescTaskRankingBody => '按完成成功/失败排列重复任务。';

  @override
  String get statDescFocusSummaryTitle => '专注分析';

  @override
  String get statDescFocusSummaryBody => '专注模式效率、时间、会话数和暂停时长。';

  @override
  String get statDescTrendChartTitle => '生产力趋势';

  @override
  String get statDescTrendChartBody => '以折线图展示每日生产力评分变化。';

  @override
  String get statDescTagAnalysisTitle => '标签分析';

  @override
  String get statDescTagAnalysisBody => '按标签显示任务数量和计划时间。';

  @override
  String get statDescInsightsTitle => '洞察';

  @override
  String get statDescInsightsBody => '基于数据自动生成的绩效分析。';

  @override
  String get statDescPriorityBreakdownBody => '按优先级（高/中/低）显示任务完成率。';

  @override
  String insightPeriodRolloverTitle(String count) {
    return '$count个顺延任务';
  }

  @override
  String get insightPeriodRolloverDesc => '减少顺延任务可以提高生产力';

  @override
  String insightPeriodFocusTitle(String minutes) {
    return '专注时间 $minutes分钟';
  }

  @override
  String get insightPeriodFocusHighDesc => '本期专注时间充足';

  @override
  String get insightPeriodFocusLowDesc => '尝试更多地使用专注模式';

  @override
  String insightPeriodTop3Title(String rate, String completed, String total) {
    return 'Top 3 完成率 $rate%';
  }

  @override
  String get insightPeriodTop3HighDesc => '重要任务完成得很好';

  @override
  String get insightPeriodTop3LowDesc => '请更关注Top 3任务';
}
