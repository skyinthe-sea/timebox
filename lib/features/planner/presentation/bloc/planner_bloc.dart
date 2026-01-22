import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../task/domain/entities/task.dart';
import '../../../task/domain/usecases/copy_task_to_date.dart';
import '../../../task/domain/usecases/create_task.dart';
import '../../../task/domain/usecases/rollover_task.dart';
import '../../../task/domain/usecases/watch_tasks_by_date.dart';
import '../../../timeblock/domain/entities/time_block.dart';
import '../../../timeblock/domain/usecases/create_time_block.dart';
import '../../../timeblock/domain/usecases/get_time_blocks_for_day.dart';
import '../../domain/entities/daily_priority.dart';
import '../../domain/usecases/remove_task_from_rank.dart';
import '../../domain/usecases/set_task_rank.dart';
import '../../domain/usecases/watch_daily_priority.dart';

part 'planner_event.dart';
part 'planner_state.dart';

/// Planner BLoC
///
/// 통합 플래너 페이지 상태 관리
/// - Top 3 우선순위
/// - 브레인덤프 Task 목록
/// - 타임라인 TimeBlock 목록
class PlannerBloc extends Bloc<PlannerEvent, PlannerState> {
  final WatchTasksByDate watchTasksByDate;
  final WatchDailyPriority watchDailyPriority;
  final WatchTimeBlocksForDay watchTimeBlocksForDay;
  final SetTaskRank setTaskRank;
  final RemoveTaskFromRank removeTaskFromRank;
  final CreateTask createTask;
  final CreateTimeBlock createTimeBlock;
  final CopyTaskToDate copyTaskToDate;
  final RolloverTask rolloverTask;

  StreamSubscription? _tasksSubscription;
  StreamSubscription? _dailyPrioritySubscription;
  StreamSubscription? _timeBlocksSubscription;

  final _uuid = const Uuid();

  PlannerBloc({
    required this.watchTasksByDate,
    required this.watchDailyPriority,
    required this.watchTimeBlocksForDay,
    required this.setTaskRank,
    required this.removeTaskFromRank,
    required this.createTask,
    required this.createTimeBlock,
    required this.copyTaskToDate,
    required this.rolloverTask,
  }) : super(PlannerState()) {
    on<InitializePlanner>(_onInitializePlanner);
    on<PlannerDateChanged>(_onDateChanged);
    on<PlannerGoToToday>(_onGoToToday);
    on<PlannerTasksUpdated>(_onTasksUpdated);
    on<PlannerDailyPriorityUpdated>(_onDailyPriorityUpdated);
    on<PlannerTimeBlocksUpdated>(_onTimeBlocksUpdated);
    on<SetTopThreeTask>(_onSetTopThreeTask);
    on<RemoveTopThreeTask>(_onRemoveTopThreeTask);
    on<PageIndexChanged>(_onPageIndexChanged);
    on<CreateTimeBlockFromTask>(_onCreateTimeBlockFromTask);
    on<QuickCreateTask>(_onQuickCreateTask);
    on<CopyTaskToTomorrow>(_onCopyTaskToTomorrow);
    on<RolloverTaskEvent>(_onRolloverTask);
  }

  Future<void> _onInitializePlanner(
    InitializePlanner event,
    Emitter<PlannerState> emit,
  ) async {
    emit(state.copyWith(
      status: PlannerStateStatus.loading,
      selectedDate: event.date,
    ));

    // 날짜별 Tasks 구독
    await _tasksSubscription?.cancel();
    _tasksSubscription = watchTasksByDate(event.date).listen(
      (result) {
        result.fold(
          (failure) => add(const PlannerTasksUpdated([])),
          (tasks) => add(PlannerTasksUpdated(tasks)),
        );
      },
    );

    // DailyPriority 구독
    await _dailyPrioritySubscription?.cancel();
    _dailyPrioritySubscription = watchDailyPriority(event.date).listen(
      (result) {
        result.fold(
          (failure) => add(const PlannerDailyPriorityUpdated(null)),
          (dailyPriority) => add(PlannerDailyPriorityUpdated(dailyPriority)),
        );
      },
    );

    // TimeBlocks 구독
    await _timeBlocksSubscription?.cancel();
    _timeBlocksSubscription = watchTimeBlocksForDay(event.date).listen(
      (result) {
        result.fold(
          (failure) => add(const PlannerTimeBlocksUpdated([])),
          (timeBlocks) => add(PlannerTimeBlocksUpdated(timeBlocks)),
        );
      },
    );
  }

  Future<void> _onDateChanged(
    PlannerDateChanged event,
    Emitter<PlannerState> emit,
  ) async {
    add(InitializePlanner(event.date));
  }

  Future<void> _onGoToToday(
    PlannerGoToToday event,
    Emitter<PlannerState> emit,
  ) async {
    add(PlannerDateChanged(DateTime.now()));
  }

  void _onTasksUpdated(
    PlannerTasksUpdated event,
    Emitter<PlannerState> emit,
  ) {
    emit(state.copyWith(
      status: PlannerStateStatus.success,
      tasks: event.tasks,
      clearError: true,
    ));
  }

