import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/time_block.dart';

/// TimeBlock Repository 인터페이스
///
/// TimeBlock 관련 데이터 접근을 위한 추상 인터페이스
abstract class TimeBlockRepository {
  /// 특정 날짜의 TimeBlock 목록 조회
  Future<Either<Failure, List<TimeBlock>>> getTimeBlocksForDay(DateTime date);

  /// 날짜 범위의 TimeBlock 목록 조회
  Future<Either<Failure, List<TimeBlock>>> getTimeBlocksForRange(
    DateTime start,
    DateTime end,
  );

  /// 단일 TimeBlock 조회
  Future<Either<Failure, TimeBlock>> getTimeBlockById(String id);

  /// TimeBlock 생성 (Task를 시간에 배치)
  Future<Either<Failure, TimeBlock>> createTimeBlock(TimeBlock timeBlock);

  /// TimeBlock 업데이트
  Future<Either<Failure, TimeBlock>> updateTimeBlock(TimeBlock timeBlock);

  /// TimeBlock 삭제
  Future<Either<Failure, void>> deleteTimeBlock(String id);

  /// TimeBlock 이동 (드래그 앤 드롭)
  Future<Either<Failure, TimeBlock>> moveTimeBlock(
    String id,
    DateTime newStartTime,
  );

  /// TimeBlock 크기 조정 (리사이징)
  Future<Either<Failure, TimeBlock>> resizeTimeBlock(
    String id,
    DateTime newStartTime,
    DateTime newEndTime,
  );

  /// 충돌하는 TimeBlock 조회
  Future<Either<Failure, List<TimeBlock>>> getConflictingTimeBlocks(
    DateTime startTime,
    DateTime endTime, {
    String? excludeId,
  });

  /// TimeBlock 상태 업데이트
  Future<Either<Failure, TimeBlock>> updateTimeBlockStatus(
    String id,
    TimeBlockStatus status,
  );

  /// 실제 시간 기록 (시작/종료)
  Future<Either<Failure, TimeBlock>> recordActualTime(
    String id, {
    DateTime? actualStart,
    DateTime? actualEnd,
  });

  /// 특정 날짜의 TimeBlock 스트림 (실시간 업데이트)
  Stream<Either<Failure, List<TimeBlock>>> watchTimeBlocksForDay(DateTime date);
}
