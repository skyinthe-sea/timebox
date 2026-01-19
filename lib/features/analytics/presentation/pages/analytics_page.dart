import 'package:flutter/material.dart';

/// 분석 페이지
///
/// 생산성 통계 및 리뷰 대시보드
///
/// 기능:
/// - 생산성 점수 표시
/// - 계획 vs 실제 시간 비교 차트
/// - 완료율 차트
/// - 이월된 작업 목록
/// - 주간 트렌드
class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // TODO: BlocProvider, BlocBuilder 구현
    return Scaffold(
      appBar: AppBar(
        title: const Text('분석'), // TODO: l10n
        actions: [
          // 날짜 범위 선택
          IconButton(
            icon: const Icon(Icons.date_range),
            onPressed: () {
              // TODO: 날짜 범위 선택 다이얼로그
            },
          ),
          // 내보내기
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () {
              // TODO: CSV 내보내기
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 생산성 점수 카드
            _buildScoreCard(theme),

            const SizedBox(height: 24),

            // 완료율 섹션
            Text(
              '오늘의 완료율', // TODO: l10n
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            _buildCompletionRates(theme),

            const SizedBox(height: 24),

            // 계획 vs 실제 시간
            Text(
              '시간 비교', // TODO: l10n
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            // TODO: TimeComparisonChart 위젯

            const SizedBox(height: 24),

            // 이월된 작업
            Text(
              '이월된 작업', // TODO: l10n
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            // TODO: RolloverTasksList 위젯
          ],
        ),
      ),
    );
  }

  Widget _buildScoreCard(ThemeData theme) {
    // TODO: 실제 데이터 바인딩
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Row(
          children: [
            // 점수
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: theme.colorScheme.primaryContainer,
              ),
              child: Center(
                child: Text(
                  '85',
                  style: theme.textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 24),
            // 설명
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '생산성 점수', // TODO: l10n
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '어제보다 5점 상승했어요!', // TODO: 실제 비교 데이터
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.outline,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompletionRates(ThemeData theme) {
    // TODO: 실제 데이터 바인딩
    return Row(
      children: [
        Expanded(
          child: _buildRateCard(
            theme,
            label: 'Task 완료',
            value: 80,
            color: const Color(0xFF10B981),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildRateCard(
            theme,
            label: '일정 준수',
            value: 75,
            color: const Color(0xFF3B82F6),
          ),
        ),
      ],
    );
  }

  Widget _buildRateCard(
    ThemeData theme, {
    required String label,
    required int value,
    required Color color,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              '$value%',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
