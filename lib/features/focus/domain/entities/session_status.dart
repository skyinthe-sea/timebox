/// 포커스 세션 상태
///
/// 포커스 모드의 실행 상태를 나타내는 열거형
enum SessionStatus {
  /// 예정됨 (시작 전)
  pending,

  /// 진행 중
  inProgress,

  /// 일시 정지
  paused,

  /// 완료됨
  completed,

  /// 지연됨 (예정 시간 초과 후 진행 중)
  delayed,

  /// 건너뜀
  skipped,

  /// 취소됨
  cancelled,
}

/// SessionStatus 확장
extension SessionStatusExtension on SessionStatus {
  /// 활성 상태인지 확인 (진행 중, 일시 정지, 지연)
  bool get isActive {
    return this == SessionStatus.inProgress ||
        this == SessionStatus.paused ||
        this == SessionStatus.delayed;
  }

  /// 종료된 상태인지 확인 (완료, 건너뜀, 취소)
  bool get isEnded {
    return this == SessionStatus.completed ||
        this == SessionStatus.skipped ||
        this == SessionStatus.cancelled;
  }

  /// 상태 라벨 (영어 기본값, UI에서 l10n 사용 권장)
  String get label {
    return switch (this) {
      SessionStatus.pending => 'Pending',
      SessionStatus.inProgress => 'In Progress',
      SessionStatus.paused => 'Paused',
      SessionStatus.completed => 'Completed',
      SessionStatus.delayed => 'Delayed',
      SessionStatus.skipped => 'Skipped',
      SessionStatus.cancelled => 'Cancelled',
    };
  }
}
