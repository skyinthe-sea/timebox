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
}
