import 'dart:async';

import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../task/data/datasources/task_local_datasource.dart';
import '../../../timeblock/data/datasources/time_block_local_datasource.dart';
import '../../../focus/data/datasources/focus_session_local_datasource.dart';
import '../../../planner/data/datasources/daily_priority_local_datasource.dart';
import '../../domain/entities/daily_stats_summary.dart';
import '../../domain/entities/hourly_productivity.dart';
import '../../domain/entities/insight.dart';
import '../../domain/entities/productivity_stats.dart';
import '../../domain/entities/time_comparison.dart';
import '../../domain/repositories/analytics_repository.dart';
import '../datasources/analytics_local_datasource.dart';
import '../models/daily_stats_summary_model.dart';

/// Analytics Repository 구현
///
/// 여러 DataSource를 조합하여 통계 데이터 계산
class AnalyticsRepositoryImpl implements AnalyticsRepository {
  final AnalyticsLocalDataSource analyticsDataSource;
  final TaskLocalDataSource taskDataSource;
  final TimeBlockLocalDataSource timeBlockDataSource;
  final FocusSessionLocalDataSource focusSessionDataSource;
  final DailyPriorityLocalDataSource dailyPriorityDataSource;

  AnalyticsRepositoryImpl({
    required this.analyticsDataSource,
    required this.taskDataSource,
    required this.timeBlockDataSource,
    required this.focusSessionDataSource,
    required this.dailyPriorityDataSource,
  });

