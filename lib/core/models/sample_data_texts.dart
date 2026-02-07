/// 샘플 데이터 텍스트 모델
///
/// JSON 파일에서 로드되는 샘플 텍스트 데이터 구조
class SampleDataTexts {
  final List<SampleTaskText> tasks;
  final Map<String, String> tagNames;

  const SampleDataTexts({
    required this.tasks,
    required this.tagNames,
  });

  factory SampleDataTexts.fromJson(Map<String, dynamic> json) {
    return SampleDataTexts(
      tasks: (json['tasks'] as List<dynamic>)
          .map((e) => SampleTaskText.fromJson(e as Map<String, dynamic>))
          .toList(),
      tagNames: Map<String, String>.from(json['tagNames'] as Map),
    );
  }

  Map<String, dynamic> toJson() => {
        'tasks': tasks.map((e) => e.toJson()).toList(),
        'tagNames': tagNames,
      };
}

/// 샘플 태스크 텍스트
class SampleTaskText {
  final String key;
  final String title;
  final String? note;
  final String timeSlot;
  final String tagId;
  final int durationMinutes;
  final String priority;

  const SampleTaskText({
    required this.key,
    required this.title,
    this.note,
    required this.timeSlot,
    required this.tagId,
    required this.durationMinutes,
    required this.priority,
  });

  factory SampleTaskText.fromJson(Map<String, dynamic> json) {
    return SampleTaskText(
      key: json['key'] as String,
      title: json['title'] as String,
      note: json['note'] as String?,
      timeSlot: json['timeSlot'] as String,
      tagId: json['tagId'] as String,
      durationMinutes: json['durationMinutes'] as int,
      priority: json['priority'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'key': key,
        'title': title,
        if (note != null) 'note': note,
        'timeSlot': timeSlot,
        'tagId': tagId,
        'durationMinutes': durationMinutes,
        'priority': priority,
      };
}

/// 시간대 enum
enum TimeSlot {
  morning,      // 06:00-09:00
  workMorning,  // 09:00-12:00
  lunch,        // 12:00-13:00
  workAfternoon,// 13:00-18:00
  evening,      // 18:00-22:00
}

extension TimeSlotExtension on TimeSlot {
  /// 시간대별 시작/종료 시간 범위
  (int startHour, int endHour) get hourRange {
    switch (this) {
      case TimeSlot.morning:
        return (6, 9);
      case TimeSlot.workMorning:
        return (9, 12);
      case TimeSlot.lunch:
        return (12, 13);
      case TimeSlot.workAfternoon:
        return (13, 18);
      case TimeSlot.evening:
        return (18, 22);
    }
  }

  static TimeSlot fromString(String value) {
    switch (value) {
      case 'morning':
        return TimeSlot.morning;
      case 'workMorning':
        return TimeSlot.workMorning;
      case 'lunch':
        return TimeSlot.lunch;
      case 'workAfternoon':
        return TimeSlot.workAfternoon;
      case 'evening':
        return TimeSlot.evening;
      default:
        return TimeSlot.workMorning;
    }
  }
}
