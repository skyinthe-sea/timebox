import 'package:hive_flutter/hive_flutter.dart';

/// Hive 로컬 스토리지 서비스
///
/// Box 이름 상수 및 초기화 메서드 제공
class HiveService {
  // Box 이름 상수
  static const String tasksBox = 'tasks';
  static const String timeBlocksBox = 'time_blocks';
  static const String focusSessionsBox = 'focus_sessions';
  static const String settingsBox = 'settings';
  static const String tagsBox = 'tags';
  static const String dailyPrioritiesBox = 'daily_priorities';

  // Analytics Box
  static const String dailyStatsSummaryBox = 'daily_stats_summary';
  static const String hourlyProductivityBox = 'hourly_productivity';
  static const String periodCacheBox = 'period_cache';

  /// Hive 초기화
  ///
  /// 앱 시작 시 호출되어야 함
  static Future<void> init() async {
    await Hive.initFlutter();

    // TypeAdapter 등록은 코드 생성 후 추가
    // Hive.registerAdapter(TaskModelAdapter());
    // Hive.registerAdapter(TimeBlockModelAdapter());
    // etc.
  }

  /// 모든 Box 열기
  static Future<void> openBoxes() async {
    await Future.wait([
      Hive.openBox<Map>(tasksBox),
      Hive.openBox<Map>(timeBlocksBox),
      Hive.openBox<Map>(focusSessionsBox),
      Hive.openBox<Map>(settingsBox),
      Hive.openBox<Map>(tagsBox),
      Hive.openBox<Map>(dailyPrioritiesBox),
      Hive.openBox<Map>(dailyStatsSummaryBox),
      Hive.openBox<Map>(hourlyProductivityBox),
      Hive.openBox<Map>(periodCacheBox),
    ]);
  }

  /// 특정 Box 가져오기
  static Box<Map> getTasksBox() => Hive.box<Map>(tasksBox);
  static Box<Map> getTimeBlocksBox() => Hive.box<Map>(timeBlocksBox);
  static Box<Map> getFocusSessionsBox() => Hive.box<Map>(focusSessionsBox);
  static Box<Map> getSettingsBox() => Hive.box<Map>(settingsBox);
  static Box<Map> getTagsBox() => Hive.box<Map>(tagsBox);
  static Box<Map> getDailyPrioritiesBox() => Hive.box<Map>(dailyPrioritiesBox);
  static Box<Map> getDailyStatsSummaryBox() =>
      Hive.box<Map>(dailyStatsSummaryBox);
  static Box<Map> getHourlyProductivityBox() =>
      Hive.box<Map>(hourlyProductivityBox);
  static Box<Map> getPeriodCacheBox() => Hive.box<Map>(periodCacheBox);

  /// 모든 Box 닫기
  static Future<void> closeBoxes() async {
    await Hive.close();
  }

  /// 모든 데이터 삭제 (설정 초기화용)
  static Future<void> clearAll() async {
    await Future.wait([
      getTasksBox().clear(),
      getTimeBlocksBox().clear(),
      getFocusSessionsBox().clear(),
      getSettingsBox().clear(),
      getTagsBox().clear(),
      getDailyPrioritiesBox().clear(),
      getDailyStatsSummaryBox().clear(),
      getHourlyProductivityBox().clear(),
      getPeriodCacheBox().clear(),
    ]);
  }
}
