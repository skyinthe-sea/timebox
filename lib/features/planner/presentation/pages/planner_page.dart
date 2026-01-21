import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../l10n/app_localizations.dart';
import '../bloc/planner_bloc.dart';
import '../widgets/brain_dump_view.dart';
import '../widgets/timeline_drop_zone.dart';
import '../widgets/top_three_section.dart';

/// 플래너 페이지
///
/// 메인 플래너 화면
/// - 상단: Top 3 섹션
/// - 하단: 브레인덤프 ↔ 타임라인 스와이프
class PlannerPage extends StatefulWidget {
  const PlannerPage({super.key});

  @override
  State<PlannerPage> createState() => _PlannerPageState();
}

class _PlannerPageState extends State<PlannerPage> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    // 초기화
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PlannerBloc>().add(InitializePlanner(DateTime.now()));
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return BlocConsumer<PlannerBloc, PlannerState>(
      listener: (context, state) {
        // 페이지 인덱스 동기화
        if (_pageController.hasClients &&
            _pageController.page?.round() != state.pageIndex) {
          _pageController.animateToPage(
            state.pageIndex,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: Column(
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

              // PageView (브레인덤프 ↔ 타임라인)
              Expanded(
                child: Column(
                  children: [
                    // 페이지 콘텐츠
                    Expanded(
                      child: PageView(
                        controller: _pageController,
                        onPageChanged: (index) {
                          context
                              .read<PlannerBloc>()
                              .add(PageIndexChanged(index));
                        },
                        children: [
                          // 브레인덤프
                          const BrainDumpView(),

                          // 타임라인
                          TimelineDropZone(
                            date: state.selectedDate,
                            timeBlocks: state.timeBlocks,
                            startHour: 6, // TODO: Settings에서 가져오기
                            endHour: 24, // TODO: Settings에서 가져오기
                          ),
                        ],
                      ),
                    ),

                    // 페이지 인디케이터
                    _PageIndicator(
                      currentIndex: state.pageIndex,
                      pageController: _pageController,
                      l10n: l10n,
                    ),
                  ],
                ),
              ),
            ],
          ),
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
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
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

class _PageIndicator extends StatelessWidget {
  final int currentIndex;
  final PageController pageController;
  final AppLocalizations? l10n;

  const _PageIndicator({
    required this.currentIndex,
    required this.pageController,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildTab(
            context,
            index: 0,
            icon: Icons.lightbulb_outline_rounded,
            label: l10n?.brainDump ?? 'Brain Dump',
          ),
          const SizedBox(width: 8),
          _buildTab(
            context,
            index: 1,
            icon: Icons.access_time_rounded,
            label: l10n?.timeline ?? 'Timeline',
          ),
        ],
      ),
    );
  }

  Widget _buildTab(
    BuildContext context, {
    required int index,
    required IconData icon,
    required String label,
  }) {
    final theme = Theme.of(context);
    final isSelected = currentIndex == index;

    return GestureDetector(
      onTap: () {
        pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? theme.colorScheme.primary.withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 18,
              color: isSelected
                  ? theme.colorScheme.primary
                  : theme.colorScheme.outline,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: isSelected
                    ? theme.colorScheme.primary
                    : theme.colorScheme.outline,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
