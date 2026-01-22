part of 'planner_bloc.dart';

/// Planner BLoC 상태
enum PlannerStateStatus { initial, loading, success, failure }

class PlannerState extends Equatable {
  final PlannerStateStatus status;
  final DateTime selectedDate;
  final List<Task> tasks;
  final DailyPriority? dailyPriority;
  final List<TimeBlock> timeBlocks;
  final int pageIndex; // 0: 브레인덤프, 1: 타임라인
  final String? errorMessage;

  PlannerState({
    this.status = PlannerStateStatus.initial,
    DateTime? selectedDate,
    this.tasks = const [],
    this.dailyPriority,
    this.timeBlocks = const [],
    this.pageIndex = 0,
    this.errorMessage,
  }) : selectedDate = selectedDate ?? DateTime.now();

  /// 브레인덤프에 표시할 Task 목록 (미완료 + 타임블록 미배정)
  List<Task> get unscheduledTasks {
    final scheduledTaskIds = timeBlocks
        .where((tb) => tb.taskId != null)
        .map((tb) => tb.taskId!)
        .toSet();

    return tasks
        .where((t) =>
            t.status == TaskStatus.todo && !scheduledTaskIds.contains(t.id))
        .toList();
  }

  /// Top 3 Task 목록 (순위별)
  List<Task?> get topThreeTasks {
    if (dailyPriority == null) return [null, null, null];

    Task? findTask(String? taskId) {
      if (taskId == null) return null;
      try {
        return tasks.firstWhere((t) => t.id == taskId);
      } catch (_) {
        return null;
      }
    }

    return [
      findTask(dailyPriority!.rank1TaskId),
      findTask(dailyPriority!.rank2TaskId),
      findTask(dailyPriority!.rank3TaskId),
    ];
  }

  /// 1순위 Task
  Task? get rank1Task => topThreeTasks[0];

  /// 2순위 Task
  Task? get rank2Task => topThreeTasks[1];

  /// 3순위 Task
  Task? get rank3Task => topThreeTasks[2];

  /// Task의 Top 3 순위 반환 (없으면 null)
  int? getTaskRank(String taskId) {
    return dailyPriority?.getRankForTask(taskId);
  }

  /// Task가 Top 3에 포함되어 있는지 확인
  bool isTopThreeTask(String taskId) {
    return dailyPriority?.containsTask(taskId) ?? false;
  }

  /// 브레인덤프 페이지인지
  bool get isBrainDumpPage => pageIndex == 0;

  /// 타임라인 페이지인지
  bool get isTimelinePage => pageIndex == 1;

  /// 오늘 날짜인지
  bool get isToday {
    final now = DateTime.now();
    return selectedDate.year == now.year &&
        selectedDate.month == now.month &&
        selectedDate.day == now.day;
  }

  /// 오늘의 Task 완료율 (0.0 ~ 1.0)
  double get completionRate {
    if (tasks.isEmpty) return 0.0;
    final completed = tasks.where((t) => t.status == TaskStatus.done).length;
    return completed / tasks.length;
  }

  /// 이월된 Task 목록
  List<Task> get rolloverTasks => tasks.where((t) => t.rolloverCount > 0).toList();

  PlannerState copyWith({
    PlannerStateStatus? status,
    DateTime? selectedDate,
    List<Task>? tasks,
    DailyPriority? dailyPriority,
    List<TimeBlock>? timeBlocks,
    int? pageIndex,
    String? errorMessage,
    bool clearError = false,
    bool clearDailyPriority = false,
  }) {
    return PlannerState(
      status: status ?? this.status,
      selectedDate: selectedDate ?? this.selectedDate,
      tasks: tasks ?? this.tasks,
      dailyPriority:
          clearDailyPriority ? null : (dailyPriority ?? this.dailyPriority),
      timeBlocks: timeBlocks ?? this.timeBlocks,
      pageIndex: pageIndex ?? this.pageIndex,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [
        status,
        selectedDate,
        tasks,
        dailyPriority,
        timeBlocks,
        pageIndex,
        errorMessage,
      ];
}
