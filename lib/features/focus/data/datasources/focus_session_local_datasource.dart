import 'dart:async';

import 'package:hive_flutter/hive_flutter.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/services/hive_service.dart';
import '../models/focus_session_model.dart';

/// FocusSession 로컬 데이터 소스 인터페이스
abstract class FocusSessionLocalDataSource {
  /// 현재 진행 중인 세션 조회
  Future<FocusSessionModel?> getCurrentSession();

  /// 단일 세션 조회
  Future<FocusSessionModel?> getSessionById(String id);

  /// 특정 날짜의 세션 목록 조회
  Future<List<FocusSessionModel>> getSessionsForDay(DateTime date);

  /// 모든 세션 조회
  Future<List<FocusSessionModel>> getAllSessions();

  /// 세션 저장 (생성/수정)
  Future<FocusSessionModel> saveSession(FocusSessionModel session);

  /// 세션 삭제
  Future<void> deleteSession(String id);

  /// 현재 세션 스트림
  Stream<FocusSessionModel?> watchCurrentSession();

  /// 날짜별 세션 스트림
  Stream<List<FocusSessionModel>> watchSessionsForDay(DateTime date);
}

/// FocusSession 로컬 데이터 소스 구현 (Hive)
class FocusSessionLocalDataSourceImpl implements FocusSessionLocalDataSource {
  Box<Map> get _box => HiveService.getFocusSessionsBox();

  @override
  Future<FocusSessionModel?> getCurrentSession() async {
    try {
      for (final key in _box.keys) {
        final data = _box.get(key);
        if (data != null) {
          final session =
              FocusSessionModel.fromJson(Map<String, dynamic>.from(data));
          // 진행 중 또는 일시정지 상태인 세션 찾기
          if (session.status == 'inProgress' || session.status == 'paused') {
            return session;
          }
        }
      }
      return null;
    } catch (e) {
      throw CacheException(message: 'Failed to get current session: $e');
    }
  }

  @override
  Future<FocusSessionModel?> getSessionById(String id) async {
    try {
      final data = _box.get(id);
      if (data == null) return null;
      return FocusSessionModel.fromJson(Map<String, dynamic>.from(data));
    } catch (e) {
      throw CacheException(message: 'Failed to get session: $e');
    }
  }

  @override
  Future<List<FocusSessionModel>> getSessionsForDay(DateTime date) async {
    try {
      final sessions = <FocusSessionModel>[];
      final targetDate = DateTime(date.year, date.month, date.day);

      for (final key in _box.keys) {
        final data = _box.get(key);
        if (data != null) {
          final session =
              FocusSessionModel.fromJson(Map<String, dynamic>.from(data));
          final sessionDate = DateTime(
            session.plannedStartTime.year,
            session.plannedStartTime.month,
            session.plannedStartTime.day,
          );
          if (sessionDate == targetDate) {
            sessions.add(session);
          }
        }
      }

      // 시작 시간 순 정렬
      sessions.sort((a, b) => a.plannedStartTime.compareTo(b.plannedStartTime));
      return sessions;
    } catch (e) {
      throw CacheException(message: 'Failed to get sessions for day: $e');
    }
  }

  @override
  Future<List<FocusSessionModel>> getAllSessions() async {
    try {
      final sessions = <FocusSessionModel>[];
      for (final key in _box.keys) {
        final data = _box.get(key);
        if (data != null) {
          sessions.add(
            FocusSessionModel.fromJson(Map<String, dynamic>.from(data)),
          );
        }
      }
      return sessions;
    } catch (e) {
      throw CacheException(message: 'Failed to get all sessions: $e');
    }
  }

  @override
  Future<FocusSessionModel> saveSession(FocusSessionModel session) async {
    try {
      await _box.put(session.id, session.toJson());
      return session;
    } catch (e) {
      throw CacheException(message: 'Failed to save session: $e');
    }
  }

  @override
  Future<void> deleteSession(String id) async {
    try {
      await _box.delete(id);
    } catch (e) {
      throw CacheException(message: 'Failed to delete session: $e');
    }
  }

  @override
  Stream<FocusSessionModel?> watchCurrentSession() {
    final controller = StreamController<FocusSessionModel?>();

    // 초기 데이터
    getCurrentSession().then((session) {
      if (!controller.isClosed) {
        controller.add(session);
      }
    });

    // 변경 감지
    final subscription = _box.watch().listen((_) async {
      if (!controller.isClosed) {
        final session = await getCurrentSession();
        controller.add(session);
      }
    });

    controller.onCancel = () {
      subscription.cancel();
    };

    return controller.stream;
  }

  @override
  Stream<List<FocusSessionModel>> watchSessionsForDay(DateTime date) {
    final controller = StreamController<List<FocusSessionModel>>();

    // 초기 데이터
    getSessionsForDay(date).then((sessions) {
      if (!controller.isClosed) {
        controller.add(sessions);
      }
    });

    // 변경 감지
    final subscription = _box.watch().listen((_) async {
      if (!controller.isClosed) {
        final sessions = await getSessionsForDay(date);
        controller.add(sessions);
      }
    });

    controller.onCancel = () {
      subscription.cancel();
    };

    return controller.stream;
  }
}