  @override
  Future<Either<Failure, ProductivityStats>> getDailyStats(DateTime date) async {
    try {
      // 먼저 캐시된 통계 확인
      final cached = await analyticsDataSource.getDailyStatsSummary(date);
      if (cached != null) {
        return Right(_summaryToProductivityStats(cached.toEntity()));
      }

      // 캐시가 없으면 실시간 계산
      final stats = await _calculateDailyStats(date);
      return Right(stats);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProductivityStats>>> getWeeklyStats(
    DateTime weekStart,
  ) async {
    try {
      final weekEnd = weekStart.add(const Duration(days: 6));
      final summaries = await analyticsDataSource.getDailyStatsSummaryRange(
        weekStart,
        weekEnd,
      );

      final stats = <ProductivityStats>[];
      var currentDate = weekStart;

      while (!currentDate.isAfter(weekEnd)) {
        final existing = summaries
            .where((s) => _isSameDate(s.date, currentDate))
            .firstOrNull;

        if (existing != null) {
          stats.add(_summaryToProductivityStats(existing.toEntity()));
        } else {
          // 데이터가 없으면 실시간 계산
          final calculated = await _calculateDailyStats(currentDate);
          stats.add(calculated);
        }
        currentDate = currentDate.add(const Duration(days: 1));
      }

      return Right(stats);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProductivityStats>>> getMonthlyStats(
    int year,
    int month,
  ) async {
    try {
      final start = DateTime(year, month, 1);
      final end = DateTime(year, month + 1, 0); // 해당 월의 마지막 날

      final summaries = await analyticsDataSource.getDailyStatsSummaryRange(
        start,
        end,
      );

      final stats = summaries
          .map((s) => _summaryToProductivityStats(s.toEntity()))
          .toList();

      return Right(stats);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> calculateProductivityScore(DateTime date) async {
    try {
      final stats = await _calculateDailyStats(date);
      return Right(stats.score);
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TimeComparison>>> getTimeComparisons(
    DateTime start,
    DateTime end,
  ) async {
    try {
      final comparisons = <TimeComparison>[];
      var currentDate = start;

      while (!currentDate.isAfter(end)) {
        final timeBlocks =
            await timeBlockDataSource.getTimeBlocksForDay(currentDate);

        for (final block in timeBlocks) {
          if (block.actualStart != null && block.actualEnd != null) {
            final planned = block.endTime.difference(block.startTime);
            final actual = block.actualEnd!.difference(block.actualStart!);

            comparisons.add(TimeComparison(
              id: block.id,
              title: block.title ?? 'TimeBlock',
              plannedDuration: planned,
              actualDuration: actual,
              date: currentDate,
              tag: null, // TODO: Task에서 태그 가져오기
            ));
          }
        }
        currentDate = currentDate.add(const Duration(days: 1));
      }

      return Right(comparisons);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TagTimeComparison>>> getTagStatistics(
    DateTime start,
    DateTime end,
  ) async {
    try {
      final tagStats = <String, TagTimeComparisonBuilder>{};
      var currentDate = start;

      while (!currentDate.isAfter(end)) {
        final tasks = await taskDataSource.getTasksByDate(currentDate);

        for (final task in tasks) {
          for (final tag in task.tags) {
            final builder = tagStats.putIfAbsent(
              tag.name,
              () => TagTimeComparisonBuilder(
                tagName: tag.name,
                colorValue: tag.colorValue,
              ),
            );
            builder.addTask(task.estimatedDurationMinutes);
          }
        }
        currentDate = currentDate.add(const Duration(days: 1));
      }

      final result = tagStats.values.map((b) => b.build()).toList();
      return Right(result);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getIncompleteTasks(DateTime date) async {
    try {
      final tasks = await taskDataSource.getTasksByDate(date);
      final incomplete = tasks
          .where((t) => t.status != 'done')
          .map((t) => t.id)
          .toList();
      return Right(incomplete);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> getRolloverCount(DateTime date) async {
    try {
      final tasks = await taskDataSource.getTasksByDate(date);
      final rolloverCount = tasks.where((t) => t.rolloverCount > 0).length;
      return Right(rolloverCount);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Duration>> getTotalFocusTime(
    DateTime start,
    DateTime end,
  ) async {
    try {
      var totalMinutes = 0;
      var currentDate = start;

      while (!currentDate.isAfter(end)) {
        final sessions =
            await focusSessionDataSource.getSessionsForDay(currentDate);

        for (final session in sessions) {
          if (session.actualStartTime != null &&
              session.actualEndTime != null) {
            final duration =
                session.actualEndTime!.difference(session.actualStartTime!);
            // 일시정지 시간 제외
            var pauseMinutes = 0;
            for (final pause in session.pauseRecords) {
              if (pause.resumeTime != null) {
                pauseMinutes +=
                    pause.resumeTime!.difference(pause.pauseTime).inMinutes;
              }
            }
            totalMinutes += duration.inMinutes - pauseMinutes;
          }
        }
        currentDate = currentDate.add(const Duration(days: 1));
      }

      return Right(Duration(minutes: totalMinutes));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> exportToCsv(
    DateTime start,
    DateTime end,
  ) async {
    // TODO: CSV 내보내기 구현
    return const Right('');
  }

  @override
  Stream<Either<Failure, ProductivityStats>> watchDailyStats(DateTime date) {
    final controller = StreamController<Either<Failure, ProductivityStats>>();

    // 초기 데이터
    getDailyStats(date).then((result) {
      if (!controller.isClosed) {
        controller.add(result);
      }
    });

    // TODO: 실시간 업데이트 구현 (각 DataSource의 watch 메서드 조합)

    return controller.stream;
  }

  /// 일간 통계 실시간 계산
  Future<ProductivityStats> _calculateDailyStats(DateTime date) async {
    // Task 통계
    final tasks = await taskDataSource.getTasksByDate(date);
    final totalTasks = tasks.length;
    final completedTasks = tasks.where((t) => t.status == 'done').length;

    // TimeBlock 통계
    final timeBlocks = await timeBlockDataSource.getTimeBlocksForDay(date);
    final totalTimeBlocks = timeBlocks.length;
    final completedTimeBlocks =
        timeBlocks.where((b) => b.status == 'completed').length;

    // 계획/실제 시간
    var plannedMinutes = 0;
    var actualMinutes = 0;
    var timeDiffSum = 0;
    var timeDiffCount = 0;

    for (final block in timeBlocks) {
      plannedMinutes += block.endTime.difference(block.startTime).inMinutes;
      if (block.actualStart != null && block.actualEnd != null) {
        final actual = block.actualEnd!.difference(block.actualStart!).inMinutes;
        actualMinutes += actual;
        timeDiffSum +=
            actual - block.endTime.difference(block.startTime).inMinutes;
        timeDiffCount++;
      }
    }

    // Focus 통계
    final sessions = await focusSessionDataSource.getSessionsForDay(date);
    var focusMinutes = 0;
    for (final session in sessions) {
      if (session.actualStartTime != null && session.actualEndTime != null) {
        focusMinutes +=
            session.actualEndTime!.difference(session.actualStartTime!).inMinutes;
      }
    }

    // 실행률
    final executionRate = totalTimeBlocks > 0
        ? (completedTimeBlocks / totalTimeBlocks) * 100
        : 100.0;

    // 평균 시간 오차
    final avgTimeDiff = timeDiffCount > 0 ? timeDiffSum ~/ timeDiffCount : 0;

    // 생산성 점수 계산
    final taskRate = totalTasks > 0 ? completedTasks / totalTasks : 1.0;
    final timeAccuracy = plannedMinutes > 0
        ? (1 - (avgTimeDiff.abs() / plannedMinutes)).clamp(0.0, 1.0)
        : 1.0;
    final blockRate =
        totalTimeBlocks > 0 ? completedTimeBlocks / totalTimeBlocks : 1.0;

    final score =
        ((taskRate * 0.3 + timeAccuracy * 0.3 + blockRate * 0.4) * 100).round();

    return ProductivityStats(
      date: date,
      score: score.clamp(0, 100),
      completedTasks: completedTasks,
      totalPlannedTasks: totalTasks,
      completedTimeBlocks: completedTimeBlocks,
      totalPlannedTimeBlocks: totalTimeBlocks,
      executionRate: executionRate,
      totalPlannedTime: Duration(minutes: plannedMinutes),
      totalActualTime: Duration(minutes: actualMinutes),
      focusTime: Duration(minutes: focusMinutes),
      averageTimeDifference: Duration(minutes: avgTimeDiff),
    );
  }

  /// DailyStatsSummary를 ProductivityStats로 변환
  ProductivityStats _summaryToProductivityStats(DailyStatsSummary summary) {
    return ProductivityStats(
      date: summary.date,
      score: summary.productivityScore,
      completedTasks: summary.completedTasks,
      totalPlannedTasks: summary.totalPlannedTasks,
      completedTimeBlocks: summary.completedTimeBlocks,
      totalPlannedTimeBlocks: summary.totalTimeBlocks,
      executionRate: summary.timeBlockCompletionRate,
      totalPlannedTime: summary.totalPlannedDuration,
      totalActualTime: summary.totalActualDuration,
      focusTime: summary.totalFocusDuration,
      averageTimeDifference: summary.totalActualDuration - summary.totalPlannedDuration,
    );
  }

  /// 일간 통계 저장 (캐싱)
  Future<Either<Failure, DailyStatsSummary>> saveDailyStatsSummary(
    DateTime date,
  ) async {
    try {
      final stats = await _calculateDailyStats(date);

      // Top 3 달성 계산
      final priority = await dailyPriorityDataSource.getDailyPriority(date);
      var top3Completed = 0;
      if (priority != null) {
        final tasks = await taskDataSource.getTasksByDate(date);
        final taskMap = {for (final t in tasks) t.id: t};

        if (priority.rank1TaskId != null &&
            taskMap[priority.rank1TaskId]?.status == 'done') {
          top3Completed++;
        }
        if (priority.rank2TaskId != null &&
            taskMap[priority.rank2TaskId]?.status == 'done') {
          top3Completed++;
        }
        if (priority.rank3TaskId != null &&
            taskMap[priority.rank3TaskId]?.status == 'done') {
          top3Completed++;
        }
      }

      // 이월 Task 수
      final tasks = await taskDataSource.getTasksByDate(date);
      final rolledOver = tasks.where((t) => t.rolloverCount > 0).length;

      // Focus 일시정지 시간
      final sessions = await focusSessionDataSource.getSessionsForDay(date);
      var pauseMinutes = 0;
      for (final session in sessions) {
        for (final pause in session.pauseRecords) {
          if (pause.resumeTime != null) {
            pauseMinutes +=
                pause.resumeTime!.difference(pause.pauseTime).inMinutes;
          }
        }
      }

      final summary = DailyStatsSummary(
        id: 'stats_${date.toIso8601String()}',
        date: DateTime(date.year, date.month, date.day),
        totalPlannedTasks: stats.totalPlannedTasks,
        completedTasks: stats.completedTasks,
        rolledOverTasks: rolledOver,
        totalTimeBlocks: stats.totalPlannedTimeBlocks,
        completedTimeBlocks: stats.completedTimeBlocks,
        totalPlannedDuration: stats.totalPlannedTime,
        totalActualDuration: stats.totalActualTime,
        focusSessionCount: sessions.length,
        totalFocusDuration: stats.focusTime,
        totalPauseDuration: Duration(minutes: pauseMinutes),
        top3CompletedCount: top3Completed,
        productivityScore: stats.score,
        calculatedAt: DateTime.now(),
      );

      final model = DailyStatsSummaryModel.fromEntity(summary);
      await analyticsDataSource.saveDailyStatsSummary(model);

      return Right(summary);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  /// 시간대별 생산성 데이터 조회 (히트맵용)
  Future<Either<Failure, ProductivityHeatmapData>> getHourlyProductivity(
    DateTime start,
    DateTime end,
  ) async {
    try {
      // 7x24 그리드 초기화
      final grid = List.generate(
        7,
        (d) => List.generate(24, (h) => _HourlyData()),
      );

      var currentDate = start;
      var dayCount = 0;

      while (!currentDate.isAfter(end)) {
        dayCount++;
        final dayOfWeek = currentDate.weekday; // 1-7

        final sessions =
            await focusSessionDataSource.getSessionsForDay(currentDate);

        for (final session in sessions) {
          if (session.actualStartTime != null) {
            final hour = session.actualStartTime!.hour;
            final data = grid[dayOfWeek - 1][hour];
            data.sessionCount++;

            if (session.actualEndTime != null) {
              data.focusMinutes += session.actualEndTime!
                  .difference(session.actualStartTime!)
                  .inMinutes;
            }

            if (session.status == 'completed') {
              data.completedCount++;
            }
            data.totalCount++;
          }
        }

        currentDate = currentDate.add(const Duration(days: 1));
      }

      // HourlyProductivity 객체로 변환
      final result = List.generate(
        7,
        (d) => List.generate(
          24,
          (h) {
            final data = grid[d][h];
            return HourlyProductivity(
              hour: h,
              dayOfWeek: d + 1,
              sessionCount: data.sessionCount,
              totalFocusDuration: Duration(minutes: data.focusMinutes),
              completionRate: data.totalCount > 0
                  ? (data.completedCount / data.totalCount) * 100
                  : 0.0,
              sampleDays: dayCount ~/ 7,
            );
          },
        ),
      );

      return Right(ProductivityHeatmapData(
        grid: result,
        startDate: start,
        endDate: end,
      ));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  /// 인사이트 생성
  Future<Either<Failure, List<Insight>>> generateInsights(DateTime date) async {
    try {
      final insights = <Insight>[];
      final now = DateTime.now();

      // 1. 어제 대비 생산성 변화
      final todayStats = await _calculateDailyStats(date);
      final yesterday = date.subtract(const Duration(days: 1));
      final yesterdayStats = await _calculateDailyStats(yesterday);

      final scoreDiff = todayStats.score - yesterdayStats.score;
      if (scoreDiff.abs() >= 5) {
        insights.add(Insight.productivityChange(
          id: 'insight_${now.millisecondsSinceEpoch}_1',
          scoreDiff: scoreDiff,
          periodText: '어제',
        ));
      }

      // 2. 이월 경고
      final tasks = await taskDataSource.getTasksByDate(date);
      final highRollover = tasks.where((t) => t.rolloverCount >= 3).length;
      if (highRollover > 0) {
        insights.add(Insight.rolloverWarning(
          id: 'insight_${now.millisecondsSinceEpoch}_2',
          rolloverCount: 3,
          taskCount: highRollover,
        ));
      }

      // 3. 연속 달성 스트릭
      var streakDays = 0;
      var checkDate = date;
      while (true) {
        final stats = await _calculateDailyStats(checkDate);
        if (stats.score >= 70) {
          streakDays++;
          checkDate = checkDate.subtract(const Duration(days: 1));
        } else {
          break;
        }
        if (streakDays >= 30) break; // 최대 30일까지만 체크
      }
      if (streakDays >= 3) {
        insights.add(Insight.streak(
          id: 'insight_${now.millisecondsSinceEpoch}_3',
          days: streakDays,
        ));
      }

      // 4. 시간 절약
      if (todayStats.totalPlannedTime.inMinutes > 0) {
        final savedMinutes = todayStats.totalPlannedTime.inMinutes -
            todayStats.totalActualTime.inMinutes;
        if (savedMinutes >= 15) {
          insights.add(Insight.timeSaved(
            id: 'insight_${now.millisecondsSinceEpoch}_4',
            minutesSaved: savedMinutes,
            periodText: '오늘',
          ));
        }
      }

      return Right(insights);
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  bool _isSameDate(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}

/// 태그 통계 빌더 헬퍼
class TagTimeComparisonBuilder {
  final String tagName;
  final int colorValue;
  int _taskCount = 0;
  int _totalPlannedMinutes = 0;
  int _totalActualMinutes = 0;

  TagTimeComparisonBuilder({
    required this.tagName,
    required this.colorValue,
  });

  void addTask(int plannedMinutes, [int? actualMinutes]) {
    _taskCount++;
    _totalPlannedMinutes += plannedMinutes;
    _totalActualMinutes += actualMinutes ?? plannedMinutes;
  }

  TagTimeComparison build() {
    return TagTimeComparison(
      tagName: tagName,
      colorValue: colorValue,
      totalPlannedTime: Duration(minutes: _totalPlannedMinutes),
      totalActualTime: Duration(minutes: _totalActualMinutes),
      taskCount: _taskCount,
    );
  }
}

/// 시간대별 데이터 빌더 헬퍼
class _HourlyData {
  int sessionCount = 0;
  int focusMinutes = 0;
  int completedCount = 0;
  int totalCount = 0;
}
