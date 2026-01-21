import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/focus_session.dart';
import '../../domain/entities/session_status.dart';

part 'focus_event.dart';
part 'focus_state.dart';

/// Focus BLoC
///
/// 포커스 모드 상태 관리 (타이머 포함)
class FocusBloc extends Bloc<FocusEvent, FocusState> {
  Timer? _timer;

  FocusBloc() : super(const FocusState()) {
    on<StartFocusSession>(_onStartSession);
    on<PauseFocusSession>(_onPauseSession);
    on<ResumeFocusSession>(_onResumeSession);
    on<CompleteFocusSession>(_onCompleteSession);
    on<SkipFocusSession>(_onSkipSession);
    on<TimerTick>(_onTimerTick);
    on<LoadFocusSession>(_onLoadSession);
  }

  void _onStartSession(
    StartFocusSession event,
    Emitter<FocusState> emit,
  ) {
    final session = FocusSession(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      timeBlockId: event.timeBlockId,
      taskId: event.taskId,
      status: SessionStatus.inProgress,
      plannedStartTime: DateTime.now(),
      plannedEndTime: DateTime.now().add(event.duration),
      actualStartTime: DateTime.now(),
      createdAt: DateTime.now(),
    );

    emit(state.copyWith(
      status: FocusStateStatus.running,
      currentSession: session,
      remainingSeconds: event.duration.inSeconds,
    ));

    _startTimer();
  }

  void _onPauseSession(
    PauseFocusSession event,
    Emitter<FocusState> emit,
  ) {
    _timer?.cancel();
    emit(state.copyWith(status: FocusStateStatus.paused));
  }

  void _onResumeSession(
    ResumeFocusSession event,
    Emitter<FocusState> emit,
  ) {
    emit(state.copyWith(status: FocusStateStatus.running));
    _startTimer();
  }

  void _onCompleteSession(
    CompleteFocusSession event,
    Emitter<FocusState> emit,
  ) {
    _timer?.cancel();
    emit(state.copyWith(
      status: FocusStateStatus.completed,
      remainingSeconds: 0,
    ));
  }

  void _onSkipSession(
    SkipFocusSession event,
    Emitter<FocusState> emit,
  ) {
    _timer?.cancel();
    emit(const FocusState());
  }

  void _onTimerTick(
    TimerTick event,
    Emitter<FocusState> emit,
  ) {
    final newRemainingSeconds = state.remainingSeconds - 1;

    if (newRemainingSeconds <= 0) {
      _timer?.cancel();
      emit(state.copyWith(
        status: FocusStateStatus.completed,
        remainingSeconds: 0,
      ));
    } else {
      emit(state.copyWith(remainingSeconds: newRemainingSeconds));
    }
  }

  void _onLoadSession(
    LoadFocusSession event,
    Emitter<FocusState> emit,
  ) {
    // TODO: Load session from repository
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!isClosed) {
        add(const TimerTick());
      }
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
