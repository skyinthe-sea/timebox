import 'dart:math';

import 'package:dartz/dartz.dart' hide Task;

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/task.dart';
import '../../domain/entities/task_suggestion.dart';
import '../../domain/entities/subtask.dart';
import '../../domain/repositories/task_repository.dart';
import '../datasources/task_local_datasource.dart';
import '../models/task_model.dart';
import '../models/subtask_model.dart';

/// Task Repository 구현
///
/// TaskLocalDataSource를 사용하여 데이터 접근
class TaskRepositoryImpl implements TaskRepository {
  final TaskLocalDataSource localDataSource;

  TaskRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<Task>>> getTasks() async {
    try {
      final models = await localDataSource.getTasks();
      final tasks = models.map((m) => m.toEntity()).toList();
      return Right(tasks);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Task>>> getTasksByStatus(TaskStatus status) async {
    try {
      final models = await localDataSource.getTasks();
      final tasks = models
          .map((m) => m.toEntity())
          .where((t) => t.status == status)
          .toList();
      return Right(tasks);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Task>> getTaskById(String id) async {
    try {
      final model = await localDataSource.getTaskById(id);
      if (model == null) {
        return Left(CacheFailure(message: 'Task not found'));
      }
      return Right(model.toEntity());
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Task>> createTask(Task task) async {
    try {
      final model = TaskModel.fromEntity(task);
      final savedModel = await localDataSource.saveTask(model);
      return Right(savedModel.toEntity());
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Task>> updateTask(Task task) async {
    try {
      final model = TaskModel.fromEntity(task);
      final savedModel = await localDataSource.saveTask(model);
      return Right(savedModel.toEntity());
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTask(String id) async {
    try {
      await localDataSource.deleteTask(id);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Task>>> searchTasks(String query) async {
    try {
      final models = await localDataSource.getTasks();
      final lowerQuery = query.toLowerCase();
      final tasks = models
          .map((m) => m.toEntity())
          .where((t) =>
              t.title.toLowerCase().contains(lowerQuery) ||
              (t.note?.toLowerCase().contains(lowerQuery) ?? false))
          .toList();
      return Right(tasks);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Task>> updateTaskStatus(
      String id, TaskStatus status) async {
    try {
      final model = await localDataSource.getTaskById(id);
      if (model == null) {
        return Left(CacheFailure(message: 'Task not found'));
      }

      final updatedModel = model.copyWith(
        status: status.name,
        completedAt: status == TaskStatus.done ? DateTime.now() : null,
      );
      final savedModel = await localDataSource.saveTask(updatedModel);
      return Right(savedModel.toEntity());
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Task>> addSubtask(
      String taskId, Subtask subtask) async {
    try {
      final model = await localDataSource.getTaskById(taskId);
      if (model == null) {
        return Left(CacheFailure(message: 'Task not found'));
      }

      final subtaskModel = SubtaskModel.fromEntity(subtask);
      final updatedSubtasks = [...model.subtasks, subtaskModel];
      final updatedModel = model.copyWith(subtasks: updatedSubtasks);
      final savedModel = await localDataSource.saveTask(updatedModel);
      return Right(savedModel.toEntity());
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Task>> toggleSubtask(
      String taskId, String subtaskId) async {
    try {
      final model = await localDataSource.getTaskById(taskId);
      if (model == null) {
        return Left(CacheFailure(message: 'Task not found'));
      }

      final updatedSubtasks = model.subtasks.map((s) {
        if (s.id == subtaskId) {
          return s.copyWith(isCompleted: !s.isCompleted);
        }
        return s;
      }).toList();

      final updatedModel = model.copyWith(subtasks: updatedSubtasks);
      final savedModel = await localDataSource.saveTask(updatedModel);
      return Right(savedModel.toEntity());
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Task>> deleteSubtask(
      String taskId, String subtaskId) async {
    try {
      final model = await localDataSource.getTaskById(taskId);
      if (model == null) {
        return Left(CacheFailure(message: 'Task not found'));
      }

      final updatedSubtasks =
          model.subtasks.where((s) => s.id != subtaskId).toList();
      final updatedModel = model.copyWith(subtasks: updatedSubtasks);
      final savedModel = await localDataSource.saveTask(updatedModel);
      return Right(savedModel.toEntity());
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Task>>> rolloverIncompleteTasks(
      DateTime fromDate) async {
    // TODO: Implement rollover logic
    return const Right([]);
  }

  @override
  Stream<Either<Failure, List<Task>>> watchTasks() {
    return localDataSource.watchTasks().map((models) {
      try {
        final tasks = models.map((m) => m.toEntity()).toList();
        return Right<Failure, List<Task>>(tasks);
      } catch (e) {
        return Left<Failure, List<Task>>(UnknownFailure(message: e.toString()));
      }
    });
  }

  @override
  Future<Either<Failure, List<Task>>> getTasksByDate(DateTime date) async {
    try {
      final models = await localDataSource.getTasksByDate(date);
      final tasks = models.map((m) => m.toEntity()).toList();
      return Right(tasks);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Stream<Either<Failure, List<Task>>> watchTasksByDate(DateTime date) {
    return localDataSource.watchTasksByDate(date).map((models) {
      try {
        final tasks = models.map((m) => m.toEntity()).toList();
        return Right<Failure, List<Task>>(tasks);
      } catch (e) {
        return Left<Failure, List<Task>>(UnknownFailure(message: e.toString()));
      }
    });
  }

  @override
  Future<Either<Failure, Task>> copyTaskToDate(
      String taskId, DateTime date) async {
    try {
      final model = await localDataSource.getTaskById(taskId);
      if (model == null) {
        return Left(CacheFailure(message: 'Task not found'));
      }

      // 새 ID로 Task 복제, rolloverCount는 0으로 초기화
      final newModel = model.copyWith(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        targetDate: date,
        rolloverCount: 0,
        status: 'todo',
        completedAt: null,
      );
      final savedModel = await localDataSource.saveTask(newModel);
      return Right(savedModel.toEntity());
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Task>> rolloverTask(
      String taskId, DateTime toDate) async {
    try {
      final model = await localDataSource.getTaskById(taskId);
      if (model == null) {
        return Left(CacheFailure(message: 'Task not found'));
      }

      // targetDate 업데이트 및 rolloverCount 증가
      final updatedModel = model.copyWith(
        targetDate: toDate,
        rolloverCount: model.rolloverCount + 1,
      );
      final savedModel = await localDataSource.saveTask(updatedModel);
      return Right(savedModel.toEntity());
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TaskSuggestion>>> getTaskSuggestions(
    String query,
    DateTime currentTime,
  ) async {
    try {
      final models = await localDataSource.getTasks();
      final tasks = models.map((m) => m.toEntity()).toList();
      final lowerQuery = query.toLowerCase().trim();

      if (lowerQuery.isEmpty) return const Right([]);

      // 정규화된 제목으로 그룹핑
      final groups = <String, List<Task>>{};
      for (final task in tasks) {
        final normalized = task.title.toLowerCase().trim();
        groups.putIfAbsent(normalized, () => []).add(task);
      }

      final suggestions = <TaskSuggestion>[];
      final currentHour = currentTime.hour;

      for (final entry in groups.entries) {
        final normalized = entry.key;
        if (!normalized.contains(lowerQuery)) continue;

        final group = entry.value;
        final frequency = group.length;

        // 시간대 매칭: ±2h 이내에 생성된 Task 비율
        final timeMatches = group.where((t) {
          final diff = (t.createdAt.hour - currentHour).abs();
          return diff <= 2 || diff >= 22; // 자정 넘김 고려
        }).length;
        final timeOfDayMatch = frequency > 0 ? timeMatches / frequency : 0.0;

        // 최근 사용 보너스: 30일 이내 → 1.0~0.0 선형 감소
        final lastUsed = group
            .map((t) => t.createdAt)
            .reduce((a, b) => a.isAfter(b) ? a : b);
        final daysSinceLastUse =
            currentTime.difference(lastUsed).inDays.clamp(0, 30);
        final recencyBonus = 1.0 - (daysSinceLastUse / 30.0);

        // 빈도 정규화 (최대 10회 기준)
        final normalizedFreq = min(frequency / 10.0, 1.0);

        final score = (normalizedFreq * 0.4) +
            (timeOfDayMatch * 0.3) +
            (recencyBonus * 0.3);

        // 평균 예상 소요 시간
        final totalMinutes = group.fold<int>(
          0,
          (sum, t) => sum + t.estimatedDuration.inMinutes,
        );
        final avgMinutes = totalMinutes ~/ frequency;

        suggestions.add(TaskSuggestion(
          title: group.first.title, // 원래 대소문자 유지
          score: score,
          frequency: frequency,
          lastUsedAt: lastUsed,
          avgEstimatedDuration: Duration(minutes: avgMinutes),
        ));
      }

      // 점수 내림차순 정렬, 상위 5개
      suggestions.sort((a, b) => b.score.compareTo(a.score));
      return Right(suggestions.take(5).toList());
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }
}
