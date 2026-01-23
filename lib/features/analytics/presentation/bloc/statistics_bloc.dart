import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/insight.dart';
import '../../domain/entities/productivity_stats.dart';
import '../../domain/entities/time_comparison.dart';
import '../../domain/repositories/analytics_repository.dart';
import 'statistics_event.dart';
import 'statistics_state.dart';

/// Statistics BLoC
///
/// 통계 페이지의 상태 관리
class StatisticsBloc extends Bloc<StatisticsEvent, StatisticsState> {
  final AnalyticsRepository _analyticsRepository;

  StatisticsBloc({
    required AnalyticsRepository analyticsRepository,
  })  : _analyticsRepository = analyticsRepository,
        super(StatisticsState.initial()) {
    on<LoadStatistics>(_onLoadStatistics);
    on<RefreshStatistics>(_onRefreshStatistics);
    on<ChangePeriod>(_onChangePeriod);
    on<SelectDate>(_onSelectDate);
    on<RefreshInsights>(_onRefreshInsights);
  }

  Future<void> _onLoadStatistics(
    LoadStatistics event,
    Emitter<StatisticsState> emit,
  ) async {
    emit(state.copyWith(
      status: StatisticsStatus.loading,
      selectedDate: event.date,
      currentPeriod: event.period,
    ));

    try {
      // 오늘 통계 로드
      final todayResult = await _analyticsRepository.getDailyStats(event.date);
      final todayStats = todayResult.fold(
        (failure) => null,
        (stats) => stats,
      );

      // 어제 통계 로드 (비교용)
      final yesterday = event.date.subtract(const Duration(days: 1));
      final yesterdayResult = await _analyticsRepository.getDailyStats(yesterday);
      final yesterdayStats = yesterdayResult.fold(
        (failure) => null,
        (stats) => stats,
      );

      // 기간별 통계 로드
      final periodStats = await _loadPeriodStats(event.date, event.period);

      // 태그별 통계 로드
      final tagStats = await _loadTagStats(event.date, event.period);

      // 히트맵 데이터 로드 (주간/월간만) - 현재 미구현
      // await _loadHourlyProductivity(event.date, event.period);

      // 인사이트 생성
      final insights = await _generateInsights(event.date);

      emit(state.copyWith(
        status: StatisticsStatus.loaded,
        todayStats: todayStats,
        yesterdayStats: yesterdayStats,
        periodStats: periodStats,
        tagStats: tagStats,
        insights: insights,
        errorMessage: null,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: StatisticsStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onRefreshStatistics(
    RefreshStatistics event,
    Emitter<StatisticsState> emit,
  ) async {
    add(LoadStatistics(
      date: state.selectedDate,
      period: state.currentPeriod,
    ));
  }

  Future<void> _onChangePeriod(
    ChangePeriod event,
    Emitter<StatisticsState> emit,
  ) async {
    add(LoadStatistics(
      date: state.selectedDate,
      period: event.period,
    ));
  }

  Future<void> _onSelectDate(
    SelectDate event,
    Emitter<StatisticsState> emit,
  ) async {
    add(LoadStatistics(
      date: event.date,
      period: state.currentPeriod,
    ));
  }

  Future<void> _onRefreshInsights(
    RefreshInsights event,
    Emitter<StatisticsState> emit,
  ) async {
    final insights = await _generateInsights(state.selectedDate);
    emit(state.copyWith(insights: insights));
  }

  /// 기간별 통계 로드
  Future<List<ProductivityStats>> _loadPeriodStats(
    DateTime date,
    StatsPeriod period,
  ) async {
    switch (period) {
      case StatsPeriod.daily:
        return [];
      case StatsPeriod.weekly:
        final weekStart = date.subtract(Duration(days: date.weekday - 1));
        final result = await _analyticsRepository.getWeeklyStats(weekStart);
        return result.fold((failure) => [], (stats) => stats);
      case StatsPeriod.monthly:
        final result = await _analyticsRepository.getMonthlyStats(
          date.year,
          date.month,
        );
        return result.fold((failure) => [], (stats) => stats);
    }
  }

  /// 태그별 통계 로드
  Future<List<TagTimeComparison>> _loadTagStats(
    DateTime date,
    StatsPeriod period,
  ) async {
    DateTime start;
    DateTime end;

    switch (period) {
      case StatsPeriod.daily:
        start = DateTime(date.year, date.month, date.day);
        end = start;
        break;
      case StatsPeriod.weekly:
        start = date.subtract(Duration(days: date.weekday - 1));
        end = start.add(const Duration(days: 6));
        break;
      case StatsPeriod.monthly:
        start = DateTime(date.year, date.month, 1);
        end = DateTime(date.year, date.month + 1, 0);
        break;
    }

    final result = await _analyticsRepository.getTagStatistics(start, end);
    return result.fold((failure) => [], (stats) => stats);
  }

  /// 인사이트 생성
  Future<List<Insight>> _generateInsights(DateTime date) async {
    // 기본 인사이트 생성
    final insights = <Insight>[];

    // 어제 대비 점수 변화 인사이트
    if (state.todayStats != null && state.yesterdayStats != null) {
      final scoreDiff = state.todayStats!.score - state.yesterdayStats!.score;
      if (scoreDiff.abs() >= 5) {
        insights.add(Insight.productivityChange(
          id: 'insight_score_${DateTime.now().millisecondsSinceEpoch}',
          scoreDiff: scoreDiff,
          periodText: '어제',
        ));
      }
    }

    return insights;
  }
}
