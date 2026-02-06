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
  final String? taskId;
  final String title;
  final Duration estimatedDuration;
  final TaskPriority priority;
  final List<Tag> tags;

  const QuickCreateTask({
    this.taskId,
    required this.title,
    this.estimatedDuration = const Duration(minutes: 30),
    this.priority = TaskPriority.medium,
    this.tags = const [],
  });
}

/// Task를 내일로 복제 (내일도 하기)
class CopyTaskToTomorrow extends PlannerEvent {
  final String taskId;

  const CopyTaskToTomorrow(this.taskId);
}

/// Task 이월 (다음 날로)
class RolloverTaskEvent extends PlannerEvent {
  final String taskId;

  const RolloverTaskEvent(this.taskId);
}

/// Task 삭제 (브레인 덤프)
class DeleteBrainDumpTask extends PlannerEvent {
  final String taskId;

  const DeleteBrainDumpTask(this.taskId);
}

/// 마지막 생성 Task ID 클리어 (애니메이션 완료 후)
class ClearLastCreatedTask extends PlannerEvent {
  const ClearLastCreatedTask();
}

/// Task 자동완성 제안 요청
class RequestTaskSuggestions extends PlannerEvent {
  final String query;
  const RequestTaskSuggestions(this.query);
}

/// Task 자동완성 제안 클리어
class ClearTaskSuggestions extends PlannerEvent {
  const ClearTaskSuggestions();
}

/// Task 태그 업데이트
class UpdateTaskTags extends PlannerEvent {
  final String taskId;
  final List<Tag> tags;

  const UpdateTaskTags({
    required this.taskId,
    required this.tags,
  });
}
