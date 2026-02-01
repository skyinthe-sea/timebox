import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/daily_stats_summary.dart';
import '../entities/priority_breakdown_stats.dart';
import '../entities/productivity_stats.dart';
import '../entities/task_completion_ranking.dart';
import '../entities/task_pipeline_stats.dart';
import '../entities/time_comparison.dart';

/// Analytics Repository 인터페이스
///
/// 분석 및 통계 데이터 접근을 위한 추상 인터페이스
abstract class AnalyticsRepository {
  /// 특정 날짜의 생산성 통계 조회
  Future<Either<Failure, ProductivityStats>> getDailyStats(DateTime date);

  /// 주간 생산성 통계 조회
  Future<Either<Failure, List<ProductivityStats>>> getWeeklyStats(
    DateTime weekStart,
  );

  /// 월간 생산성 통계 조회
  Future<Either<Failure, List<ProductivityStats>>> getMonthlyStats(
    int year,
    int month,
  );

  /// 생산성 점수 계산
  Future<Either<Failure, int>> calculateProductivityScore(DateTime date);

  /// 계획 vs 실제 시간 비교 데이터 조회
  Future<Either<Failure, List<TimeComparison>>> getTimeComparisons(
    DateTime start,
    DateTime end,
  );

  /// 태그별 시간 통계 조회
  Future<Either<Failure, List<TagTimeComparison>>> getTagStatistics(
    DateTime start,
    DateTime end,
  );

  /// 미완료 업무 (이월 대상) 조회
  Future<Either<Failure, List<String>>> getIncompleteTasks(DateTime date);

  /// 이월된 업무 수 조회
  Future<Either<Failure, int>> getRolloverCount(DateTime date);

  /// 특정 기간의 집중 시간 조회
  Future<Either<Failure, Duration>> getTotalFocusTime(
    DateTime start,
    DateTime end,
  );

  /// 통계 데이터 내보내기 (CSV)
  Future<Either<Failure, String>> exportToCsv(
    DateTime start,
    DateTime end,
  );

  /// 일간 통계 스트림 (실시간 업데이트)
  Stream<Either<Failure, ProductivityStats>> watchDailyStats(DateTime date);

  /// 일간 통계 요약 조회 (Top3 달성 등 추가 정보 포함)
  /// 캐시가 없거나 무효화된 경우 새로 계산
  Future<Either<Failure, DailyStatsSummary>> getDailyStatsSummary(DateTime date);

  /// Task Pipeline 통계 조회 (브레인덤프→스케줄→완료 흐름)
  Future<Either<Failure, TaskPipelineStats>> getTaskPipelineStats(
    DateTime start,
    DateTime end,
  );

  /// 우선순위별 완료율 통계 조회
  Future<Either<Failure, PriorityBreakdownStats>> getPriorityBreakdownStats(
    DateTime start,
    DateTime end,
  );

  /// Task 완료 랭킹 조회 (Top 5 성공 / Top 5 실패)
  Future<Either<Failure, ({List<TaskCompletionRanking> topSuccess, List<TaskCompletionRanking> topFailure})>> getTaskCompletionRankings(
    DateTime start,
    DateTime end,
  );
}
