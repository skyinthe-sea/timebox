import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/widgets/loading_indicator.dart';
import '../../../../l10n/app_localizations.dart';
import '../bloc/calendar_bloc.dart';
import '../widgets/timeline_view.dart';

/// 캘린더 페이지
///
/// 타임박싱의 메인 화면 - 시간축에 블록을 배치하는 UI
class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  void initState() {
    super.initState();
    context.read<CalendarBloc>().add(WatchTimeBlocksStarted(DateTime.now()));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<CalendarBloc, CalendarState>(
          buildWhen: (prev, curr) => prev.selectedDate != curr.selectedDate,
          builder: (context, state) {
            return GestureDetector(
              onTap: () => _showDatePicker(context, state.selectedDate),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(_formatDate(state.selectedDate, l10n)),
                  const Icon(Icons.arrow_drop_down),
                ],
              ),
            );
          },
        ),
        actions: [
          // 오늘로 이동
          BlocBuilder<CalendarBloc, CalendarState>(
            buildWhen: (prev, curr) => prev.isToday != curr.isToday,
            builder: (context, state) {
              if (state.isToday) return const SizedBox.shrink();
              return IconButton(
                icon: const Icon(Icons.today),
                tooltip: l10n?.today ?? 'Today',
                onPressed: () {
                  context.read<CalendarBloc>().add(const GoToToday());
                },
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<CalendarBloc, CalendarState>(
        builder: (context, state) {
          if (state.status == CalendarStateStatus.loading) {
            return const LoadingIndicator();
          }

          if (state.status == CalendarStateStatus.failure) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 48,
                    color: theme.colorScheme.error,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    state.errorMessage ?? 'An error occurred',
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: () {
                      context
                          .read<CalendarBloc>()
                          .add(WatchTimeBlocksStarted(state.selectedDate));
                    },
                    child: Text(l10n?.retry ?? 'Retry'),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              // 날짜 네비게이션
              _buildDateNavigation(context, state),

              // 타임라인
              Expanded(
                child: TimelineView(
                  date: state.selectedDate,
                  timeBlocks: state.timeBlocks,
                  onTimeBlockTap: (tb) {
                    // TODO: 포커스 모드로 이동
                  },
                  onTimeBlockMoved: (id, newStart) {
                    context.read<CalendarBloc>().add(
                          MoveTimeBlockEvent(id: id, newStartTime: newStart),
                        );
                  },
                  onTimeBlockResized: (id, newStart, newEnd) {
                    context.read<CalendarBloc>().add(
                          ResizeTimeBlockEvent(
                            id: id,
                            newStartTime: newStart,
                            newEndTime: newEnd,
                          ),
                        );
                  },
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTimeBlockDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildDateNavigation(BuildContext context, CalendarState state) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        border: Border(
          bottom: BorderSide(
            color: theme.colorScheme.outlineVariant,
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: () {
              context.read<CalendarBloc>().add(
                    DateChanged(
                      state.selectedDate.subtract(const Duration(days: 1)),
                    ),
                  );
            },
          ),
          Text(
            _getRelativeDateText(state.selectedDate),
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: () {
              context.read<CalendarBloc>().add(
                    DateChanged(
                      state.selectedDate.add(const Duration(days: 1)),
                    ),
                  );
            },
          ),
        ],
      ),
    );
  }

  Future<void> _showDatePicker(
      BuildContext context, DateTime currentDate) async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null && context.mounted) {
      context.read<CalendarBloc>().add(DateChanged(selectedDate));
    }
  }

  Future<void> _showAddTimeBlockDialog(BuildContext context) async {
    final state = context.read<CalendarBloc>().state;
    final now = DateTime.now();

    // 기본 시작 시간: 현재 시간의 다음 30분 단위
    var startTime = DateTime(
      state.selectedDate.year,
      state.selectedDate.month,
      state.selectedDate.day,
      now.hour,
      now.minute < 30 ? 30 : 0,
    );
    if (now.minute >= 30) {
      startTime = startTime.add(const Duration(hours: 1));
    }
    final endTime = startTime.add(const Duration(minutes: 30));

    if (!context.mounted) return;

    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (dialogContext) => _AddTimeBlockDialog(
        initialStartTime: startTime,
        initialEndTime: endTime,
      ),
    );

    if (result != null && context.mounted) {
      context.read<CalendarBloc>().add(
            CreateTimeBlockEvent(
              title: result['title'] as String?,
              startTime: result['startTime'] as DateTime,
              endTime: result['endTime'] as DateTime,
            ),
          );
    }
  }

  String _formatDate(DateTime date, AppLocalizations? l10n) {
    final formatter = DateFormat.MMMd();
    return formatter.format(date);
  }

  String _getRelativeDateText(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final selectedDay = DateTime(date.year, date.month, date.day);
    final difference = selectedDay.difference(today).inDays;

    if (difference == 0) return 'Today';
    if (difference == 1) return 'Tomorrow';
    if (difference == -1) return 'Yesterday';

    return DateFormat.EEEE().format(date);
  }
}

class _AddTimeBlockDialog extends StatefulWidget {
  final DateTime initialStartTime;
  final DateTime initialEndTime;

  const _AddTimeBlockDialog({
    required this.initialStartTime,
    required this.initialEndTime,
  });

  @override
  State<_AddTimeBlockDialog> createState() => _AddTimeBlockDialogState();
}

class _AddTimeBlockDialogState extends State<_AddTimeBlockDialog> {
  final _titleController = TextEditingController();
  late DateTime _startTime;
  late DateTime _endTime;

  @override
  void initState() {
    super.initState();
    _startTime = widget.initialStartTime;
    _endTime = widget.initialEndTime;
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return AlertDialog(
      title: Text(l10n?.createTimeBlock ?? 'Add Time Block'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleController,
            decoration: InputDecoration(
              labelText: l10n?.title ?? 'Title',
              hintText: l10n?.timeBlockTitleHint ?? 'What will you work on?',
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ListTile(
                  title: Text(l10n?.startTime ?? 'Start'),
                  subtitle: Text(_formatTime(_startTime)),
                  onTap: () => _selectTime(true),
                ),
              ),
              Expanded(
                child: ListTile(
                  title: Text(l10n?.endTime ?? 'End'),
                  subtitle: Text(_formatTime(_endTime)),
                  onTap: () => _selectTime(false),
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n?.cancel ?? 'Cancel'),
        ),
        FilledButton(
          onPressed: () {
            Navigator.of(context).pop({
              'title': _titleController.text.isNotEmpty
                  ? _titleController.text
                  : null,
              'startTime': _startTime,
              'endTime': _endTime,
            });
          },
          child: Text(l10n?.add ?? 'Add'),
        ),
      ],
    );
  }

  Future<void> _selectTime(bool isStart) async {
    final currentTime = isStart ? _startTime : _endTime;
    final selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(currentTime),
    );

    if (selectedTime != null) {
      setState(() {
        final newDateTime = DateTime(
          currentTime.year,
          currentTime.month,
          currentTime.day,
          selectedTime.hour,
          selectedTime.minute,
        );

        if (isStart) {
          _startTime = newDateTime;
          if (_startTime.isAfter(_endTime)) {
            _endTime = _startTime.add(const Duration(minutes: 30));
          }
        } else {
          _endTime = newDateTime;
          if (_endTime.isBefore(_startTime)) {
            _startTime = _endTime.subtract(const Duration(minutes: 30));
          }
        }
      });
    }
  }

  String _formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }
}
