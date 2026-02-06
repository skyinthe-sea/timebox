import 'package:equatable/equatable.dart';

/// 통계 기간
enum StatsPeriod {
  daily,
  weekly,
  monthly,
}

/// Statistics BLoC 이벤트
abstract class StatisticsEvent extends Equatable {
  const StatisticsEvent();

  @override
  List<Object?> get props => [];
}

/// 통계 로드
class LoadStatistics extends StatisticsEvent {
  final DateTime date;
  final StatsPeriod period;

  const LoadStatistics({
    required this.date,
    this.period = StatsPeriod.daily,
  });

  @override
  List<Object?> get props => [date, period];
}

/// 통계 새로고침
class RefreshStatistics extends StatisticsEvent {
  const RefreshStatistics();
}

/// 기간 변경
class ChangePeriod extends StatisticsEvent {
  final StatsPeriod period;

  const ChangePeriod(this.period);

  @override
  List<Object?> get props => [period];
}

/// 날짜 선택
class SelectDate extends StatisticsEvent {
  final DateTime date;

  const SelectDate(this.date);

  @override
  List<Object?> get props => [date];
}

/// 인사이트 새로고침
class RefreshInsights extends StatisticsEvent {
  const RefreshInsights();
}

/// 통계 데이터 백그라운드 프리로드
///
/// CalendarPage에서 호출하여 통계 데이터를 미리 로드
/// 상태 emit 최소화하여 UI 깜빡임 방지
class PreloadStatistics extends StatisticsEvent {
  final DateTime date;

  const PreloadStatistics(this.date);

  @override
  List<Object?> get props => [date];
}
