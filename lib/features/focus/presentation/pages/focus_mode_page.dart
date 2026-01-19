import 'package:flutter/material.dart';

/// 포커스 모드 페이지
///
/// 현재 진행 중인 타임박스에 대한 집중 화면
///
/// 기능:
/// - 카운트다운 타이머 표시
/// - 시작/일시정지/완료/건너뛰기 컨트롤
/// - 현재 Task 정보 표시
/// - 전체 화면 모드 지원
class FocusModePage extends StatelessWidget {
  /// TimeBlock ID (선택)
  final String? timeBlockId;

  const FocusModePage({
    super.key,
    this.timeBlockId,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // TODO: BlocProvider, BlocBuilder 구현
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: const Text('집중 모드'), // TODO: l10n
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Task 정보
            const Padding(
              padding: EdgeInsets.all(24),
              child: Text(
                '현재 작업 제목', // TODO: 실제 Task 제목
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 32),

            // 타이머 표시
            // TODO: CountdownTimer 위젯
            Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: theme.colorScheme.primary,
                  width: 8,
                ),
              ),
              child: const Center(
                child: Text(
                  '25:00',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 48),

            // 컨트롤 버튼
            // TODO: TimerControls 위젯
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 건너뛰기
                IconButton(
                  onPressed: () {
                    // TODO: 건너뛰기 처리
                  },
                  icon: const Icon(Icons.skip_next),
                  iconSize: 32,
                ),
                const SizedBox(width: 24),
                // 시작/일시정지
                FilledButton(
                  onPressed: () {
                    // TODO: 시작/일시정지 토글
                  },
                  style: FilledButton.styleFrom(
                    minimumSize: const Size(80, 80),
                    shape: const CircleBorder(),
                  ),
                  child: const Icon(Icons.play_arrow, size: 40),
                ),
                const SizedBox(width: 24),
                // 완료
                IconButton(
                  onPressed: () {
                    // TODO: 완료 처리
                  },
                  icon: const Icon(Icons.check),
                  iconSize: 32,
                ),
              ],
            ),

            const Spacer(),

            // 남은 시간 / 진행 상태
            Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                '예정 종료: 14:30', // TODO: 실제 종료 시간
                style: theme.textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