  void _onDailyPriorityUpdated(
    PlannerDailyPriorityUpdated event,
    Emitter<PlannerState> emit,
  ) {
    emit(state.copyWith(
      status: PlannerStateStatus.success,
      dailyPriority: event.dailyPriority,
      clearDailyPriority: event.dailyPriority == null,
      clearError: true,
    ));
  }

  void _onTimeBlocksUpdated(
    PlannerTimeBlocksUpdated event,
    Emitter<PlannerState> emit,
  ) {
    emit(state.copyWith(
      status: PlannerStateStatus.success,
      timeBlocks: event.timeBlocks,
      clearError: true,
    ));
  }

  Future<void> _onSetTopThreeTask(
    SetTopThreeTask event,
    Emitter<PlannerState> emit,
  ) async {
    final result = await setTaskRank(SetTaskRankParams(
      date: state.selectedDate,
      rank: event.rank,
      taskId: event.taskId,
    ));

    result.fold(
      (failure) => emit(state.copyWith(
        status: PlannerStateStatus.failure,
        errorMessage: failure.message,
      )),
      (_) => {}, // watchDailyPriority가 자동으로 업데이트
    );
  }

  Future<void> _onRemoveTopThreeTask(
    RemoveTopThreeTask event,
    Emitter<PlannerState> emit,
  ) async {
    final result = await removeTaskFromRank(RemoveTaskFromRankParams(
      date: state.selectedDate,
      rank: event.rank,
    ));

    result.fold(
      (failure) => emit(state.copyWith(
        status: PlannerStateStatus.failure,
        errorMessage: failure.message,
      )),
      (_) => {},
    );
  }

  void _onPageIndexChanged(
    PageIndexChanged event,
    Emitter<PlannerState> emit,
  ) {
    emit(state.copyWith(pageIndex: event.index));
  }

  Future<void> _onCreateTimeBlockFromTask(
    CreateTimeBlockFromTask event,
    Emitter<PlannerState> emit,
  ) async {
    // Task의 예상 소요 시간을 기반으로 TimeBlock 생성
    final endTime = event.startTime.add(event.task.estimatedDuration);

    // Task 순위에 따른 색상 설정
    int? colorValue;
    final rank = state.getTaskRank(event.task.id);
    if (rank != null) {
      switch (rank) {
        case 1:
          colorValue = 0xFFEF4444; // 빨강
        case 2:
          colorValue = 0xFFF59E0B; // 주황
        case 3:
          colorValue = 0xFF3B82F6; // 파랑
      }
    }

    final timeBlock = TimeBlock(
      id: _uuid.v4(),
      taskId: event.task.id,
      title: event.task.title,
      startTime: event.startTime,
      endTime: endTime,
      colorValue: colorValue,
      status: TimeBlockStatus.pending,
    );

    final result = await createTimeBlock(timeBlock);
    result.fold(
      (failure) => emit(state.copyWith(
        status: PlannerStateStatus.failure,
        errorMessage: failure.message,
      )),
      (_) => {},
    );
  }

  Future<void> _onQuickCreateTask(
    QuickCreateTask event,
    Emitter<PlannerState> emit,
  ) async {
    final task = Task(
      id: _uuid.v4(),
      title: event.title,
      estimatedDuration: event.estimatedDuration,
      priority: event.priority,
      status: TaskStatus.todo,
      createdAt: DateTime.now(),
      targetDate: state.selectedDate,
    );

    final result = await createTask(task);
    result.fold(
      (failure) => emit(state.copyWith(
        status: PlannerStateStatus.failure,
        errorMessage: failure.message,
      )),
      (_) => {},
    );
  }

  Future<void> _onCopyTaskToTomorrow(
    CopyTaskToTomorrow event,
    Emitter<PlannerState> emit,
  ) async {
    final tomorrow = state.selectedDate.add(const Duration(days: 1));
    final result = await copyTaskToDate(CopyTaskToDateParams(
      taskId: event.taskId,
      targetDate: tomorrow,
    ));

    result.fold(
      (failure) => emit(state.copyWith(
        status: PlannerStateStatus.failure,
        errorMessage: failure.message,
      )),
      (_) => {},
    );
  }

  Future<void> _onRolloverTask(
    RolloverTaskEvent event,
    Emitter<PlannerState> emit,
  ) async {
    final tomorrow = state.selectedDate.add(const Duration(days: 1));
    final result = await rolloverTask(RolloverTaskParams(
      taskId: event.taskId,
      toDate: tomorrow,
    ));

    result.fold(
      (failure) => emit(state.copyWith(
        status: PlannerStateStatus.failure,
        errorMessage: failure.message,
      )),
      (_) => {},
    );
  }

  @override
  Future<void> close() {
    _tasksSubscription?.cancel();
    _dailyPrioritySubscription?.cancel();
    _timeBlocksSubscription?.cancel();
    return super.close();
  }
}
