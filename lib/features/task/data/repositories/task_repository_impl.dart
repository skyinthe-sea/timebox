import 'package:dartz/dartz.dart' hide Task;

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/task.dart';
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
}
