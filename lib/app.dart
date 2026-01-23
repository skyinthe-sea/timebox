import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'config/routes/app_router.dart';
import 'config/themes/app_theme.dart';
import 'features/focus/presentation/bloc/focus_bloc.dart';
import 'features/notification/data/datasources/notification_local_datasource.dart';
import 'features/notification/domain/repositories/notification_repository.dart';
import 'features/planner/presentation/bloc/planner_bloc.dart';
import 'features/settings/presentation/cubit/settings_cubit.dart';
import 'features/task/presentation/bloc/task_bloc.dart';
import 'features/timeblock/presentation/bloc/calendar_bloc.dart';
import 'features/timeblock/domain/repositories/time_block_repository.dart';
import 'injection_container.dart';
import 'l10n/app_localizations.dart';

/// Timebox Planner 앱의 루트 위젯
///
/// MaterialApp.router 설정:
/// - 테마 (라이트/다크 모드)
/// - 라우팅 (go_router)
/// - 다국어 (l10n)
/// - 디버그 배너 제거
class TimeboxApp extends StatefulWidget {
  const TimeboxApp({super.key});

  @override
  State<TimeboxApp> createState() => _TimeboxAppState();
}

class _TimeboxAppState extends State<TimeboxApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _onAppOpened();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _onAppOpened();
    }
  }

  /// 앱이 열릴 때 호출
  /// - 앱 오픈 기록
  /// - 일일 리마인더 스케줄링
  Future<void> _onAppOpened() async {
    final notificationDataSource = sl<NotificationLocalDataSource>();
    final notificationRepository = sl<NotificationRepository>();
    final timeBlockRepository = sl<TimeBlockRepository>();

    // 앱 오픈 기록
    await notificationDataSource.recordAppOpenToday();

    // 오늘 타임블록이 있는지 확인
    final today = DateTime.now();
    final result = await timeBlockRepository.getTimeBlocksForDay(today);
    final hasTimeBlocksToday = result.fold(
      (_) => false,
      (timeBlocks) => timeBlocks.isNotEmpty,
    );

    // 일일 리마인더 스케줄링 (오늘 계획이 있으면 알림 안 함)
    await notificationRepository.scheduleDailyReminder(
      hasTimeBlocksToday: hasTimeBlocksToday,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TaskBloc>(
          create: (_) => sl<TaskBloc>(),
        ),
        BlocProvider<CalendarBloc>(
          create: (_) => sl<CalendarBloc>(),
        ),
        BlocProvider<PlannerBloc>(
          create: (_) => sl<PlannerBloc>(),
        ),
        BlocProvider<FocusBloc>(
          create: (_) => sl<FocusBloc>(),
        ),
        BlocProvider<SettingsCubit>(
          create: (_) => sl<SettingsCubit>(),
        ),
      ],
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, settingsState) {
          return MaterialApp.router(
            title: 'Timebox Planner',
            debugShowCheckedModeBanner: false,

            // 테마 설정
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: settingsState.themeMode,

            // 라우터 설정
            routerConfig: AppRouter.router,

            // 다국어 설정
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            locale: settingsState.locale,
          );
        },
      ),
    );
  }
}
