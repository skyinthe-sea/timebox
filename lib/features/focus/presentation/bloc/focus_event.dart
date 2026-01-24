part of 'focus_bloc.dart';

/// Focus BLoC 이벤트
sealed class FocusEvent {
  const FocusEvent();
}

/// 포커스 세션 시작
class StartFocusSession extends FocusEvent {
  final String timeBlockId;
  final String? taskId;
  final String? title;
  final Duration duration;

  const StartFocusSession({
    required this.timeBlockId,
    this.taskId,
    this.title,
    required this.duration,
  });
}

/// 포커스 세션 로드
class LoadFocusSession extends FocusEvent {
  final String sessionId;
  const LoadFocusSession(this.sessionId);
}

/// 포커스 세션 일시정지
class PauseFocusSession extends FocusEvent {
  const PauseFocusSession();
}

/// 포커스 세션 재개
class ResumeFocusSession extends FocusEvent {
  const ResumeFocusSession();
}

/// 포커스 세션 완료
class CompleteFocusSession extends FocusEvent {
  const CompleteFocusSession();
}

/// 포커스 세션 건너뛰기
class SkipFocusSession extends FocusEvent {
  const SkipFocusSession();
}

/// 타이머 틱 (내부용)
class TimerTick extends FocusEvent {
  const TimerTick();
}

/// 타임블록 기반 집중 세션 시작
class StartTimeBlockFocusSession extends FocusEvent {
  final String timeBlockId;
  final String? taskId;
  final String? taskTitle;
  final DateTime endTime;

  const StartTimeBlockFocusSession({
    required this.timeBlockId,
    this.taskId,
    this.taskTitle,
    required this.endTime,
  });
}

/// 집중 세션 강제 종료 요청 (수학 문제 해제 필요)
class RequestEndFocusSession extends FocusEvent {
  const RequestEndFocusSession();
}

/// 수학 문제 해제 완료 후 세션 종료
class EndFocusSessionAfterChallenge extends FocusEvent {
  const EndFocusSessionAfterChallenge();
}
