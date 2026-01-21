part of 'planner_bloc.dart';

/// Planner BLoC 이벤트
sealed class PlannerEvent {
  const PlannerEvent();
}

/// Planner 초기화 (Task 및 DailyPriority 구독 시작)
class InitializePlanner extends PlannerEvent {
  final DateTime date;
  const InitializePlanner(this.date);
}

/// 날짜 변경
class PlannerDateChanged extends PlannerEvent {
  final DateTime date;
  const PlannerDateChanged(this.date);
}

/// 오늘로 이동
class PlannerGoToToday extends PlannerEvent {
  const PlannerGoToToday();
}

/// Task 목록 업데이트 (내부용)
class PlannerTasksUpdated extends PlannerEvent {
  final List<Task> tasks;
  const PlannerTasksUpdated(this.tasks);
}

/// DailyPriority 업데이트 (내부용)
class PlannerDailyPriorityUpdated extends PlannerEvent {
  final DailyPriority? dailyPriority;
  const PlannerDailyPriorityUpdated(this.dailyPriority);
}

/// TimeBlocks 업데이트 (내부용)
class PlannerTimeBlocksUpdated extends PlannerEvent {
  final List<TimeBlock> timeBlocks;
  const PlannerTimeBlocksUpdated(this.timeBlocks);
}

/// Task를 Top 3 슬롯에 배치
class SetTopThreeTask extends PlannerEvent {
  final int rank; // 1, 2, 3
  final String taskId;

  const SetTopThreeTask({
    required this.rank,
    required this.taskId,
  });
}

/// Top 3 슬롯에서 Task 제거
class RemoveTopThreeTask extends PlannerEvent {
  final int rank; // 1, 2, 3

  const RemoveTopThreeTask(this.rank);
}

/// 페이지 인덱스 변경 (브레인덤프 ↔ 타임라인)
class PageIndexChanged extends PlannerEvent {
  final int index; // 0: 브레인덤프, 1: 타임라인

  const PageIndexChanged(this.index);
}

/// Task를 타임라인에 드롭하여 TimeBlock 생성
class CreateTimeBlockFromTask extends PlannerEvent {
  final Task task;
  final DateTime startTime;

  const CreateTimeBlockFromTask({
    required this.task,
    required this.startTime,
  });
}

/// Quick Task 생성 (브레인 덤프)
class QuickCreateTask extends PlannerEvent {
  final String title;
  final Duration estimatedDuration;
  final TaskPriority priority;

  const QuickCreateTask({
    required this.title,
    this.estimatedDuration = const Duration(minutes: 30),
    this.priority = TaskPriority.medium,
  });
}
