// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appName => 'टाइमबॉक्स प्लानर';

  @override
  String get inbox => 'इनबॉक्स';

  @override
  String get calendar => 'कैलेंडर';

  @override
  String get focus => 'फोकस';

  @override
  String get analytics => 'विश्लेषण';

  @override
  String get settings => 'सेटिंग्स';

  @override
  String get task => 'कार्य';

  @override
  String get tasks => 'कार्य सूची';

  @override
  String get addTask => 'कार्य जोड़ें';

  @override
  String get editTask => 'कार्य संपादित करें';

  @override
  String get deleteTask => 'कार्य हटाएं';

  @override
  String get taskTitle => 'शीर्षक';

  @override
  String get taskNote => 'नोट';

  @override
  String get estimatedDuration => 'अनुमानित समय';

  @override
  String get subtasks => 'उप-कार्य';

  @override
  String get addSubtask => 'उप-कार्य जोड़ें';

  @override
  String get priority => 'प्राथमिकता';

  @override
  String get priorityHigh => 'उच्च';

  @override
  String get priorityMedium => 'मध्यम';

  @override
  String get priorityLow => 'निम्न';

  @override
  String get status => 'स्थिति';

  @override
  String get statusTodo => 'करना है';

  @override
  String get statusInProgress => 'प्रगति में';

  @override
  String get statusCompleted => 'पूर्ण';

  @override
  String get statusDelayed => 'विलंबित';

  @override
  String get statusSkipped => 'छोड़ा गया';

  @override
  String get tag => 'टैग';

  @override
  String get tags => 'टैग्स';

  @override
  String get addTag => 'टैग जोड़ें';

  @override
  String get timeBlock => 'टाइम ब्लॉक';

  @override
  String get createTimeBlock => 'टाइम ब्लॉक बनाएं';

  @override
  String get moveTimeBlock => 'टाइम ब्लॉक हिलाएं';

  @override
  String get resizeTimeBlock => 'टाइम ब्लॉक का आकार बदलें';

  @override
  String get conflictDetected => 'शेड्यूल में टकराव पाया गया';

  @override
  String get focusMode => 'फोकस मोड';

  @override
  String get startFocus => 'फोकस शुरू करें';

  @override
  String get pauseFocus => 'रोकें';

  @override
  String get resumeFocus => 'जारी रखें';

  @override
  String get completeFocus => 'पूर्ण';

  @override
  String get skipFocus => 'छोड़ें';

  @override
  String get timeRemaining => 'शेष समय';

  @override
  String get today => 'आज';

  @override
  String get tomorrow => 'कल';

  @override
  String get thisWeek => 'इस सप्ताह';

  @override
  String get minutes => 'मिनट';

  @override
  String get hours => 'घंटे';

  @override
  String minutesShort(int count) {
    return '$countमि';
  }

  @override
  String hoursShort(int count) {
    return '$countघं';
  }

  @override
  String get productivityScore => 'उत्पादकता स्कोर';

  @override
  String get plannedVsActual => 'योजना vs वास्तविक';

  @override
  String get completionRate => 'पूर्णता दर';

  @override
  String get rolloverTasks => 'स्थानांतरित कार्य';

  @override
  String get darkMode => 'डार्क मोड';

  @override
  String get language => 'भाषा';

  @override
  String get notifications => 'सूचनाएं';

  @override
  String get calendarSync => 'कैलेंडर सिंक';

  @override
  String get profile => 'प्रोफ़ाइल';

  @override
  String get logout => 'लॉग आउट';

  @override
  String get save => 'सहेजें';

  @override
  String get cancel => 'रद्द करें';

  @override
  String get delete => 'हटाएं';

  @override
  String get confirm => 'पुष्टि करें';

  @override
  String get edit => 'संपादित करें';

  @override
  String get done => 'हो गया';

  @override
  String get emptyInbox => 'इनबॉक्स खाली है';

  @override
  String get emptyInboxDescription => 'शुरू करने के लिए नया कार्य जोड़ें';

  @override
  String get emptyCalendar => 'आज का कोई शेड्यूल नहीं';

  @override
  String get emptyCalendarDescription =>
      'अपना शेड्यूल बनाने के लिए कार्यों को खींचें';

  @override
  String get error => 'त्रुटि';

  @override
  String get errorGeneric => 'कुछ गलत हो गया';

  @override
  String get errorNetwork => 'कृपया अपना नेटवर्क कनेक्शन जांचें';

  @override
  String get retry => 'पुनः प्रयास करें';

  @override
  String get noActiveSession => 'कोई सक्रिय सत्र नहीं';

  @override
  String get startFocusDescription =>
      'उत्पादकता बढ़ाने के लिए फोकस सत्र शुरू करें';

  @override
  String get quickStart => 'त्वरित प्रारंभ';

  @override
  String get paused => 'रोका गया';

  @override
  String get skip => 'छोड़ें';

  @override
  String get complete => 'पूर्ण';

  @override
  String get sessionCompleted => 'सत्र पूर्ण!';

  @override
  String get selectDuration => 'समय चुनें';

  @override
  String get filter => 'फ़िल्टर';

  @override
  String get all => 'सभी';

  @override
  String get statusDone => 'हो गया';

  @override
  String get emptyInboxTitle => 'इनबॉक्स खाली है';

  @override
  String get toDo => 'करना है';

  @override
  String get completed => 'पूर्ण';

  @override
  String get deleteTaskConfirm => 'इस कार्य को हटाएं?';

  @override
  String get taskTitleHint => 'आपको क्या करना है?';

  @override
  String get lessOptions => 'कम विकल्प';

  @override
  String get moreOptions => 'अधिक विकल्प';

  @override
  String get taskNoteHint => 'नोट जोड़ें...';

  @override
  String get title => 'शीर्षक';

  @override
  String get timeBlockTitleHint => 'ब्लॉक का नाम दर्ज करें';

  @override
  String get startTime => 'प्रारंभ समय';

  @override
  String get endTime => 'समाप्ति समय';

  @override
  String get add => 'जोड़ें';

  @override
  String get top3 => 'शीर्ष 3 प्राथमिकताएं';

  @override
  String get rank1 => 'पहला';

  @override
  String get rank2 => 'दूसरा';

  @override
  String get rank3 => 'तीसरा';

  @override
  String get brainDump => 'ब्रेन डंप';

  @override
  String get timeline => 'टाइमलाइन';

  @override
  String get dragToSchedule => 'शेड्यूल करने के लिए यहां खींचें';

  @override
  String get emptyTop3Slot => 'जोड़ने के लिए टैप या ड्रैग करें';

  @override
  String get dayStartTime => 'दिन की शुरुआत का समय';

  @override
  String get dayEndTime => 'दिन के अंत का समय';

  @override
  String get planner => 'प्लानर';

  @override
  String get appearance => 'दिखावट';

  @override
  String get theme => 'थीम';

  @override
  String get themeSystem => 'सिस्टम सेटिंग';

  @override
  String get themeLight => 'लाइट';

  @override
  String get themeDark => 'डार्क';

  @override
  String get notificationDescription => 'टाइम ब्लॉक सूचनाएं प्राप्त करें';

  @override
  String get notificationTiming => 'सूचना समय';

  @override
  String minutesBefore(int count) {
    return '$count मिनट पहले';
  }

  @override
  String get noCalendarConnected => 'कोई कैलेंडर कनेक्ट नहीं है';

  @override
  String get comingSoon => 'जल्द आ रहा है';

  @override
  String get timeSettings => 'समय सेटिंग्स';

  @override
  String get dayTimeRange => 'दिन का समय सीमा';

  @override
  String get defaultTimeBlockDuration => 'डिफ़ॉल्ट टाइम ब्लॉक अवधि';

  @override
  String get data => 'डेटा';

  @override
  String get exportData => 'डेटा निर्यात करें';

  @override
  String get exportDataDescription => 'CSV फ़ाइल में निर्यात करें';

  @override
  String get resetSettings => 'सेटिंग्स रीसेट करें';

  @override
  String get resetSettingsConfirm => 'सभी सेटिंग्स को डिफ़ॉल्ट पर रीसेट करें?';

  @override
  String get settingsReset => 'सेटिंग्स रीसेट हो गई हैं';
}
