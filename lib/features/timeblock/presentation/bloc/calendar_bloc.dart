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
  }

  Future<void> _onWatchTimeBlocksStarted(
    WatchTimeBlocksStarted event,
    Emitter<CalendarState> emit,
  ) async {
    emit(state.copyWith(status: CalendarStateStatus.loading));

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
      (_) => {}, // watchTimeBlocksForDay가 자동으로 업데이트
    );
  }

  Future<void> _onMoveTimeBlock(
    MoveTimeBlockEvent event,
    Emitter<CalendarState> emit,
  ) async {
    final result = await moveTimeBlock(
      MoveTimeBlockParams(id: event.id, newStartTime: event.newStartTime),
    );

    result.fold(
      (failure) => emit(state.copyWith(
        status: CalendarStateStatus.failure,
        errorMessage: failure.message,
      )),
      (_) => {},
    );
  }

  Future<void> _onResizeTimeBlock(
    ResizeTimeBlockEvent event,
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

  Future<void> _onDeleteTimeBlock(
    DeleteTimeBlockEvent event,
    Emitter<CalendarState> emit,
  ) async {
    final result = await deleteTimeBlock(event.id);
    result.fold(
      (failure) => emit(state.copyWith(
        status: CalendarStateStatus.failure,
        errorMessage: failure.message,
      )),
      (_) => {},
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
      (_) => {},
    );
  }

  @override
  Future<void> close() {
    _timeBlocksSubscription?.cancel();
    return super.close();
  }
}
