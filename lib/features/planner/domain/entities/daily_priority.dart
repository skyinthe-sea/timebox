/// DailyPriority 엔티티
///
/// 특정 날짜의 Top 3 우선순위 Task를 저장하는 도메인 객체
///
/// 기능:
/// - 날짜별 Top 3 Task 관리
/// - 1순위(빨강), 2순위(주황), 3순위(파랑) 색상으로 구분
class DailyPriority {
  /// 고유 식별자
  final String id;

  /// 날짜 (시간은 무시, 자정으로 정규화)
  final DateTime date;

  /// 1순위 Task ID (빨강)
  final String? rank1TaskId;

  /// 2순위 Task ID (주황)
  final String? rank2TaskId;

  /// 3순위 Task ID (파랑)
  final String? rank3TaskId;

  /// 생성 시간
  final DateTime createdAt;

  /// 마지막 수정 시간
  final DateTime updatedAt;

  const DailyPriority({
    required this.id,
    required this.date,
    this.rank1TaskId,
    this.rank2TaskId,
    this.rank3TaskId,
    required this.createdAt,
    required this.updatedAt,
  });

  /// 날짜 키 생성 (yyyy-MM-dd 형식)
  String get dateKey {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  /// 빈 슬롯 여부
  bool get hasEmptySlot =>
      rank1TaskId == null || rank2TaskId == null || rank3TaskId == null;

  /// 모든 슬롯이 채워졌는지 여부
  bool get isAllFilled =>
      rank1TaskId != null && rank2TaskId != null && rank3TaskId != null;

  /// Task ID가 Top 3에 포함되어 있는지 확인
  bool containsTask(String taskId) {
    return rank1TaskId == taskId ||
        rank2TaskId == taskId ||
        rank3TaskId == taskId;
  }

  /// Task의 순위 반환 (1, 2, 3 또는 null)
  int? getRankForTask(String taskId) {
    if (rank1TaskId == taskId) return 1;
    if (rank2TaskId == taskId) return 2;
    if (rank3TaskId == taskId) return 3;
    return null;
  }

  /// 모든 Task ID 목록 반환
  List<String> get allTaskIds {
    return [
      if (rank1TaskId != null) rank1TaskId!,
      if (rank2TaskId != null) rank2TaskId!,
      if (rank3TaskId != null) rank3TaskId!,
    ];
  }

  /// copyWith 메서드
  DailyPriority copyWith({
    String? id,
    DateTime? date,
    String? rank1TaskId,
    String? rank2TaskId,
    String? rank3TaskId,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool clearRank1 = false,
    bool clearRank2 = false,
    bool clearRank3 = false,
  }) {
    return DailyPriority(
      id: id ?? this.id,
      date: date ?? this.date,
      rank1TaskId: clearRank1 ? null : (rank1TaskId ?? this.rank1TaskId),
      rank2TaskId: clearRank2 ? null : (rank2TaskId ?? this.rank2TaskId),
      rank3TaskId: clearRank3 ? null : (rank3TaskId ?? this.rank3TaskId),
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DailyPriority &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          date == other.date &&
          rank1TaskId == other.rank1TaskId &&
          rank2TaskId == other.rank2TaskId &&
          rank3TaskId == other.rank3TaskId;

  @override
  int get hashCode =>
      id.hashCode ^
      date.hashCode ^
      rank1TaskId.hashCode ^
      rank2TaskId.hashCode ^
      rank3TaskId.hashCode;
}
