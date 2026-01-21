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
