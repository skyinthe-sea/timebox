import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/daily_priority.dart';

/// DailyPriority 저장소 인터페이스
///
/// 날짜별 Top 3 우선순위 Task 관리를 위한 저장소 계약
abstract class DailyPriorityRepository {
  /// 특정 날짜의 DailyPriority 조회
  ///
  /// [date] 조회할 날짜
  /// Returns: DailyPriority 또는 없으면 null
  Future<Either<Failure, DailyPriority?>> getDailyPriority(DateTime date);

  /// DailyPriority 생성 또는 업데이트
  ///
  /// [dailyPriority] 저장할 DailyPriority
  Future<Either<Failure, DailyPriority>> saveDailyPriority(
      DailyPriority dailyPriority);

  /// 특정 순위에 Task 설정
  ///
  /// [date] 대상 날짜
  /// [rank] 순위 (1, 2, 3)
  /// [taskId] 설정할 Task ID (null이면 슬롯 비우기)
  Future<Either<Failure, DailyPriority>> setTaskRank({
    required DateTime date,
    required int rank,
    String? taskId,
  });

  /// 특정 순위에서 Task 제거
  ///
  /// [date] 대상 날짜
  /// [rank] 순위 (1, 2, 3)
  Future<Either<Failure, DailyPriority>> removeTaskFromRank({
    required DateTime date,
    required int rank,
  });

  /// 날짜 범위의 DailyPriority 목록 조회
  ///
  /// [startDate] 시작 날짜
  /// [endDate] 종료 날짜
  Future<Either<Failure, List<DailyPriority>>> getDailyPrioritiesInRange({
    required DateTime startDate,
    required DateTime endDate,
  });

  /// DailyPriority 실시간 스트림
  ///
  /// [date] 구독할 날짜
  Stream<Either<Failure, DailyPriority?>> watchDailyPriority(DateTime date);

  /// DailyPriority 삭제
  ///
  /// [date] 삭제할 날짜
  Future<Either<Failure, void>> deleteDailyPriority(DateTime date);
}
