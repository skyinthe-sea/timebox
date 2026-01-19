import 'package:flutter/material.dart';

/// 인박스 페이지
///
/// 할 일 목록을 관리하는 메인 화면
///
/// 기능:
/// - 브레인 덤프 (빠른 할 일 추가)
/// - 할 일 목록 표시 (상태별 필터링)
/// - 드래그하여 캘린더로 이동 가능
/// - 스와이프로 완료/삭제
class InboxPage extends StatelessWidget {
  const InboxPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: BlocProvider, BlocBuilder 구현
    return Scaffold(
      appBar: AppBar(
        title: const Text('인박스'), // TODO: l10n
      ),
      body: const Center(
        child: Text('Inbox Page - TODO: Implement'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: 빠른 할 일 추가 다이얼로그
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
