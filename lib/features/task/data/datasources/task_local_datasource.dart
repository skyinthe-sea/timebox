import 'dart:async';

import 'package:hive_flutter/hive_flutter.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/services/hive_service.dart';
import '../models/task_model.dart';

/// Task 로컬 데이터 소스 인터페이스
abstract class TaskLocalDataSource {
  /// 모든 Task 조회
  Future<List<TaskModel>> getTasks();

  /// 단일 Task 조회
  Future<TaskModel?> getTaskById(String id);

  /// Task 저장 (생성/수정)
  Future<TaskModel> saveTask(TaskModel task);

  /// Task 삭제
  Future<void> deleteTask(String id);

  /// Task 스트림 (실시간 업데이트)
  Stream<List<TaskModel>> watchTasks();
}

/// Task 로컬 데이터 소스 구현 (Hive)
class TaskLocalDataSourceImpl implements TaskLocalDataSource {
  Box<Map> get _box => HiveService.getTasksBox();

  @override
  Future<List<TaskModel>> getTasks() async {
    try {
      final tasks = <TaskModel>[];
      for (final key in _box.keys) {
        final data = _box.get(key);
        if (data != null) {
          tasks.add(TaskModel.fromJson(Map<String, dynamic>.from(data)));
        }
      }
      // 생성일 기준 내림차순 정렬
      tasks.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return tasks;
    } catch (e) {
      throw CacheException(message: 'Failed to get tasks: $e');
    }
  }

  @override
  Future<TaskModel?> getTaskById(String id) async {
    try {
      final data = _box.get(id);
      if (data == null) return null;
      return TaskModel.fromJson(Map<String, dynamic>.from(data));
    } catch (e) {
      throw CacheException(message: 'Failed to get task: $e');
    }
  }

  @override
  Future<TaskModel> saveTask(TaskModel task) async {
    try {
      await _box.put(task.id, task.toJson());
      return task;
    } catch (e) {
      throw CacheException(message: 'Failed to save task: $e');
    }
  }

  @override
  Future<void> deleteTask(String id) async {
    try {
      await _box.delete(id);
    } catch (e) {
      throw CacheException(message: 'Failed to delete task: $e');
    }
  }

  @override
  Stream<List<TaskModel>> watchTasks() {
    // 초기 데이터와 변경 사항을 모두 스트림으로 제공
    final controller = StreamController<List<TaskModel>>();

    // 초기 데이터 전송
    getTasks().then((tasks) {
      if (!controller.isClosed) {
        controller.add(tasks);
      }
    });

    // 변경 감지
    final subscription = _box.watch().listen((_) async {
      if (!controller.isClosed) {
        final tasks = await getTasks();
        controller.add(tasks);
      }
    });

    controller.onCancel = () {
      subscription.cancel();
    };

    return controller.stream;
  }
}
