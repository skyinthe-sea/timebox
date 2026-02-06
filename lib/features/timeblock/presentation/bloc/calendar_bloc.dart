import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entities/time_block.dart';
import '../../domain/usecases/create_time_block.dart';
import '../../domain/usecases/delete_time_block.dart';
import '../../domain/usecases/get_time_blocks_for_day.dart';
import '../../domain/usecases/move_time_block.dart';
import '../../domain/usecases/update_time_block.dart';
import '../../../notification/domain/repositories/notification_repository.dart';

part 'calendar_event.dart';
part 'calendar_state.dart';

/// Calendar BLoC
///
/// 타임박싱 캘린더 화면 상태 관리
class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  final WatchTimeBlocksForDay watchTimeBlocksForDay;
  final CreateTimeBlock createTimeBlock;
  final UpdateTimeBlock updateTimeBlock;
  final UpdateTimeBlockStatus updateTimeBlockStatus;
  final DeleteTimeBlock deleteTimeBlock;
  final MoveTimeBlock moveTimeBlock;
  final ResizeTimeBlock resizeTimeBlock;
  final NotificationRepository? notificationRepository;

  StreamSubscription? _timeBlocksSubscription;
  final _uuid = const Uuid();

  CalendarBloc({
    required this.watchTimeBlocksForDay,
    required this.createTimeBlock,
    required this.updateTimeBlock,
    required this.updateTimeBlockStatus,
    required this.deleteTimeBlock,
    required this.moveTimeBlock,
    required this.resizeTimeBlock,
    this.notificationRepository,
  }) : super(CalendarState()) {
    on<WatchTimeBlocksStarted>(_onWatchTimeBlocksStarted);
    on<TimeBlocksUpdated>(_onTimeBlocksUpdated);
    on<LoadTimeBlocks>(_onLoadTimeBlocks);
    on<DateChanged>(_onDateChanged);
    on<GoToToday>(_onGoToToday);
    on<CreateTimeBlockEvent>(_onCreateTimeBlock);
    on<MoveTimeBlockEvent>(_onMoveTimeBlock);
    on<ResizeTimeBlockEvent>(_onResizeTimeBlock);
    on<DeleteTimeBlockEvent>(_onDeleteTimeBlock);
    on<UpdateTimeBlockStatusEvent>(_onUpdateTimeBlockStatus);
    on<MergeTimeBlocksEvent>(_onMergeTimeBlocks);
    on<ExtendTimeBlockEvent>(_onExtendTimeBlock);
    on<MarkExpiredAsSkippedEvent>(_onMarkExpiredAsSkipped);
  }

  Future<void> _onWatchTimeBlocksStarted(
    WatchTimeBlocksStarted event,
    Emitter<CalendarState> emit,
  ) async {
    emit(state.copyWith(
      status: CalendarStateStatus.loading,
      selectedDate: event.date,
    ));

    await _timeBlocksSubscription?.cancel();
    _timeBlocksSubscription = watchTimeBlocksForDay(event.date).listen(
      (result) {
        result.fold(
          (failure) => add(const TimeBlocksUpdated([])),
          (timeBlocks) => add(TimeBlocksUpdated(timeBlocks)),
        );
      },
    );
  }

  void _onTimeBlocksUpdated(
    TimeBlocksUpdated event,
    Emitter<CalendarState> emit,
  ) {
    emit(state.copyWith(
      status: CalendarStateStatus.success,
      timeBlocks: event.timeBlocks,
      clearError: true,
    ));
  }

  Future<void> _onLoadTimeBlocks(
    LoadTimeBlocks event,
    Emitter<CalendarState> emit,
  ) async {
    add(WatchTimeBlocksStarted(event.date));
  }

  Future<void> _onDateChanged(
    DateChanged event,
    Emitter<CalendarState> emit,
  ) async {
    emit(state.copyWith(
      selectedDate: event.date,
      status: CalendarStateStatus.loading,
    ));
    add(WatchTimeBlocksStarted(event.date));
  }

  Future<void> _onGoToToday(
    GoToToday event,
    Emitter<CalendarState> emit,
  ) async {
    add(DateChanged(DateTime.now()));
  }

  Future<void> _onCreateTimeBlock(
    CreateTimeBlockEvent event,
    Emitter<CalendarState> emit,
  ) async {
    final timeBlock = TimeBlock(
      id: _uuid.v4(),
      taskId: event.taskId,
      title: event.title,
      startTime: event.startTime,
      endTime: event.endTime,
      colorValue: event.colorValue,
      status: TimeBlockStatus.pending,
    );

    final result = await createTimeBlock(timeBlock);
    result.fold(
      (failure) => emit(state.copyWith(
        status: CalendarStateStatus.failure,
        errorMessage: failure.message,
      )),
      (_) {
        // 알림 예약 (현재 시간과 겹치지 않는 경우만)
        notificationRepository?.scheduleTimeBlockAlarms(
          timeBlock,
          taskTitle: event.title,
        );
      },
    );
  }

  Future<void> _onMoveTimeBlock(
    MoveTimeBlockEvent event,
    Emitter<CalendarState> emit,
  ) async {
    // 기존 알림 취소
    await notificationRepository?.cancelTimeBlockAlarms(event.id);

    final result = await moveTimeBlock(
      MoveTimeBlockParams(id: event.id, newStartTime: event.newStartTime),
    );

    result.fold(
      (failure) => emit(state.copyWith(
        status: CalendarStateStatus.failure,
        errorMessage: failure.message,
      )),
      (movedTimeBlock) {
        // 새 알림 예약
        notificationRepository?.scheduleTimeBlockAlarms(movedTimeBlock);
      },
    );
  }

  Future<void> _onResizeTimeBlock(
    ResizeTimeBlockEvent event,
    Emitter<CalendarState> emit,
  ) async {
    // 기존 알림 취소
    await notificationRepository?.cancelTimeBlockAlarms(event.id);

    final result = await resizeTimeBlock(
      ResizeTimeBlockParams(
        id: event.id,
        newStartTime: event.newStartTime,
        newEndTime: event.newEndTime,
      ),
    );

    result.fold(
      (failure) => emit(state.copyWith(
        status: CalendarStateStatus.failure,
        errorMessage: failure.message,
      )),
      (resizedTimeBlock) {
        // 새 알림 예약
        notificationRepository?.scheduleTimeBlockAlarms(resizedTimeBlock);
      },
    );
  }

  Future<void> _onDeleteTimeBlock(
    DeleteTimeBlockEvent event,
    Emitter<CalendarState> emit,
  ) async {
    // 알림 먼저 취소
    await notificationRepository?.cancelTimeBlockAlarms(event.id);

    final result = await deleteTimeBlock(event.id);
    result.fold(
      (failure) => emit(state.copyWith(
        status: CalendarStateStatus.failure,
        errorMessage: failure.message,
      )),
      (_) {},
    );
  }

  Future<void> _onUpdateTimeBlockStatus(
    UpdateTimeBlockStatusEvent event,
    Emitter<CalendarState> emit,
  ) async {
    final result = await updateTimeBlockStatus(
      UpdateTimeBlockStatusParams(id: event.id, status: event.status),
    );

    result.fold(
      (failure) => emit(state.copyWith(
        status: CalendarStateStatus.failure,
        errorMessage: failure.message,
      )),
      (_) {},
    );
  }

  Future<void> _onMergeTimeBlocks(
    MergeTimeBlocksEvent event,
    Emitter<CalendarState> emit,
  ) async {
    // 같은 taskId를 가진 인접 블록 찾기
    final adjacentBlocks = state.timeBlocks.where((tb) {
      if (tb.taskId != event.taskId) return false;
      // 인접 여부 확인 (시간이 맞닿아 있는지)
      return tb.endTime == event.startTime || tb.startTime == event.endTime;
    }).toList();

    if (adjacentBlocks.isEmpty) {
      // 인접 블록이 없으면 새 블록 생성
      add(CreateTimeBlockEvent(
        taskId: event.taskId,
        startTime: event.startTime,
        endTime: event.endTime,
      ));
      return;
    }

    // 인접 블록과 병합
    final blockToExtend = adjacentBlocks.first;
    final newStartTime = blockToExtend.startTime.isBefore(event.startTime)
        ? blockToExtend.startTime
        : event.startTime;
    final newEndTime = blockToExtend.endTime.isAfter(event.endTime)
        ? blockToExtend.endTime
        : event.endTime;

    // 기존 블록 확장
    final result = await resizeTimeBlock(
      ResizeTimeBlockParams(
        id: blockToExtend.id,
        newStartTime: newStartTime,
        newEndTime: newEndTime,
      ),
    );

    result.fold(
      (failure) => emit(state.copyWith(
        status: CalendarStateStatus.failure,
        errorMessage: failure.message,
      )),
      (_) => {},
    );
  }

  Future<void> _onExtendTimeBlock(
    ExtendTimeBlockEvent event,
    Emitter<CalendarState> emit,
  ) async {
    final result = await resizeTimeBlock(
      ResizeTimeBlockParams(
        id: event.id,
        newStartTime: event.newStartTime,
        newEndTime: event.newEndTime,
      ),
    );

    result.fold(
      (failure) => emit(state.copyWith(
        status: CalendarStateStatus.failure,
        errorMessage: failure.message,
      )),
      (_) => {},
    );
  }

  Future<void> _onMarkExpiredAsSkipped(
    MarkExpiredAsSkippedEvent event,
    Emitter<CalendarState> emit,
  ) async {
    final now = DateTime.now();
    final expiredBlocks = state.timeBlocks.where((tb) =>
        tb.endTime.isBefore(now) &&
        tb.status == TimeBlockStatus.pending);

    if (expiredBlocks.isEmpty) return;

    final skippedIds = <String>[];

    for (final block in expiredBlocks) {
      final result = await updateTimeBlockStatus(
        UpdateTimeBlockStatusParams(id: block.id, status: TimeBlockStatus.skipped),
      );
      result.fold(
        (failure) {},
        (_) => skippedIds.add(block.id),
      );
    }

    if (skippedIds.isNotEmpty) {
      emit(state.copyWith(recentlySkippedIds: skippedIds));

      // 애니메이션 후 ID 목록 클리어 (1초 후)
      await Future.delayed(const Duration(milliseconds: 1000));
      if (isClosed) return;
      emit(state.copyWith(clearRecentlySkipped: true));
    }
  }

  @override
  Future<void> close() {
    _timeBlocksSubscription?.cancel();
    return super.close();
  }
}
