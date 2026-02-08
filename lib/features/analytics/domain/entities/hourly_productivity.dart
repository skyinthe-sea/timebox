import 'package:equatable/equatable.dart';

/// HourlyProductivity 엔티티
///
/// 시간대별 생산성 데이터 (히트맵용)
/// 요일 x 시간 그리드에서 사용
class HourlyProductivity extends Equatable {
  /// 시간 (0~23)
  final int hour;

  /// 요일 (1=월요일, 7=일요일)
  final int dayOfWeek;

  /// 해당 시간대의 집중 세션 수
  final int sessionCount;

  /// 총 집중 시간
  final Duration totalFocusDuration;

  /// 완료율 (%)
  final double completionRate;

  /// 데이터 수집 기간 (일수)
  final int sampleDays;

  const HourlyProductivity({
    required this.hour,
    required this.dayOfWeek,
    required this.sessionCount,
    required this.totalFocusDuration,
    required this.completionRate,
    required this.sampleDays,
  });

  /// 평균 집중 시간 (분)
  double get avgFocusMinutes {
    if (sampleDays == 0) return 0;
    return totalFocusDuration.inMinutes / sampleDays;
  }

  /// 생산성 강도 (0.0 ~ 1.0)
  /// 히트맵 색상 농도에 사용
  double get intensity {
    // 기본값: 완료율과 세션 수를 조합
    if (sessionCount == 0) return 0.0;

    // 완료율 50%, 세션 빈도 50%로 가중치
    final rateScore = (completionRate / 100).clamp(0.0, 1.0);
    final freqScore = (sessionCount / (sampleDays * 0.5)).clamp(0.0, 1.0);

    return (rateScore * 0.5 + freqScore * 0.5).clamp(0.0, 1.0);
  }

  /// 요일 이름 (영어 약어)
  String get dayNameShort {
    const days = ['', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[dayOfWeek];
  }

  /// 시간 레이블 (예: "14:00")
  String get hourLabel => '$hour:00';

  /// 빈 데이터 생성
  factory HourlyProductivity.empty(int hour, int dayOfWeek) {
    return HourlyProductivity(
      hour: hour,
      dayOfWeek: dayOfWeek,
      sessionCount: 0,
      totalFocusDuration: Duration.zero,
      completionRate: 0.0,
      sampleDays: 0,
    );
  }

  HourlyProductivity copyWith({
    int? hour,
    int? dayOfWeek,
    int? sessionCount,
    Duration? totalFocusDuration,
    double? completionRate,
    int? sampleDays,
  }) {
    return HourlyProductivity(
      hour: hour ?? this.hour,
      dayOfWeek: dayOfWeek ?? this.dayOfWeek,
      sessionCount: sessionCount ?? this.sessionCount,
      totalFocusDuration: totalFocusDuration ?? this.totalFocusDuration,
      completionRate: completionRate ?? this.completionRate,
      sampleDays: sampleDays ?? this.sampleDays,
    );
  }

  @override
  List<Object?> get props => [
        hour,
        dayOfWeek,
        sessionCount,
        totalFocusDuration,
        completionRate,
        sampleDays,
      ];
}

/// 히트맵 데이터 컨테이너
class ProductivityHeatmapData extends Equatable {
  /// 7x24 그리드 데이터 (요일 x 시간)
  final List<List<HourlyProductivity>> grid;

  /// 시작 날짜
  final DateTime startDate;

  /// 종료 날짜
  final DateTime endDate;

  const ProductivityHeatmapData({
    required this.grid,
    required this.startDate,
    required this.endDate,
  });

  /// 특정 요일, 시간의 데이터 조회
  HourlyProductivity getAt(int dayOfWeek, int hour) {
    if (dayOfWeek < 1 || dayOfWeek > 7) {
      return HourlyProductivity.empty(hour, dayOfWeek);
    }
    if (hour < 0 || hour > 23) {
      return HourlyProductivity.empty(hour, dayOfWeek);
    }
    return grid[dayOfWeek - 1][hour];
  }

  /// 가장 생산적인 시간대 찾기
  HourlyProductivity? get mostProductiveSlot {
    HourlyProductivity? best;
    double maxIntensity = 0;

    for (final row in grid) {
      for (final slot in row) {
        if (slot.intensity > maxIntensity) {
          maxIntensity = slot.intensity;
          best = slot;
        }
      }
    }
    return best;
  }

  /// 가장 생산적인 요일 찾기 (1~7)
  int? get mostProductiveDay {
    double maxAvg = 0;
    int? bestDay;

    for (int d = 0; d < 7; d++) {
      double sum = 0;
      int count = 0;
      for (final slot in grid[d]) {
        if (slot.sessionCount > 0) {
          sum += slot.intensity;
          count++;
        }
      }
      if (count > 0) {
        final avg = sum / count;
        if (avg > maxAvg) {
          maxAvg = avg;
          bestDay = d + 1;
        }
      }
    }
    return bestDay;
  }

  /// 빈 히트맵 데이터 생성
  factory ProductivityHeatmapData.empty() {
    final grid = List.generate(
      7,
      (d) => List.generate(
        24,
        (h) => HourlyProductivity.empty(h, d + 1),
      ),
    );
    final now = DateTime.now();
    return ProductivityHeatmapData(
      grid: grid,
      startDate: now.subtract(const Duration(days: 7)),
      endDate: now,
    );
  }

  @override
  List<Object?> get props => [grid, startDate, endDate];
}
