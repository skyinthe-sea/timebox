import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/productivity_stats.dart';
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
}
