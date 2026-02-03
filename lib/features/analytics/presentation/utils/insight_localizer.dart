import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/insight.dart';

/// 인사이트 로컬라이저
///
/// 키 기반 Insight 엔티티를 실제 번역된 문자열로 변환
class InsightLocalizer {
  final AppLocalizations l10n;

  const InsightLocalizer(this.l10n);

  /// titleKey + params → 번역된 제목 문자열
  String localizeTitle(Insight insight) {
    return _resolve(insight.titleKey, insight.params);
  }

  /// descriptionKey + params → 번역된 설명 문자열 (null이면 null)
  String? localizeDescription(Insight insight) {
    if (insight.descriptionKey == null) return null;
    return _resolve(insight.descriptionKey!, insight.params);
  }

  /// 키 → 번역된 문자열 (params 치환 포함)
  String _resolve(String key, Map<String, String> params) {
    final raw = _getRawString(key, params);
    return raw;
  }

  String _getRawString(String key, Map<String, String> params) {
    return switch (key) {
      // === Insight 제목 ===
      'insightFocusTimeTitle' => l10n.insightFocusTimeTitle(params['dayName'] ?? '', params['hour'] ?? ''),
      'insightFocusTimeDesc' => l10n.insightFocusTimeDesc,
      'insightTagAccuracyFasterTitle' => l10n.insightTagAccuracyFasterTitle(params['tagName'] ?? '', params['minutes'] ?? ''),
      'insightTagAccuracySlowerTitle' => l10n.insightTagAccuracySlowerTitle(params['tagName'] ?? '', params['minutes'] ?? ''),
      'insightTagAccuracyFasterDesc' => l10n.insightTagAccuracyFasterDesc,
      'insightTagAccuracySlowerDesc' => l10n.insightTagAccuracySlowerDesc,
      'insightRolloverTitle' => l10n.insightRolloverTitle(params['rolloverCount'] ?? '', params['taskCount'] ?? ''),
      'insightRolloverDesc' => l10n.insightRolloverDesc,
      'insightStreakTitle' => l10n.insightStreakTitle(params['days'] ?? ''),
      'insightStreakDesc' => l10n.insightStreakDesc,
      'insightScoreUpTitle' => l10n.insightScoreUpTitle(_resolvePeriod(params['period'] ?? ''), params['scoreDiff'] ?? ''),
      'insightScoreUpDesc' => l10n.insightScoreUpDesc,
      'insightScoreDownTitle' => l10n.insightScoreDownTitle(_resolvePeriod(params['period'] ?? ''), params['scoreDiff'] ?? ''),
      'insightScoreDownDesc' => l10n.insightScoreDownDesc,
      'insightBestDayTitle' => l10n.insightBestDayTitle(_resolveDay(params['dayName'] ?? '')),
      'insightBestDayDesc' => l10n.insightBestDayDesc(params['score'] ?? ''),
      'insightTimeSavedTitle' => l10n.insightTimeSavedTitle(_resolvePeriod(params['period'] ?? ''), params['minutes'] ?? ''),
      'insightTimeSavedDesc' => l10n.insightTimeSavedDesc,
      'insightTimeOverTitle' => l10n.insightTimeOverTitle(_resolvePeriod(params['period'] ?? ''), params['minutes'] ?? ''),
      'insightTimeOverDesc' => l10n.insightTimeOverDesc,
      'insightTaskFirstTitle' => l10n.insightTaskFirstTitle,
      'insightTaskFirstDesc' => l10n.insightTaskFirstDesc,
      'insightTaskAllCompleteTitle' => l10n.insightTaskAllCompleteTitle,
      'insightTaskAllCompleteDesc' => l10n.insightTaskAllCompleteDesc(params['total'] ?? ''),
      'insightTaskNoneTitle' => l10n.insightTaskNoneTitle,
      'insightTaskNoneDesc' => l10n.insightTaskNoneDesc,
      'insightTaskPartialTitle' => l10n.insightTaskPartialTitle(params['total'] ?? '', params['completed'] ?? ''),
      'insightTaskPartialDesc' => l10n.insightTaskPartialDesc(params['remaining'] ?? ''),
      'insightFocusEffTitle' => l10n.insightFocusEffTitle(params['percent'] ?? ''),
      'insightFocusEffHighDesc' => l10n.insightFocusEffHighDesc,
      'insightFocusEffMedDesc' => l10n.insightFocusEffMedDesc,
      'insightFocusEffLowDesc' => l10n.insightFocusEffLowDesc,
      'insightTimeEstTitle' => l10n.insightTimeEstTitle(params['percent'] ?? ''),
      'insightTimeEstHighDesc' => l10n.insightTimeEstHighDesc,
      'insightTimeEstMedDesc' => l10n.insightTimeEstMedDesc,
      'insightTimeEstLowDesc' => l10n.insightTimeEstLowDesc,
      'insightTop3AllCompleteTitle' => l10n.insightTop3AllCompleteTitle,
      'insightTop3AllCompleteDesc' => l10n.insightTop3AllCompleteDesc,
      'insightTop3PartialTitle' => l10n.insightTop3PartialTitle(params['completed'] ?? ''),
      'insightTop3PartialDesc' => l10n.insightTop3PartialDesc(params['remaining'] ?? ''),
      'insightScoreGreatTitle' => l10n.insightScoreGreatTitle,
      'insightScoreGreatDesc' => l10n.insightScoreGreatDesc(params['score'] ?? ''),
      'insightScoreNormalTitle' => l10n.insightScoreNormalTitle,
      'insightScoreNormalDesc' => l10n.insightScoreNormalDesc(params['score'] ?? ''),
      'insightWeekAvgTitle' => l10n.insightWeekAvgTitle(params['score'] ?? ''),
      'insightWeekAvgHighDesc' => l10n.insightWeekAvgHighDesc,
      'insightWeekAvgLowDesc' => l10n.insightWeekAvgLowDesc,
      'insightMonthAvgTitle' => l10n.insightMonthAvgTitle(params['score'] ?? ''),
      'insightMonthAvgHighDesc' => l10n.insightMonthAvgHighDesc,
      'insightMonthAvgLowDesc' => l10n.insightMonthAvgLowDesc,
      'insightMonthBestTitle' => l10n.insightMonthBestTitle(params['month'] ?? '', params['day'] ?? ''),
      'insightMonthBestDesc' => l10n.insightMonthBestDesc(params['score'] ?? ''),
      _ => key,
    };
  }

  /// period 키 → 번역된 기간 문자열
  String _resolvePeriod(String periodKey) {
    return switch (periodKey) {
      'insightPeriodYesterday' => l10n.insightPeriodYesterday,
      'insightPeriodToday' => l10n.insightPeriodToday,
      'insightPeriodWeekFirstHalf' => l10n.insightPeriodWeekFirstHalf,
      _ => periodKey,
    };
  }

  /// 요일 키 → 번역된 요일 문자열
  String _resolveDay(String dayKey) {
    return switch (dayKey) {
      'monday' => l10n.monday,
      'tuesday' => l10n.tuesday,
      'wednesday' => l10n.wednesday,
      'thursday' => l10n.thursday,
      'friday' => l10n.friday,
      'saturday' => l10n.saturday,
      'sunday' => l10n.sunday,
      _ => dayKey,
    };
  }
}
