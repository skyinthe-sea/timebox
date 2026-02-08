import 'dart:async';

import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../task/data/datasources/task_local_datasource.dart';
import '../../../task/data/models/task_model.dart';
import '../../../timeblock/data/datasources/time_block_local_datasource.dart';
import '../../../focus/data/datasources/focus_session_local_datasource.dart';
import '../../../planner/data/datasources/daily_priority_local_datasource.dart';
import '../../domain/entities/daily_stats_summary.dart';
import '../../domain/entities/hourly_productivity.dart';
import '../../domain/entities/insight.dart';
import '../../domain/entities/priority_breakdown_stats.dart';
import '../../domain/entities/productivity_stats.dart';
import '../../domain/entities/task_completion_ranking.dart';
import '../../domain/entities/task_pipeline_stats.dart';
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
      final now = DateTime.now();
      final isToday = date.year == now.year &&
          date.month == now.month &&
          date.day == now.day;

      // 과거 날짜만 캐시 사용 (오늘은 항상 실시간 계산)
      if (!isToday) {
        final cached = await analyticsDataSource.getDailyStatsSummary(date);
        if (cached != null) {
          return Right(_summaryToProductivityStats(cached.toEntity()));
        }
      }

      // 오늘이거나 캐시 미스: 실시간 계산
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
      final today = DateTime.now();
      final summaries = await analyticsDataSource.getDailyStatsSummaryRange(
        weekStart,
        weekEnd,
      );

      final stats = <ProductivityStats>[];
      var currentDate = weekStart;

      // 오늘까지만 계산 (미래 날짜 제외)
      while (!currentDate.isAfter(weekEnd) && !currentDate.isAfter(today)) {
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
      final today = DateTime.now();

      final summaries = await analyticsDataSource.getDailyStatsSummaryRange(
        start,
        end,
      );

      final stats = <ProductivityStats>[];
      var currentDate = start;

      // 오늘까지만 계산 (미래 날짜 제외)
      while (!currentDate.isAfter(end) && !currentDate.isAfter(today)) {
        final existing = summaries
            .where((s) => _isSameDate(s.date, currentDate))
            .firstOrNull;

        if (existing != null) {
          stats.add(_summaryToProductivityStats(existing.toEntity()));
        } else {
          // 캐시에 없으면 실시간 계산 (주간과 동일 방식)
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
        final timeBlocks =
            await timeBlockDataSource.getTimeBlocksForDay(currentDate);

        for (final task in tasks) {
          // 해당 Task에 연결된 TimeBlock에서 계획 시간과 실제 시간 계산
          int taskPlannedMinutes = 0;
          int taskActualMinutes = 0;
          for (final block in timeBlocks) {
            if (block.taskId == task.id) {
              taskPlannedMinutes +=
                  block.endTime.difference(block.startTime).inMinutes;
              if (block.actualStart != null && block.actualEnd != null) {
                taskActualMinutes +=
                    block.actualEnd!.difference(block.actualStart!).inMinutes;
              }
            }
          }

          // TimeBlock이 없으면 Task의 estimatedDuration을 폴백으로 사용
          final plannedMinutes = taskPlannedMinutes > 0
              ? taskPlannedMinutes
              : task.estimatedDurationMinutes;

          for (final tag in task.tags) {
            final builder = tagStats.putIfAbsent(
              tag.name,
              () => TagTimeComparisonBuilder(
                tagName: tag.name,
                colorValue: tag.colorValue,
              ),
            );
            builder.addTask(
              plannedMinutes,
              taskActualMinutes > 0 ? taskActualMinutes : null,
            );
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
      final timeBlocks = await timeBlockDataSource.getTimeBlocksForDay(date);

      // 완료 판정: TimeBlock 완료 OR Task status == 'done' (union)
      final completedByTb = timeBlocks
          .where((b) => b.status == 'completed' && b.taskId != null)
          .map((b) => b.taskId!)
          .toSet();
      final completedByTask = tasks
          .where((t) => t.status == 'done')
          .map((t) => t.id)
          .toSet();
      final completedIds = completedByTb.union(completedByTask);

      final incomplete = tasks
          .where((t) => !completedIds.contains(t.id))
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
      final rolloverCount = _countRolledOverTasks(tasks, date);
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
    // Task 통계 (archived 제외)
    final allTasks = await taskDataSource.getTasksByDate(date);
    final tasks = allTasks.where((t) => t.status != 'archived').toList();
    final totalTasks = tasks.length;

    // TimeBlock 통계 (현재 시간 이전 블록만 완료율 계산에 포함)
    final timeBlocks = await timeBlockDataSource.getTimeBlocksForDay(date);

    // 완료 판정: TimeBlock 완료 OR Task status == 'done' (union)
    final completedByTimeBlock = timeBlocks
        .where((tb) => tb.status == 'completed' && tb.taskId != null)
        .map((tb) => tb.taskId!)
        .toSet();
    final completedByTask = tasks
        .where((t) => t.status == 'done')
        .map((t) => t.id)
        .toSet();
    final completedTaskIds = completedByTimeBlock.union(completedByTask);
    // 실제로 현재 날짜의 task 중 완료된 것만 카운트
    final completedTasks = tasks.where((t) => completedTaskIds.contains(t.id)).length;
    final now = DateTime.now();
    final isToday = date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
    // 오늘이면 시작 시간이 지난 블록만, 과거 날짜면 전체
    final relevantBlocks = isToday
        ? timeBlocks.where((b) => b.startTime.isBefore(now)).toList()
        : timeBlocks;
    final totalTimeBlocks = relevantBlocks.length;
    final completedTimeBlocks =
        relevantBlocks.where((b) => b.status == 'completed').length;
    final skippedTimeBlocks =
        relevantBlocks.where((b) => b.status == 'skipped').length;

    // 계획/실제 시간 + 블록별 정확도 (상쇄 방지)
    var measuredPlannedMinutes = 0;
    var actualMinutes = 0;
    double timeAccuracySum = 0;
    int measuredBlockCount = 0;

    for (final block in timeBlocks) {
      if (block.actualStart != null && block.actualEnd != null) {
        final blockPlanned = block.endTime.difference(block.startTime).inMinutes;
        final actual = block.actualEnd!.difference(block.actualStart!).inMinutes;
        actualMinutes += actual;
        measuredPlannedMinutes += blockPlanned;
        // 블록별 정확도 계산 (상쇄 방지)
        if (blockPlanned > 0) {
          final blockAccuracy =
              (1 - (actual - blockPlanned).abs() / blockPlanned).clamp(0.0, 1.0);
          timeAccuracySum += blockAccuracy;
          measuredBlockCount++;
        }
      }
    }

    // 블록별 평균 정확도 (-1 = 데이터 없음)
    final timeAccuracyPercent = measuredBlockCount > 0
        ? (timeAccuracySum / measuredBlockCount) * 100
        : -1.0;

    // Focus 통계 (일시정지 시간 제외)
    final sessions = await focusSessionDataSource.getSessionsForDay(date);
    var focusMinutes = 0;
    for (final session in sessions) {
      if (session.actualStartTime != null && session.actualEndTime != null) {
        final duration =
            session.actualEndTime!.difference(session.actualStartTime!).inMinutes;
        var sessionPauseMinutes = 0;
        for (final pause in session.pauseRecords) {
          if (pause.resumeTime != null) {
            sessionPauseMinutes +=
                pause.resumeTime!.difference(pause.pauseTime).inMinutes;
          }
        }
        focusMinutes += duration - sessionPauseMinutes;
      }
    }

    // 실행률
    final executionRate = totalTimeBlocks > 0
        ? (completedTimeBlocks / totalTimeBlocks) * 100
        : 0.0;

    // 시간 차이 총합 (측정된 블록 기준, 캐시 경로와 동일한 의미)
    final timeDiffTotal = actualMinutes - measuredPlannedMinutes;

    // 생산성 점수 계산
    // 데이터가 전혀 없으면 0점
    if (totalTasks == 0 && totalTimeBlocks == 0) {
      return ProductivityStats(
        date: date,
        score: 0,
        completedTasks: 0,
        totalPlannedTasks: 0,
        completedTimeBlocks: 0,
        totalPlannedTimeBlocks: 0,
        executionRate: 0,
        totalPlannedTime: Duration.zero,
        totalActualTime: Duration.zero,
        focusTime: Duration(minutes: focusMinutes),
        totalTimeDifference: Duration.zero,
        timeAccuracyPercent: -1.0,
      );
    }

    // 동적 가중치: 데이터가 있는 항목만 점수에 반영
    final taskRate = totalTasks > 0 ? completedTasks / totalTasks : 0.0;
    final timeAccuracy = measuredBlockCount > 0
        ? timeAccuracySum / measuredBlockCount
        : 0.0;
    final blockRate =
        totalTimeBlocks > 0 ? completedTimeBlocks / totalTimeBlocks : 0.0;

    double weightedSum = 0;
    double totalWeight = 0;
    if (totalTasks > 0) {
      weightedSum += taskRate * 0.3;
      totalWeight += 0.3;
    }
    if (measuredBlockCount > 0) {
      weightedSum += timeAccuracy * 0.3;
      totalWeight += 0.3;
    }
    if (totalTimeBlocks > 0) {
      weightedSum += blockRate * 0.4;
      totalWeight += 0.4;
    }

    final score = totalWeight > 0
        ? ((weightedSum / totalWeight) * 100).round()
        : 0;

    return ProductivityStats(
      date: date,
      score: score.clamp(0, 100),
      completedTasks: completedTasks,
      totalPlannedTasks: totalTasks,
      completedTimeBlocks: completedTimeBlocks,
      skippedTimeBlocks: skippedTimeBlocks,
      totalPlannedTimeBlocks: totalTimeBlocks,
      executionRate: executionRate,
      totalPlannedTime: Duration(minutes: measuredPlannedMinutes),
      totalActualTime: Duration(minutes: actualMinutes),
      focusTime: Duration(minutes: focusMinutes),
      totalTimeDifference: Duration(minutes: timeDiffTotal),
      timeAccuracyPercent: timeAccuracyPercent,
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
      totalTimeDifference: summary.totalActualDuration - summary.totalPlannedDuration,
      timeAccuracyPercent: summary.timeAccuracyPercent,
    );
  }

  /// 일간 통계 저장 (캐싱)
  Future<Either<Failure, DailyStatsSummary>> saveDailyStatsSummary(
    DateTime date,
  ) async {
    try {
      final stats = await _calculateDailyStats(date);

      // TimeBlock 데이터 조회 (Top3 달성 + 측정 데이터 계산용)
      final timeBlocks = await timeBlockDataSource.getTimeBlocksForDay(date);

      // Top 3 달성 계산 (TimeBlock 완료 또는 Task 완료)
      final priority = await dailyPriorityDataSource.getDailyPriority(date);
      var top3Completed = 0;
      var top3Set = 0;
      if (priority != null) {
        // 설정된 Top 3 슬롯 수 카운트
        if (priority.rank1TaskId != null) top3Set++;
        if (priority.rank2TaskId != null) top3Set++;
        if (priority.rank3TaskId != null) top3Set++;

        // 완료 판정: TimeBlock 완료 OR Task status == 'done'
        final completedByTimeBlock = timeBlocks
            .where((tb) => tb.status == 'completed' && tb.taskId != null)
            .map((tb) => tb.taskId)
            .toSet();
        final tasks = await taskDataSource.getTasksByDate(date);
        final completedByTask = tasks
            .where((t) => t.status == 'done')
            .map((t) => t.id)
            .toSet();
        final completedTaskIds = completedByTimeBlock.union(completedByTask);

        if (priority.rank1TaskId != null &&
            completedTaskIds.contains(priority.rank1TaskId)) {
          top3Completed++;
        }
        if (priority.rank2TaskId != null &&
            completedTaskIds.contains(priority.rank2TaskId)) {
          top3Completed++;
        }
        if (priority.rank3TaskId != null &&
            completedTaskIds.contains(priority.rank3TaskId)) {
          top3Completed++;
        }
      }

      // 실제 데이터가 있는 블록의 계획/실제 시간 + 블록별 정확도 계산
      var measuredPlannedMinutes = 0;
      var measuredActualMinutes = 0;
      double blockAccuracySum = 0;
      int measuredBlockCount = 0;
      for (final block in timeBlocks) {
        if (block.actualStart != null && block.actualEnd != null) {
          final blockPlanned =
              block.endTime.difference(block.startTime).inMinutes;
          final blockActual =
              block.actualEnd!.difference(block.actualStart!).inMinutes;
          measuredPlannedMinutes += blockPlanned;
          measuredActualMinutes += blockActual;
          if (blockPlanned > 0) {
            final accuracy =
                (1 - (blockActual - blockPlanned).abs() / blockPlanned)
                    .clamp(0.0, 1.0);
            blockAccuracySum += accuracy;
            measuredBlockCount++;
          }
        }
      }
      final savedTimeAccuracyPercent = measuredBlockCount > 0
          ? (blockAccuracySum / measuredBlockCount) * 100
          : -1.0;

      // 이월 Task 수 (확장 정의: rolloverCount > 0 OR createdAt < date)
      final tasks = await taskDataSource.getTasksByDate(date);
      final rolledOver = _countRolledOverTasks(tasks, date);

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
        totalPlannedDuration: Duration(minutes: measuredPlannedMinutes),
        totalActualDuration: Duration(minutes: measuredActualMinutes),
        focusSessionCount: sessions.length,
        totalFocusDuration: stats.focusTime,
        totalPauseDuration: Duration(minutes: pauseMinutes),
        top3SetCount: top3Set,
        top3CompletedCount: top3Completed,
        timeAccuracyPercent: savedTimeAccuracyPercent,
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
              sampleDays: dayCount > 0 ? ((dayCount + 6) ~/ 7) : 0,
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
          periodKey: 'yesterday',
        ));
      }

      // 2. 이월 경고 (확장 정의: rolloverCount >= 3 OR 3일 이상 방치)
      final tasks = await taskDataSource.getTasksByDate(date);
      final normalizedDate = DateTime(date.year, date.month, date.day);
      final highRollover = tasks.where((t) {
        if (t.rolloverCount >= 3) return true;
        final createdDate = DateTime(
          t.createdAt.year,
          t.createdAt.month,
          t.createdAt.day,
        );
        return normalizedDate.difference(createdDate).inDays >= 3;
      }).length;
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
            periodKey: 'today',
          ));
        }
      }

      return Right(insights);
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  /// 이월 Task 수 계산 (확장 정의)
  ///
  /// 조건 (OR):
  /// 1. rolloverCount > 0 (명시적 이월 버튼 사용)
  /// 2. createdAt 날짜 < date (이전 날짜에 생성된 Task가 해당 날짜에 존재)
  int _countRolledOverTasks(List<TaskModel> tasks, DateTime date) {
    final normalizedDate = DateTime(date.year, date.month, date.day);
    return tasks.where((t) {
      if (t.rolloverCount > 0) return true;
      final createdDate = DateTime(
        t.createdAt.year,
        t.createdAt.month,
        t.createdAt.day,
      );
      return createdDate.isBefore(normalizedDate);
    }).length;
  }

  bool _isSameDate(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  @override
  Future<Either<Failure, DailyStatsSummary>> getDailyStatsSummary(
    DateTime date,
  ) async {
    try {
      final now = DateTime.now();
      final isToday = date.year == now.year &&
          date.month == now.month &&
          date.day == now.day;

      // 오늘은 항상 재계산 (데이터가 실시간으로 변경됨)
      if (isToday) {
        return saveDailyStatsSummary(date);
      }

      // 과거 날짜: 캐시 확인
      final cached = await analyticsDataSource.getDailyStatsSummary(date);
      if (cached != null) {
        return Right(cached.toEntity());
      }

      // 캐시가 없으면 새로 계산하고 저장
      return saveDailyStatsSummary(date);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, TaskPipelineStats>> getTaskPipelineStats(
    DateTime start,
    DateTime end,
  ) async {
    try {
      var totalTasks = 0;
      var completedTasks = 0;
      var rolledOverTasks = 0;
      var scheduledTasks = 0;

      var currentDate = start;
      while (!currentDate.isAfter(end)) {
        final tasks = await taskDataSource.getTasksByDate(currentDate);
        totalTasks += tasks.length;
        rolledOverTasks += _countRolledOverTasks(tasks, currentDate);

        final timeBlocks =
            await timeBlockDataSource.getTimeBlocksForDay(currentDate);

        // 완료 판정: TimeBlock 완료 OR Task status == 'done' (union)
        final completedByTb = timeBlocks
            .where((b) => b.status == 'completed' && b.taskId != null)
            .map((b) => b.taskId!)
            .toSet();
        final completedByTask = tasks
            .where((t) => t.status == 'done')
            .map((t) => t.id)
            .toSet();
        final completedIds = completedByTb.union(completedByTask);
        completedTasks += tasks.where((t) => completedIds.contains(t.id)).length;

        // 해당 날짜의 TimeBlock에 연결된 Task ID 집합
        final scheduledIdsForDay = timeBlocks
            .where((b) => b.taskId != null)
            .map((b) => b.taskId!)
            .toSet();
        // 해당 날짜의 Task 중 스케줄된 Task 수 (날짜별 카운트)
        scheduledTasks +=
            tasks.where((t) => scheduledIdsForDay.contains(t.id)).length;

        currentDate = currentDate.add(const Duration(days: 1));
      }

      return Right(TaskPipelineStats(
        totalTasks: totalTasks,
        scheduledTasks: scheduledTasks,
        completedTasks: completedTasks,
        rolledOverTasks: rolledOverTasks,
      ));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, PriorityBreakdownStats>> getPriorityBreakdownStats(
    DateTime start,
    DateTime end,
  ) async {
    try {
      int highTotal = 0, highCompleted = 0;
      int mediumTotal = 0, mediumCompleted = 0;
      int lowTotal = 0, lowCompleted = 0;

      var currentDate = start;
      while (!currentDate.isAfter(end)) {
        final tasks = await taskDataSource.getTasksByDate(currentDate);
        final timeBlocks =
            await timeBlockDataSource.getTimeBlocksForDay(currentDate);

        // 완료 판정: TimeBlock 완료 OR Task status == 'done' (union)
        final completedByTb = timeBlocks
            .where((b) => b.status == 'completed' && b.taskId != null)
            .map((b) => b.taskId!)
            .toSet();
        final completedByTask = tasks
            .where((t) => t.status == 'done')
            .map((t) => t.id)
            .toSet();
        final completedIds = completedByTb.union(completedByTask);

        for (final task in tasks) {
          final isDone = completedIds.contains(task.id);
          switch (task.priority) {
            case 'high':
              highTotal++;
              if (isDone) highCompleted++;
            case 'medium':
              mediumTotal++;
              if (isDone) mediumCompleted++;
            case 'low':
              lowTotal++;
              if (isDone) lowCompleted++;
            default:
              mediumTotal++;
              if (isDone) mediumCompleted++;
          }
        }
        currentDate = currentDate.add(const Duration(days: 1));
      }

      return Right(PriorityBreakdownStats(
        high: PriorityStat(total: highTotal, completed: highCompleted),
        medium: PriorityStat(total: mediumTotal, completed: mediumCompleted),
        low: PriorityStat(total: lowTotal, completed: lowCompleted),
      ));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }
  @override
  Future<Either<Failure, ({List<TaskCompletionRanking> topSuccess, List<TaskCompletionRanking> topFailure})>> getTaskCompletionRankings(
    DateTime start,
    DateTime end,
  ) async {
    try {
      // 타임블록 기반 랭킹: 타임블록에 배정된 태스크만 대상
      // 카운트 단위 = 타임블록 (완료/실패가 확정된 것만)
      final groups = <String, _RankingData>{};
      var currentDate = start;
      while (!currentDate.isAfter(end)) {
        final tasks = await taskDataSource.getTasksByDate(currentDate);
        final timeBlocks =
            await timeBlockDataSource.getTimeBlocksForDay(currentDate);

        // Task ID → Task 맵 (빠른 조회용)
        final taskMap = {for (final t in tasks) t.id: t};

        for (final block in timeBlocks) {
          if (block.taskId == null) continue;

          // 미결정 상태 제외 (pending, inProgress)
          if (block.status == 'pending' || block.status == 'inProgress') {
            continue;
          }

          final task = taskMap[block.taskId];
          if (task == null) continue;

          final normalized = task.title.toLowerCase().trim();
          final data = groups.putIfAbsent(
            normalized,
            () => _RankingData(originalTitle: task.title),
          );
          data.total++;
          if (block.status == 'completed') {
            data.completed++;
          }
        }
        currentDate = currentDate.add(const Duration(days: 1));
      }

      final qualified = groups.values.where((d) => d.total >= 1).toList();

      // Top 5 성공: 완료율 높은 순 (동률 시 총 건수 많은 순)
      final successList = List<_RankingData>.from(qualified)
        ..sort((a, b) {
          final rateCompare = b.completionRate.compareTo(a.completionRate);
          if (rateCompare != 0) return rateCompare;
          return b.total.compareTo(a.total);
        });
      final topSuccessData = successList.take(5).toList();
      final topSuccess = topSuccessData.map((d) => TaskCompletionRanking(
            title: d.originalTitle,
            totalCount: d.total,
            completedCount: d.completed,
            completionRate: d.completionRate,
          )).toList();

      // Top 5 실패: 완료율 낮은 순, 100% 완료 및 성공 목록 항목 제외
      final topSuccessSet = topSuccessData.toSet();
      final failureCandidates = qualified
          .where((d) => d.completionRate < 1.0 && !topSuccessSet.contains(d))
          .toList()
        ..sort((a, b) {
          final rateCompare = a.completionRate.compareTo(b.completionRate);
          if (rateCompare != 0) return rateCompare;
          return b.total.compareTo(a.total);
        });
      final topFailure = failureCandidates.take(5).map((d) => TaskCompletionRanking(
            title: d.originalTitle,
            totalCount: d.total,
            completedCount: d.completed,
            completionRate: d.completionRate,
          )).toList();

      return Right((topSuccess: topSuccess, topFailure: topFailure));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<DailyStatsSummary>>> getDailyStatsSummaries(
    DateTime start,
    DateTime end,
  ) async {
    try {
      final summaries = <DailyStatsSummary>[];
      var currentDate = start;

      while (!currentDate.isAfter(end)) {
        // 캐시된 데이터 확인
        final cached = await analyticsDataSource.getDailyStatsSummary(currentDate);
        if (cached != null) {
          summaries.add(cached.toEntity());
        } else {
          // 캐시가 없으면 새로 계산
          final result = await saveDailyStatsSummary(currentDate);
          result.fold(
            (_) {},
            (summary) => summaries.add(summary),
          );
        }
        currentDate = currentDate.add(const Duration(days: 1));
      }

      return Right(summaries);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }
}

class _RankingData {
  final String originalTitle;
  int total = 0;
  int completed = 0;

  _RankingData({required this.originalTitle});

  double get completionRate => total > 0 ? completed / total : 0.0;
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
    _totalActualMinutes += actualMinutes ?? 0;
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
