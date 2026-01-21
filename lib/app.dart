import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'config/routes/app_router.dart';
import 'config/themes/app_theme.dart';
import 'features/focus/presentation/bloc/focus_bloc.dart';
import 'features/planner/presentation/bloc/planner_bloc.dart';
import 'features/settings/presentation/cubit/settings_cubit.dart';
import 'features/task/presentation/bloc/task_bloc.dart';
import 'features/timeblock/presentation/bloc/calendar_bloc.dart';
import 'injection_container.dart';
import 'l10n/app_localizations.dart';

/// Timebox Planner 앱의 루트 위젯
///
/// MaterialApp.router 설정:
/// - 테마 (라이트/다크 모드)
/// - 라우팅 (go_router)
/// - 다국어 (l10n)
/// - 디버그 배너 제거
class TimeboxApp extends StatelessWidget {
  const TimeboxApp({super.key});

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
