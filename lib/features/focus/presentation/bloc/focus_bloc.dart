import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/services/stats_update_service.dart';
import '../../../analytics/data/datasources/analytics_local_datasource.dart';
import '../../data/datasources/focus_session_local_datasource.dart';
import '../../data/models/focus_session_model.dart';
import '../../domain/entities/focus_session.dart';
import '../../domain/entities/session_status.dart';

part 'focus_event.dart';
part 'focus_state.dart';

/// Focus BLoC
///
/// 포커스 모드 상태 관리 (타이머 포함)
class FocusBloc extends Bloc<FocusEvent, FocusState> {
  Timer? _timer;
  final FocusSessionLocalDataSource? sessionDataSource;
  final AnalyticsLocalDataSource? analyticsDataSource;
  final StatsUpdateService? statsUpdateService;
  static const _uuid = Uuid();

  FocusBloc({
    this.sessionDataSource,
    this.analyticsDataSource,
    this.statsUpdateService,
  }) : super(const FocusState()) {
    on<StartFocusSession>(_onStartSession);
    on<StartTimeBlockFocusSession>(_onStartTimeBlockSession);
    on<PauseFocusSession>(_onPauseSession);
    on<ResumeFocusSession>(_onResumeSession);
    on<CompleteFocusSession>(_onCompleteSession);
    on<SkipFocusSession>(_onSkipSession);
    on<TimerTick>(_onTimerTick);
    on<LoadFocusSession>(_onLoadSession);
    on<RequestEndFocusSession>(_onRequestEndSession);
    on<EndFocusSessionAfterChallenge>(_onEndSessionAfterChallenge);
  }

  void _onStartSession(
    StartFocusSession event,
    Emitter<FocusState> emit,
  ) {
    final session = FocusSession(
      id: _uuid.v4(),
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

  /// 타임블록 기반 집중 세션 시작
  Future<void> _onStartTimeBlockSession(
    StartTimeBlockFocusSession event,
    Emitter<FocusState> emit,
  ) async {
    final now = DateTime.now();
    final remainingSeconds = event.endTime.difference(now).inSeconds;

    if (remainingSeconds <= 0) {
      emit(state.copyWith(
        errorMessage: 'timeBlockAlreadyEnded',
      ));
      return;
    }

    final session = FocusSession(
      id: _uuid.v4(),
      timeBlockId: event.timeBlockId,
      taskId: event.taskId,
      status: SessionStatus.inProgress,
      plannedStartTime: now,
      plannedEndTime: event.endTime,
      actualStartTime: now,
      createdAt: now,
    );

    // 세션 저장
    await _saveSession(session);

    emit(state.copyWith(
      status: FocusStateStatus.running,
      currentSession: session,
      remainingSeconds: remainingSeconds,
      taskTitle: event.taskTitle,
      clearError: true,
    ));

    _startTimer();
  }

  /// 세션 종료 요청 (수학 문제 다이얼로그 표시)
  void _onRequestEndSession(
    RequestEndFocusSession event,
    Emitter<FocusState> emit,
  ) {
    emit(state.copyWith(showMathChallenge: true));
  }

  /// 수학 문제 해제 후 세션 종료
  Future<void> _onEndSessionAfterChallenge(
    EndFocusSessionAfterChallenge event,
    Emitter<FocusState> emit,
  ) async {
    _timer?.cancel();

    // 세션 완료 처리
    if (state.currentSession != null) {
      final completedSession = state.currentSession!.copyWith(
        status: SessionStatus.completed,
        actualEndTime: DateTime.now(),
      );
      await _saveSession(completedSession);
    }

    emit(state.copyWith(
      status: FocusStateStatus.completed,
      remainingSeconds: 0,
      showMathChallenge: false,
    ));
  }

  /// 세션 저장
  Future<void> _saveSession(FocusSession session) async {
    if (sessionDataSource != null) {
      try {
        await sessionDataSource!.saveSession(
          FocusSessionModel.fromEntity(session),
        );

        // 세션 완료 시 Write-through 통계 재계산
        if (session.status == SessionStatus.completed) {
          final date = DateTime(
            session.plannedStartTime.year,
            session.plannedStartTime.month,
            session.plannedStartTime.day,
          );
          statsUpdateService?.onDataChanged(date);
          debugPrint('[FocusBloc] Write-through stats update triggered for: $date');
        }
      } catch (e) {
        // 저장 실패 시 로그만 남김
        debugPrint('[FocusBloc] Failed to save session: $e');
      }
    }
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
