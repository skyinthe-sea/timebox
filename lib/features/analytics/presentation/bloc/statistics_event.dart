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
