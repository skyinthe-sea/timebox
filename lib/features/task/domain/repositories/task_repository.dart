import 'package:dartz/dartz.dart' hide Task;
import '../../../../core/error/failures.dart';
import '../entities/task.dart';
import '../entities/task_suggestion.dart';
import '../entities/subtask.dart';

/// Task Repository 인터페이스
///
/// Task 관련 데이터 접근을 위한 추상 인터페이스
/// Data Layer에서 구현
abstract class TaskRepository {
  /// 모든 Task 조회
  Future<Either<Failure, List<Task>>> getTasks();

  /// 상태별 Task 조회
  Future<Either<Failure, List<Task>>> getTasksByStatus(TaskStatus status);

  /// 단일 Task 조회
  Future<Either<Failure, Task>> getTaskById(String id);

  /// Task 생성
  Future<Either<Failure, Task>> createTask(Task task);

  /// Task 업데이트
  Future<Either<Failure, Task>> updateTask(Task task);

  /// Task 삭제
  Future<Either<Failure, void>> deleteTask(String id);

  /// Task 검색
  Future<Either<Failure, List<Task>>> searchTasks(String query);

  /// Task 상태 변경
  Future<Either<Failure, Task>> updateTaskStatus(String id, TaskStatus status);

  /// Subtask 추가
  Future<Either<Failure, Task>> addSubtask(String taskId, Subtask subtask);

  /// Subtask 토글 (완료/미완료)
  Future<Either<Failure, Task>> toggleSubtask(String taskId, String subtaskId);

  /// Subtask 삭제
  Future<Either<Failure, Task>> deleteSubtask(String taskId, String subtaskId);

  /// 미완료 Task를 다음 날로 이월
  Future<Either<Failure, List<Task>>> rolloverIncompleteTasks(DateTime fromDate);

  /// Task 스트림 (실시간 업데이트)
  Stream<Either<Failure, List<Task>>> watchTasks();

  /// 날짜별 Task 조회
  Future<Either<Failure, List<Task>>> getTasksByDate(DateTime date);

  /// 날짜별 Task 스트림 (실시간 업데이트)
  Stream<Either<Failure, List<Task>>> watchTasksByDate(DateTime date);

  /// Task를 다른 날짜로 복제 (내일도 하기)
  Future<Either<Failure, Task>> copyTaskToDate(String taskId, DateTime date);

  /// Task 이월 처리 (rolloverCount 증가)
  Future<Either<Failure, Task>> rolloverTask(String taskId, DateTime toDate);

  /// 과거 이력 기반 Task 제안 조회
  Future<Either<Failure, List<TaskSuggestion>>> getTaskSuggestions(
    String query,
    DateTime currentTime,
  );
}
