part of 'focus_bloc.dart';

/// Focus 상태
enum FocusStateStatus { idle, running, paused, completed }

class FocusState extends Equatable {
  final FocusStateStatus status;
  final FocusSession? currentSession;
  final int remainingSeconds;
  final String? errorMessage;

  const FocusState({
    this.status = FocusStateStatus.idle,
    this.currentSession,
    this.remainingSeconds = 0,
    this.errorMessage,
  });

  /// 포맷된 남은 시간 (MM:SS)
  String get formattedRemainingTime {
    final minutes = remainingSeconds ~/ 60;
    final seconds = remainingSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  /// 진행률 (0.0 ~ 1.0)
  double get progress {
    if (currentSession == null) return 0.0;
    final totalSeconds = currentSession!.plannedDuration.inSeconds;
    if (totalSeconds == 0) return 0.0;
    return 1.0 - (remainingSeconds / totalSeconds);
  }

  /// 진행 중인지 확인
  bool get isRunning => status == FocusStateStatus.running;

  /// 일시정지 중인지 확인
  bool get isPaused => status == FocusStateStatus.paused;

  /// 완료되었는지 확인
  bool get isCompleted => status == FocusStateStatus.completed;

  /// 활성 세션이 있는지 확인
  bool get hasActiveSession =>
      status == FocusStateStatus.running || status == FocusStateStatus.paused;

  FocusState copyWith({
    FocusStateStatus? status,
    FocusSession? currentSession,
    int? remainingSeconds,
    String? errorMessage,
    bool clearError = false,
    bool clearSession = false,
  }) {
    return FocusState(
      status: status ?? this.status,
      currentSession:
          clearSession ? null : (currentSession ?? this.currentSession),
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props =>
      [status, currentSession, remainingSeconds, errorMessage];
}
