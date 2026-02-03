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
  String get planner => 'टाइमबॉक्स';

  @override
  String get copyToTomorrow => 'कल भी करें';

  @override
  String get copiedToTomorrow => 'कल के लिए कॉपी किया गया';

  @override
  String rolloverBadge(int count) {
    return 'स्थानांतरित ${count}x';
  }

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

  @override
  String get longPressToSelect => 'समय सीमा चुनने के लिए दबाए रखें';

  @override
  String get selectTask => 'कार्य चुनें';

  @override
  String get noUnscheduledTasks => 'कोई अनिर्धारित कार्य नहीं';

  @override
  String get addNewTask => 'नया कार्य जोड़ें';

  @override
  String get addNewTaskHint => 'कार्य शीर्षक दर्ज करें...';

  @override
  String timeRangeLabel(String start, String end) {
    return '$start - $end';
  }

  @override
  String get assignToTimeBlock => 'टाइम ब्लॉक में असाइन करें';

  @override
  String get mergeBlocks => 'ब्लॉक मर्ज करें';

  @override
  String get overlapWarning => 'चेतावनी: टाइम ब्लॉक ओवरलैप हो रहे हैं';

  @override
  String get taskAssigned => 'कार्य असाइन किया गया';

  @override
  String get tapToCancel => 'रद्द करने के लिए बाहर टैप करें';

  @override
  String get statistics => 'सांख्यिकी';

  @override
  String get todayHighlights => 'आज की मुख्य बातें';

  @override
  String get completedTasksCount => 'पूर्ण कार्य';

  @override
  String get focusTimeMinutes => 'फोकस समय';

  @override
  String get timeSavedMinutes => 'बचाया गया समय';

  @override
  String get top3Achievement => 'Top 3 उपलब्धि';

  @override
  String get trend => 'रुझान';

  @override
  String get tagAnalysis => 'टैग विश्लेषण';

  @override
  String get insights => 'अंतर्दृष्टि';

  @override
  String get daily => 'दैनिक';

  @override
  String get weekly => 'साप्ताहिक';

  @override
  String get monthly => 'मासिक';

  @override
  String get focusModeTooltip => 'फोकस मोड';

  @override
  String get startAlarm => 'प्रारंभ अलार्म';

  @override
  String get endAlarm => 'समाप्ति अलार्म';

  @override
  String get notifyBeforeStart => 'शुरू होने से पहले सूचित करें';

  @override
  String get notifyBeforeEnd => 'समाप्त होने से पहले सूचित करें';

  @override
  String get selectMultipleTimings => 'एक से अधिक समय चुन सकते हैं';

  @override
  String get dailyReminder => 'दैनिक रिमाइंडर';

  @override
  String get dailyReminderDesc => 'जिन दिनों ऐप नहीं खोला उन दिनों सूचना';

  @override
  String get dailyReminderTime => 'रिमाइंडर समय';

  @override
  String get notificationPermissionRequired => 'सूचना अनुमति आवश्यक';

  @override
  String get notificationPermissionDesc =>
      'टाइम ब्लॉक अलर्ट के लिए सूचना अनुमति दें';

  @override
  String get openSettings => 'सेटिंग्स खोलें';

  @override
  String get permissionGranted => 'अनुमति दी गई';

  @override
  String get permissionDenied => 'अनुमति अस्वीकार';

  @override
  String get requestPermission => 'अनुमति का अनुरोध करें';

  @override
  String hourBefore(int count) {
    return '$count घंटे पहले';
  }

  @override
  String get alarmSettings => 'अलार्म सेटिंग्स';

  @override
  String get alarmTimingNote => 'एकाधिक चयन संभव';

  @override
  String get noonTime => 'दोपहर (12:00)';

  @override
  String get mathChallenge => 'गणित चुनौती';

  @override
  String mathChallengeProgress(int current, int total) {
    return '$current / $total';
  }

  @override
  String get enterAnswer => 'उत्तर दर्ज करें';

  @override
  String get wrongAnswer => 'गलत। कृपया पुनः प्रयास करें।';

  @override
  String get focusLockEnabled => 'स्क्रीन लॉक सक्षम';

  @override
  String get overlayPermissionRequired => 'ओवरले अनुमति आवश्यक';

  @override
  String get noActiveTimeBlock => 'कोई सक्रिय टाइम ब्लॉक नहीं';

  @override
  String get createTimeBlockFirst => 'पहले कैलेंडर से टाइम ब्लॉक बनाएं';

  @override
  String get exitFocus => 'बाहर निकलें';

  @override
  String get statsCompletionRates => 'पूर्णता दरें';

  @override
  String get statsTaskPipeline => 'कार्य प्रवाह';

  @override
  String get statsPlanVsActual => 'योजना vs वास्तविक';

  @override
  String get statsPriorityBreakdown => 'प्राथमिकता प्रदर्शन';

  @override
  String get statsFocusSummary => 'फोकस विश्लेषण';

  @override
  String get statsTopInsights => 'अंतर्दृष्टि';

  @override
  String get statsScheduled => 'शेड्यूल';

  @override
  String get statsCompleted => 'पूर्ण';

  @override
  String get statsRolledOver => 'स्थानांतरित';

  @override
  String get statsEfficiency => 'दक्षता';

  @override
  String get statsNoData => 'अभी तक कोई डेटा नहीं';

  @override
  String get navTimeline => 'टाइमलाइन';

  @override
  String get navReport => 'रिपोर्ट';

  @override
  String get suggestedTasks => 'सुझाए गए कार्य';

  @override
  String get taskSuggestionsHint => 'पहले किए गए कार्य';

  @override
  String get topSuccessTasks => 'सबसे ज़्यादा पूरे होने वाले कार्य';

  @override
  String get topFailureTasks => 'पूरा करना कठिन कार्य';

  @override
  String get completionCount => 'पूर्णता संख्या';

  @override
  String get taskRankings => 'कार्य रैंकिंग';

  @override
  String get privacyPolicy => 'गोपनीयता नीति';

  @override
  String get termsOfService => 'सेवा की शर्तें';

  @override
  String get privacyPolicyContent =>
      'गोपनीयता नीति\n\nअंतिम अपडेट: 1 जनवरी, 2026\n\n1. डेटा संग्रह\nयह ऐप कार्य और समय रिकॉर्ड जैसे उपयोगकर्ता द्वारा दर्ज किए गए डेटा को संसाधित करता है।\n\n2. डेटा संग्रहण\nसभी डेटा केवल आपके डिवाइस पर स्थानीय रूप से संग्रहीत होता है। कोई डेटा बाहरी सर्वर पर नहीं भेजा जाता।\n\n3. तृतीय पक्ष\nयह ऐप विज्ञापन के लिए Google AdMob का उपयोग करता है। AdMob विज्ञापन पहचानकर्ता एकत्र कर सकता है। विवरण के लिए Google की गोपनीयता नीति देखें।\n\n4. डेटा हटाना\nऐप अनइंस्टॉल करने पर डिवाइस पर संग्रहीत सभी डेटा स्वचालित रूप से हटा दिया जाता है।\n\n5. संपर्क\nगोपनीयता संबंधी पूछताछ: myclick90@gmail.com';

  @override
  String get termsOfServiceContent =>
      'सेवा की शर्तें\n\nअंतिम अपडेट: 1 जनवरी, 2026\n\n1. सेवा विवरण\nTimebox Planner एक मोबाइल एप्लिकेशन है जो आपके समय प्रबंधन और शेड्यूल नियोजन में मदद करता है।\n\n2. उपयोगकर्ता की जिम्मेदारी\nउपयोगकर्ता ऐप में दर्ज सभी डेटा के लिए जिम्मेदार हैं और केवल वैध उद्देश्यों के लिए ऐप का उपयोग करें।\n\n3. अस्वीकरण\nयह ऐप \"जैसा है\" प्रदान किया जाता है। डेटा हानि, छूटे शेड्यूल या अन्य समस्याओं से होने वाली प्रत्यक्ष या अप्रत्यक्ष क्षति के लिए डेवलपर उत्तरदायी नहीं है।\n\n4. बौद्धिक संपदा\nऐप के डिज़ाइन, कोड और सामग्री के सभी बौद्धिक संपदा अधिकार डेवलपर के हैं।\n\n5. शर्तों में परिवर्तन\nये शर्तें पूर्व सूचना के साथ संशोधित की जा सकती हैं। परिवर्तन ऐप अपडेट के माध्यम से सूचित किए जाएंगे।';

  @override
  String durationFormat(int hours, int minutes) {
    return '$hoursघं $minutesमि';
  }

  @override
  String get previousDay => 'पिछला दिन';

  @override
  String get nextDay => 'अगला दिन';

  @override
  String get noTitle => 'शीर्षक नहीं';

  @override
  String get incomplete => 'अपूर्ण';

  @override
  String get revert => 'वापस करें';

  @override
  String get statusChange => 'स्थिति बदलें';

  @override
  String get timeBlockResult => 'टाइम ब्लॉक परिणाम';

  @override
  String get reverted => 'वापस किया गया';

  @override
  String get markedComplete => 'पूर्ण के रूप में चिह्नित';

  @override
  String get markedIncomplete => 'अपूर्ण के रूप में चिह्नित';

  @override
  String get deleteTimeBlock => 'टाइम ब्लॉक हटाएं';

  @override
  String get deleteTimeBlockConfirm => 'क्या आप यह टाइम ब्लॉक हटाना चाहते हैं?';

  @override
  String get removeFromTop3 => 'Top 3 से हटाएं';

  @override
  String scoreUp(int change) {
    return 'कल से $change अंक बढ़ा!';
  }

  @override
  String scoreDown(int change) {
    return 'कल से $change अंक कम';
  }

  @override
  String get scoreSame => 'कल जैसा ही';

  @override
  String get average => 'औसत';

  @override
  String get dailyReminderTitle => 'आज की योजना बनाएं!';

  @override
  String get dailyReminderBody => 'लक्ष्य प्राप्ति की पहली कदम।';

  @override
  String get monday => 'सोमवार';

  @override
  String get tuesday => 'मंगलवार';

  @override
  String get wednesday => 'बुधवार';

  @override
  String get thursday => 'गुरुवार';

  @override
  String get friday => 'शुक्रवार';

  @override
  String get saturday => 'शनिवार';

  @override
  String get sunday => 'रविवार';

  @override
  String get insightPeriodYesterday => 'कल';

  @override
  String get insightPeriodToday => 'आज';

  @override
  String get insightPeriodWeekFirstHalf => 'इस सप्ताह के पहले भाग';

  @override
  String insightFocusTimeTitle(String dayName, String hour) {
    return '$dayName $hour बजे सबसे ज़्यादा एकाग्रता थी';
  }

  @override
  String get insightFocusTimeDesc =>
      'इस समय महत्वपूर्ण कार्य रखने का प्रयास करें';

  @override
  String insightTagAccuracyFasterTitle(String tagName, String minutes) {
    return '$tagName कार्य $minutes मिनट तेज़ी से पूरे किए';
  }

  @override
  String insightTagAccuracySlowerTitle(String tagName, String minutes) {
    return '$tagName कार्यों में $minutes मिनट अधिक लगे';
  }

  @override
  String get insightTagAccuracyFasterDesc => 'आपके समय अनुमान सटीक हो रहे हैं';

  @override
  String get insightTagAccuracySlowerDesc =>
      'इस प्रकार के कार्य के लिए अधिक समय आवंटित करें';

  @override
  String insightRolloverTitle(String rolloverCount, String taskCount) {
    return '$taskCount में से $rolloverCount कार्य स्थानांतरित हुए';
  }

  @override
  String get insightRolloverDesc =>
      'कार्यों को छोटे हिस्सों में बांटने या प्राथमिकता बदलने का प्रयास करें';

  @override
  String insightStreakTitle(String days) {
    return '$days दिन लगातार योजना पर अमल!';
  }

  @override
  String get insightStreakDesc => 'निरंतरता सफलता की कुंजी है';

  @override
  String insightScoreUpTitle(String period, String scoreDiff) {
    return '$period से उत्पादकता $scoreDiff अंक बढ़ी';
  }

  @override
  String get insightScoreUpDesc => 'अच्छी गति बनाए रखें!';

  @override
  String insightScoreDownTitle(String period, String scoreDiff) {
    return '$period से उत्पादकता $scoreDiff अंक घटी';
  }

  @override
  String get insightScoreDownDesc => 'योजना में थोड़ा समायोजन करें';

  @override
  String insightBestDayTitle(String dayName) {
    return '$dayName आपका सबसे उत्पादक दिन है';
  }

  @override
  String insightBestDayDesc(String score) {
    return 'औसत स्कोर: $score अंक';
  }

  @override
  String insightTimeSavedTitle(String period, String minutes) {
    return '$period योजना से $minutes मिनट बचाए';
  }

  @override
  String get insightTimeSavedDesc => 'आप कुशलता से समय प्रबंधन कर रहे हैं';

  @override
  String insightTimeOverTitle(String period, String minutes) {
    return '$period योजना से $minutes मिनट अधिक लगे';
  }

  @override
  String get insightTimeOverDesc => 'समय अनुमान में थोड़ा अतिरिक्त जोड़ें';

  @override
  String get insightTaskFirstTitle => 'आज का पहला कार्य पूरा किया!';

  @override
  String get insightTaskFirstDesc => 'अच्छी शुरुआत';

  @override
  String get insightTaskAllCompleteTitle => 'आज के सभी कार्य पूरे!';

  @override
  String insightTaskAllCompleteDesc(String total) {
    return 'कुल $total कार्य पूरे किए';
  }

  @override
  String get insightTaskNoneTitle => 'अभी कोई कार्य पूरा नहीं हुआ';

  @override
  String get insightTaskNoneDesc => 'छोटे से शुरू करें';

  @override
  String insightTaskPartialTitle(String total, String completed) {
    return '$total में से $completed कार्य पूरे';
  }

  @override
  String insightTaskPartialDesc(String remaining) {
    return '$remaining बाकी हैं, हिम्मत रखें!';
  }

  @override
  String insightFocusEffTitle(String percent) {
    return 'एकाग्रता दक्षता $percent%';
  }

  @override
  String get insightFocusEffHighDesc => 'उच्च एकाग्रता बनाए रखी है';

  @override
  String get insightFocusEffMedDesc => 'एकाग्रता सामान्य स्तर पर है';

  @override
  String get insightFocusEffLowDesc => 'एकाग्रता वातावरण में सुधार करें';

  @override
  String insightTimeEstTitle(String percent) {
    return 'समय अनुमान सटीकता $percent%';
  }

  @override
  String get insightTimeEstHighDesc => 'आपके समय अनुमान सटीक हैं';

  @override
  String get insightTimeEstMedDesc => 'समय अनुमान में थोड़ा समायोजन करें';

  @override
  String get insightTimeEstLowDesc =>
      'वास्तविक समय रिकॉर्ड करके अनुमान सुधारें';

  @override
  String get insightTop3AllCompleteTitle => 'सभी Top 3 प्राप्त!';

  @override
  String get insightTop3AllCompleteDesc =>
      'सबसे महत्वपूर्ण कार्यों पर ध्यान दिया';

  @override
  String insightTop3PartialTitle(String completed) {
    return 'Top 3 में से $completed प्राप्त';
  }

  @override
  String insightTop3PartialDesc(String remaining) {
    return '$remaining और प्राप्त करें';
  }

  @override
  String get insightScoreGreatTitle => 'शानदार दिन!';

  @override
  String insightScoreGreatDesc(String score) {
    return 'उत्पादकता स्कोर $score अंक';
  }

  @override
  String get insightScoreNormalTitle => 'आज भी अच्छा काम किया';

  @override
  String insightScoreNormalDesc(String score) {
    return 'उत्पादकता स्कोर $score अंक';
  }

  @override
  String insightWeekAvgTitle(String score) {
    return 'साप्ताहिक औसत: $score अंक';
  }

  @override
  String get insightWeekAvgHighDesc => 'पूरे सप्ताह शानदार प्रदर्शन';

  @override
  String get insightWeekAvgLowDesc => 'अगला सप्ताह बेहतर होगा';

  @override
  String insightMonthAvgTitle(String score) {
    return 'मासिक औसत: $score अंक';
  }

  @override
  String get insightMonthAvgHighDesc => 'पूरे महीने लगातार अच्छा प्रदर्शन';

  @override
  String get insightMonthAvgLowDesc =>
      'लक्ष्य फिर से सेट करें और दोबारा शुरू करें';

  @override
  String insightMonthBestTitle(String month, String day) {
    return 'इस महीने का सर्वश्रेष्ठ दिन: $month/$day';
  }

  @override
  String insightMonthBestDesc(String score) {
    return 'उस दिन का स्कोर: $score अंक';
  }
}
