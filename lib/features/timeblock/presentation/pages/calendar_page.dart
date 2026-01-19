import 'package:flutter/material.dart';

/// 캘린더 페이지
///
/// 타임박싱의 메인 화면 - 시간축에 블록을 배치하는 UI
///
/// 기능:
/// - 일간/주간 뷰 전환
/// - 드래그 앤 드롭으로 Task 배치
/// - TimeBlock 리사이징
/// - 외부 캘린더 일정 표시
/// - 충돌 감지 및 경고
class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: BlocProvider, BlocBuilder 구현
    return Scaffold(
      appBar: AppBar(
        title: const Text('캘린더'), // TODO: l10n
        actions: [
          // 뷰 전환 (일간/주간)
          IconButton(
            icon: const Icon(Icons.view_day),
            onPressed: () {
              // TODO: 뷰 전환
            },
          ),
          // 오늘로 이동
          IconButton(
            icon: const Icon(Icons.today),
            onPressed: () {
              // TODO: 오늘로 이동
            },
          ),
        ],
      ),
      body: const Column(
        children: [
          // TODO: 날짜 헤더
          // TODO: TimelineView 위젯
          Expanded(
            child: Center(
              child: Text('Calendar Page - TODO: Implement TimelineView'),
            ),
          ),
        ],
      ),
    );
  }
}
