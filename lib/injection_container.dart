import 'package:get_it/get_it.dart';

// Task Feature
import 'features/task/data/datasources/task_local_datasource.dart';
import 'features/task/data/repositories/task_repository_impl.dart';
import 'features/task/domain/repositories/task_repository.dart';
import 'features/task/domain/usecases/create_task.dart';
import 'features/task/domain/usecases/delete_task.dart';
import 'features/task/domain/usecases/get_tasks.dart';
import 'features/task/domain/usecases/update_task.dart';
import 'features/task/domain/usecases/watch_tasks.dart';
import 'features/task/presentation/bloc/task_bloc.dart';

// TimeBlock Feature
import 'features/timeblock/data/datasources/time_block_local_datasource.dart';
import 'features/timeblock/data/repositories/time_block_repository_impl.dart';
import 'features/timeblock/domain/repositories/time_block_repository.dart';
import 'features/timeblock/domain/usecases/create_time_block.dart';
import 'features/timeblock/domain/usecases/delete_time_block.dart';
import 'features/timeblock/domain/usecases/get_time_blocks_for_day.dart';
import 'features/timeblock/domain/usecases/move_time_block.dart';
import 'features/timeblock/domain/usecases/update_time_block.dart';
import 'features/timeblock/presentation/bloc/calendar_bloc.dart';

// Planner Feature
import 'features/planner/data/datasources/daily_priority_local_datasource.dart';
import 'features/planner/data/repositories/daily_priority_repository_impl.dart';
import 'features/planner/domain/repositories/daily_priority_repository.dart';
import 'features/planner/domain/usecases/get_daily_priority.dart';
import 'features/planner/domain/usecases/remove_task_from_rank.dart';
import 'features/planner/domain/usecases/set_task_rank.dart';
import 'features/planner/domain/usecases/watch_daily_priority.dart';
import 'features/planner/presentation/bloc/planner_bloc.dart';

// Focus Feature
import 'features/focus/presentation/bloc/focus_bloc.dart';

// Settings Feature
import 'features/settings/presentation/cubit/settings_cubit.dart';

/// 전역 서비스 로케이터 인스턴스
final sl = GetIt.instance;

/// 의존성 주입 초기화
Future<void> init() async {
  //===========================================================================
  // Features - Task
  //===========================================================================
  // Data Sources
  sl.registerLazySingleton<TaskLocalDataSource>(
    () => TaskLocalDataSourceImpl(),
  );

  // Repositories
  sl.registerLazySingleton<TaskRepository>(
    () => TaskRepositoryImpl(localDataSource: sl()),
  );

  // Use Cases
  sl.registerLazySingleton(() => GetTasks(sl()));
  sl.registerLazySingleton(() => GetTasksByStatus(sl()));
  sl.registerLazySingleton(() => CreateTask(sl()));
  sl.registerLazySingleton(() => UpdateTask(sl()));
  sl.registerLazySingleton(() => UpdateTaskStatus(sl()));
  sl.registerLazySingleton(() => DeleteTask(sl()));
  sl.registerLazySingleton(() => WatchTasks(sl()));

  // BLoC
  sl.registerFactory(
    () => TaskBloc(
      watchTasks: sl(),
      createTask: sl(),
      updateTask: sl(),
      deleteTask: sl(),
      updateTaskStatus: sl(),
    ),
  );

  //===========================================================================
  // Features - TimeBlock
  //===========================================================================
  // Data Sources
  sl.registerLazySingleton<TimeBlockLocalDataSource>(
    () => TimeBlockLocalDataSourceImpl(),
  );

  // Repositories
  sl.registerLazySingleton<TimeBlockRepository>(
    () => TimeBlockRepositoryImpl(localDataSource: sl()),
  );

  // Use Cases
  sl.registerLazySingleton(() => GetTimeBlocksForDay(sl()));
  sl.registerLazySingleton(() => WatchTimeBlocksForDay(sl()));
  sl.registerLazySingleton(() => CreateTimeBlock(sl()));
  sl.registerLazySingleton(() => UpdateTimeBlock(sl()));
  sl.registerLazySingleton(() => UpdateTimeBlockStatus(sl()));
  sl.registerLazySingleton(() => DeleteTimeBlock(sl()));
  sl.registerLazySingleton(() => MoveTimeBlock(sl()));
  sl.registerLazySingleton(() => ResizeTimeBlock(sl()));

  // BLoC
  sl.registerFactory(
    () => CalendarBloc(
      watchTimeBlocksForDay: sl(),
      createTimeBlock: sl(),
      updateTimeBlock: sl(),
      updateTimeBlockStatus: sl(),
      deleteTimeBlock: sl(),
      moveTimeBlock: sl(),
      resizeTimeBlock: sl(),
    ),
  );

  //===========================================================================
  // Features - Planner
  //===========================================================================
  // Data Sources
  sl.registerLazySingleton<DailyPriorityLocalDataSource>(
    () => DailyPriorityLocalDataSourceImpl(),
  );

  // Repositories
  sl.registerLazySingleton<DailyPriorityRepository>(
    () => DailyPriorityRepositoryImpl(localDataSource: sl()),
  );

  // Use Cases
  sl.registerLazySingleton(() => GetDailyPriority(sl()));
  sl.registerLazySingleton(() => WatchDailyPriority(sl()));
  sl.registerLazySingleton(() => SetTaskRank(sl()));
  sl.registerLazySingleton(() => RemoveTaskFromRank(sl()));

  // BLoC
  sl.registerFactory(
    () => PlannerBloc(
      watchTasks: sl(),
      watchDailyPriority: sl(),
      watchTimeBlocksForDay: sl(),
      setTaskRank: sl(),
      removeTaskFromRank: sl(),
      createTask: sl(),
      createTimeBlock: sl(),
    ),
  );

  //===========================================================================
  // Features - Focus
  //===========================================================================
  // BLoC
  sl.registerFactory(() => FocusBloc());

  //===========================================================================
  // Features - Settings
  //===========================================================================
  // Cubit
  sl.registerLazySingleton(() => SettingsCubit());
}
