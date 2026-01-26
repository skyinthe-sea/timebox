import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../l10n/app_localizations.dart';
import '../bloc/planner_bloc.dart';
import '../widgets/brain_dump_view.dart';
import '../widgets/top_three_section.dart';

/// 플래너 페이지
///
/// 메인 플래너 화면
/// - 상단: Top 3 섹션
/// - 하단: 브레인덤프
///
/// 타임라인은 별도 CalendarPage로 분리됨
class PlannerPage extends StatefulWidget {
  const PlannerPage({super.key});

  @override
  State<PlannerPage> createState() => _PlannerPageState();
}

class _PlannerPageState extends State<PlannerPage> {
  @override
  void initState() {
    super.initState();

    // 초기화
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PlannerBloc>().add(InitializePlanner(DateTime.now()));
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return BlocBuilder<PlannerBloc, PlannerState>(
      builder: (context, state) {
        return Column(
          children: [
            // 날짜 헤더
            _DateHeader(
              date: state.selectedDate,
              isToday: state.isToday,
              onPrevious: () => _changeDate(-1),
              onNext: () => _changeDate(1),
              onToday: () =>
                  context.read<PlannerBloc>().add(const PlannerGoToToday()),
              onDatePick: () => _pickDate(context, state.selectedDate),
            ),

            // Top 3 섹션
            const TopThreeSection(),

            // 브레인덤프 섹션 헤더
            _SectionHeader(
              icon: Icons.lightbulb_outline_rounded,
              title: l10n?.brainDump ?? 'Brain Dump',
            ),

            // 브레인덤프
            const Expanded(
              child: BrainDumpView(),
            ),
          ],
        );
      },
    );
  }

  void _changeDate(int days) {
    final bloc = context.read<PlannerBloc>();
    final newDate = bloc.state.selectedDate.add(Duration(days: days));
    bloc.add(PlannerDateChanged(newDate));
  }

  Future<void> _pickDate(BuildContext context, DateTime currentDate) async {
    final bloc = context.read<PlannerBloc>();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (pickedDate != null && mounted) {
      bloc.add(PlannerDateChanged(pickedDate));
    }
  }
}

class _DateHeader extends StatelessWidget {
  final DateTime date;
  final bool isToday;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final VoidCallback onToday;
  final VoidCallback onDatePick;

  const _DateHeader({
    required this.date,
    required this.isToday,
    required this.onPrevious,
    required this.onNext,
    required this.onToday,
    required this.onDatePick,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    final dateFormat = DateFormat.yMMMd();
    final weekdayFormat = DateFormat.EEEE();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      height: 40,
      child: Row(
        children: [
          // 이전 날짜
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: onPrevious,
            tooltip: 'Previous day',
          ),

          // 날짜 표시
          Expanded(
            child: GestureDetector(
              onTap: onDatePick,
              child: Column(
                children: [
                  Text(
                    isToday
                        ? l10n?.today ?? 'Today'
                        : weekdayFormat.format(date),
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isToday
                          ? theme.colorScheme.primary
                          : theme.colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    dateFormat.format(date),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.outline,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 오늘 버튼
          if (!isToday)
            TextButton.icon(
              onPressed: onToday,
              icon: const Icon(Icons.today, size: 18),
              label: Text(l10n?.today ?? 'Today'),
              style: TextButton.styleFrom(
                visualDensity: VisualDensity.compact,
              ),
            ),

          // 다음 날짜
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: onNext,
            tooltip: 'Next day',
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final IconData icon;
  final String title;

  const _SectionHeader({
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
            color: theme.colorScheme.primary,
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
