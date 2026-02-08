import 'dart:math';

import 'package:dartz/dartz.dart' hide Task;

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/services/stats_update_service.dart';
import '../../../analytics/data/datasources/analytics_local_datasource.dart';
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
  final AnalyticsLocalDataSource? analyticsDataSource;
  final StatsUpdateService? statsUpdateService;

  /// 추천 캐시 (null이면 다음 조회 시 재빌드)
  List<_SuggestionGroupData>? _suggestionCache;

  TaskRepositoryImpl({
    required this.localDataSource,
    this.analyticsDataSource,
    this.statsUpdateService,
  });

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

      _suggestionCache = null;

      // Write-through 통계 재계산
      if (savedModel.targetDate != null) {
        final date = DateTime(
          savedModel.targetDate!.year,
          savedModel.targetDate!.month,
          savedModel.targetDate!.day,
        );
        statsUpdateService?.onDataChanged(date);
      }

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

      _suggestionCache = null;

      // Write-through 통계 재계산
      if (savedModel.targetDate != null) {
        final date = DateTime(
          savedModel.targetDate!.year,
          savedModel.targetDate!.month,
          savedModel.targetDate!.day,
        );
        statsUpdateService?.onDataChanged(date);
      }

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
      // 삭제 전 날짜 정보 먼저 조회
      final model = await localDataSource.getTaskById(id);

      await localDataSource.deleteTask(id);
      _suggestionCache = null;

      // Write-through 통계 재계산
      if (model != null && model.targetDate != null) {
        final date = DateTime(
          model.targetDate!.year,
          model.targetDate!.month,
          model.targetDate!.day,
        );
        statsUpdateService?.onDataChanged(date);
      }

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
      _suggestionCache = null;

      // Write-through 통계 재계산
      if (savedModel.targetDate != null) {
        final date = DateTime(
          savedModel.targetDate!.year,
          savedModel.targetDate!.month,
          savedModel.targetDate!.day,
        );
        statsUpdateService?.onDataChanged(date);
      }

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
      _suggestionCache = null;

      // Write-through 통계 재계산
      statsUpdateService?.onDataChanged(DateTime(
        date.year,
        date.month,
        date.day,
      ));

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

      // 이전 날짜 저장 (양쪽 날짜 모두 통계 갱신 필요)
      final oldDate = model.targetDate;

      // targetDate 업데이트 및 rolloverCount 증가
      final updatedModel = model.copyWith(
        targetDate: toDate,
        rolloverCount: model.rolloverCount + 1,
      );
      final savedModel = await localDataSource.saveTask(updatedModel);
      _suggestionCache = null;

      // Write-through 통계 재계산 (양쪽 날짜)
      if (oldDate != null) {
        statsUpdateService?.onDataChanged(DateTime(
          oldDate.year,
          oldDate.month,
          oldDate.day,
        ));
      }
      statsUpdateService?.onDataChanged(DateTime(
        toDate.year,
        toDate.month,
        toDate.day,
      ));

      return Right(savedModel.toEntity());
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  /// 캐시를 빌드하여 경량 그룹 데이터를 생성
  Future<List<_SuggestionGroupData>> _buildSuggestionCache() async {
    final models = await localDataSource.getTasks();
    final groups = <String, _SuggestionGroupData>{};

    for (final model in models) {
      final entity = model.toEntity();
      final normalized = entity.title.toLowerCase().trim();

      final existing = groups[normalized];
      if (existing != null) {
        existing.frequency++;
        existing.creationHours.add(entity.createdAt.hour);
        if (entity.createdAt.isAfter(existing.lastUsedAt)) {
          existing.lastUsedAt = entity.createdAt;
        }
        existing.totalEstimatedMinutes += entity.estimatedDuration.inMinutes;
      } else {
        groups[normalized] = _SuggestionGroupData(
          normalizedTitle: normalized,
          originalTitle: entity.title,
          frequency: 1,
          creationHours: [entity.createdAt.hour],
          lastUsedAt: entity.createdAt,
          totalEstimatedMinutes: entity.estimatedDuration.inMinutes,
        );
      }
    }

    final cache = groups.values.toList();
    _suggestionCache = cache;
    return cache;
  }

  @override
  Future<Either<Failure, List<TaskSuggestion>>> getTaskSuggestions(
    String query,
    DateTime currentTime,
  ) async {
    try {
      final lowerQuery = query.toLowerCase().trim();
      if (lowerQuery.isEmpty) return const Right([]);

      final cache = _suggestionCache ?? await _buildSuggestionCache();

      final suggestions = <TaskSuggestion>[];
      final currentHour = currentTime.hour;

      for (final group in cache) {
        if (!group.normalizedTitle.startsWith(lowerQuery)) continue;

        final frequency = group.frequency;

        // 시간대 매칭: ±2h 이내에 생성된 Task 비율
        final timeMatches = group.creationHours.where((hour) {
          final diff = (hour - currentHour).abs();
          return diff <= 2 || diff >= 22; // 자정 넘김 고려
        }).length;
        final timeOfDayMatch = frequency > 0 ? timeMatches / frequency : 0.0;

        // 최근 사용 보너스: 30일 이내 → 1.0~0.0 선형 감소
        final daysSinceLastUse =
            currentTime.difference(group.lastUsedAt).inDays.clamp(0, 30);
        final recencyBonus = 1.0 - (daysSinceLastUse / 30.0);

        // 빈도 정규화 (최대 10회 기준)
        final normalizedFreq = min(frequency / 10.0, 1.0);

        final score = (normalizedFreq * 0.4) +
            (timeOfDayMatch * 0.3) +
            (recencyBonus * 0.3);

        // 평균 예상 소요 시간
        final avgMinutes = group.totalEstimatedMinutes ~/ frequency;

        suggestions.add(TaskSuggestion(
          title: group.originalTitle,
          score: score,
          frequency: frequency,
          lastUsedAt: group.lastUsedAt,
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

/// 추천 목록을 위한 경량 캐시 데이터
class _SuggestionGroupData {
  final String normalizedTitle;
  final String originalTitle;
  int frequency;
  final List<int> creationHours;
  DateTime lastUsedAt;
  int totalEstimatedMinutes;

  _SuggestionGroupData({
    required this.normalizedTitle,
    required this.originalTitle,
    required this.frequency,
    required this.creationHours,
    required this.lastUsedAt,
    required this.totalEstimatedMinutes,
  });
}
