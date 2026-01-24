import 'session_status.dart';

/// FocusSession 엔티티
///
/// 포커스 모드 세션을 나타내는 도메인 객체
///
/// TimeBlock을 실행할 때 생성되며, 실제 작업 시간을 추적
class FocusSession {
  /// 고유 식별자
  final String id;

  /// 연결된 TimeBlock ID
  final String timeBlockId;

  /// 연결된 Task ID (선택)
  final String? taskId;

  /// 세션 상태
  final SessionStatus status;

  /// 계획된 시작 시간
  final DateTime plannedStartTime;

  /// 계획된 종료 시간
  final DateTime plannedEndTime;

  /// 실제 시작 시간
  final DateTime? actualStartTime;

  /// 실제 종료 시간
  final DateTime? actualEndTime;

  /// 일시 정지 시간 목록 (정지/재개 기록)
  final List<PauseRecord> pauseRecords;

  /// 생성 시간
  final DateTime createdAt;

  const FocusSession({
    required this.id,
    required this.timeBlockId,
    this.taskId,
    this.status = SessionStatus.pending,
    required this.plannedStartTime,
    required this.plannedEndTime,
    this.actualStartTime,
    this.actualEndTime,
    this.pauseRecords = const [],
    required this.createdAt,
  });

  /// 계획된 소요 시간
  Duration get plannedDuration =>
      plannedEndTime.difference(plannedStartTime);

  /// 실제 소요 시간 (완료된 경우)
  Duration? get actualDuration {
    if (actualStartTime == null || actualEndTime == null) return null;
    // 일시 정지 시간 제외
    final totalPauseDuration = pauseRecords.fold<Duration>(
      Duration.zero,
      (total, record) => total + (record.duration ?? Duration.zero),
    );
    return actualEndTime!.difference(actualStartTime!) - totalPauseDuration;
  }

  /// 남은 시간 (진행 중인 경우)
  Duration? get remainingTime {
    if (status != SessionStatus.inProgress) return null;
    final now = DateTime.now();
    final remaining = plannedEndTime.difference(now);
    return remaining.isNegative ? Duration.zero : remaining;
  }

  /// 진행률 (0.0 ~ 1.0)
  double get progress {
    if (actualStartTime == null) return 0.0;
    final now = DateTime.now();
    final elapsed = now.difference(actualStartTime!);
    final ratio = elapsed.inSeconds / plannedDuration.inSeconds;
    return ratio.clamp(0.0, 1.0);
  }

  /// 현재 일시 정지 중인지 확인
  bool get isPaused {
    if (pauseRecords.isEmpty) return false;
    return pauseRecords.last.resumeTime == null;
  }

  /// copyWith 메서드
  FocusSession copyWith({
    String? id,
    String? timeBlockId,
    String? taskId,
    bool clearTaskId = false,
    SessionStatus? status,
    DateTime? plannedStartTime,
    DateTime? plannedEndTime,
    DateTime? actualStartTime,
    bool clearActualStartTime = false,
    DateTime? actualEndTime,
    bool clearActualEndTime = false,
    List<PauseRecord>? pauseRecords,
    DateTime? createdAt,
  }) {
    return FocusSession(
      id: id ?? this.id,
      timeBlockId: timeBlockId ?? this.timeBlockId,
      taskId: clearTaskId ? null : (taskId ?? this.taskId),
      status: status ?? this.status,
      plannedStartTime: plannedStartTime ?? this.plannedStartTime,
      plannedEndTime: plannedEndTime ?? this.plannedEndTime,
      actualStartTime: clearActualStartTime
          ? null
          : (actualStartTime ?? this.actualStartTime),
      actualEndTime:
          clearActualEndTime ? null : (actualEndTime ?? this.actualEndTime),
      pauseRecords: pauseRecords ?? this.pauseRecords,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FocusSession && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

/// 일시 정지 기록
class PauseRecord {
  /// 일시 정지 시작 시간
  final DateTime pauseTime;

  /// 재개 시간 (아직 일시 정지 중이면 null)
  final DateTime? resumeTime;

  const PauseRecord({
    required this.pauseTime,
    this.resumeTime,
  });

  /// 일시 정지 지속 시간
  Duration? get duration {
    if (resumeTime == null) return null;
    return resumeTime!.difference(pauseTime);
  }
}
