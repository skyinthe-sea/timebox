// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appName => 'Timebox Planner';

  @override
  String get inbox => 'Posteingang';

  @override
  String get calendar => 'Kalender';

  @override
  String get focus => 'Fokus';

  @override
  String get analytics => 'Analysen';

  @override
  String get settings => 'Einstellungen';

  @override
  String get task => 'Aufgabe';

  @override
  String get tasks => 'Aufgaben';

  @override
  String get addTask => 'Aufgabe hinzufügen';

  @override
  String get editTask => 'Aufgabe bearbeiten';

  @override
  String get deleteTask => 'Aufgabe löschen';

  @override
  String get taskTitle => 'Titel';

  @override
  String get taskNote => 'Notiz';

  @override
  String get estimatedDuration => 'Geschätzte Dauer';

  @override
  String get subtasks => 'Unteraufgaben';

  @override
  String get addSubtask => 'Unteraufgabe hinzufügen';

  @override
  String get priority => 'Priorität';

  @override
  String get priorityHigh => 'Hoch';

  @override
  String get priorityMedium => 'Mittel';

  @override
  String get priorityLow => 'Niedrig';

  @override
  String get status => 'Status';

  @override
  String get statusTodo => 'Zu erledigen';

  @override
  String get statusInProgress => 'In Bearbeitung';

  @override
  String get statusCompleted => 'Abgeschlossen';

  @override
  String get statusDelayed => 'Verzögert';

  @override
  String get statusSkipped => 'Übersprungen';

  @override
  String get tag => 'Tag';

  @override
  String get tags => 'Tags';

  @override
  String get addTag => 'Tag hinzufügen';

  @override
  String get tagWork => 'Arbeit';

  @override
  String get tagPersonal => 'Persönlich';

  @override
  String get tagHealth => 'Gesundheit';

  @override
  String get tagStudy => 'Lernen';

  @override
  String get selectTag => 'Tag auswählen';

  @override
  String get newTag => 'Neuer Tag';

  @override
  String get tagNameHint => 'Tag-Name';

  @override
  String get selectColor => 'Farbe wählen';

  @override
  String get timeBlock => 'Zeitblock';

  @override
  String get createTimeBlock => 'Zeitblock erstellen';

  @override
  String get moveTimeBlock => 'Zeitblock verschieben';

  @override
  String get resizeTimeBlock => 'Zeitblockgröße ändern';

  @override
  String get conflictDetected => 'Terminkonflikt erkannt';

  @override
  String get focusMode => 'Fokusmodus';

  @override
  String get startFocus => 'Fokus starten';

  @override
  String get pauseFocus => 'Pause';

  @override
  String get resumeFocus => 'Fortsetzen';

  @override
  String get completeFocus => 'Abschließen';

  @override
  String get skipFocus => 'Überspringen';

  @override
  String get timeRemaining => 'Verbleibende Zeit';

  @override
  String get today => 'Heute';

  @override
  String get tomorrow => 'Morgen';

  @override
  String get thisWeek => 'Diese Woche';

  @override
  String get minutes => 'Minuten';

  @override
  String get hours => 'Stunden';

  @override
  String minutesShort(int count) {
    return '${count}min';
  }

  @override
  String hoursShort(int count) {
    return '${count}h';
  }

  @override
  String get productivityScore => 'Produktivitätswert';

  @override
  String get plannedVsActual => 'Geplant vs Tatsächlich';

  @override
  String get completionRate => 'Abschlussrate';

  @override
  String get rolloverTasks => 'Übertragene Aufgaben';

  @override
  String get darkMode => 'Dunkelmodus';

  @override
  String get language => 'Sprache';

  @override
  String get notifications => 'Benachrichtigungen';

  @override
  String get calendarSync => 'Kalendersync';

  @override
  String get profile => 'Profil';

  @override
  String get logout => 'Abmelden';

  @override
  String get save => 'Speichern';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get delete => 'Löschen';

  @override
  String get confirm => 'Bestätigen';

  @override
  String get edit => 'Bearbeiten';

  @override
  String get done => 'Fertig';

  @override
  String get emptyInbox => 'Posteingang ist leer';

  @override
  String get emptyInboxDescription => 'Fügen Sie eine neue Aufgabe hinzu';

  @override
  String get emptyCalendar => 'Kein Zeitplan für heute';

  @override
  String get emptyCalendarDescription =>
      'Ziehen Sie Aufgaben, um Ihren Zeitplan zu erstellen';

  @override
  String get error => 'Fehler';

  @override
  String get errorGeneric => 'Etwas ist schiefgelaufen';

  @override
  String get errorNetwork => 'Bitte überprüfen Sie Ihre Netzwerkverbindung';

  @override
  String get retry => 'Erneut versuchen';

  @override
  String get noActiveSession => 'Keine aktive Sitzung';

  @override
  String get startFocusDescription =>
      'Starten Sie eine Fokussitzung, um Ihre Produktivität zu steigern';

  @override
  String get quickStart => 'Schnellstart';

  @override
  String get paused => 'Pausiert';

  @override
  String get skip => 'Überspringen';

  @override
  String get complete => 'Abschließen';

  @override
  String get sessionCompleted => 'Sitzung abgeschlossen!';

  @override
  String get selectDuration => 'Dauer auswählen';

  @override
  String get filter => 'Filter';

  @override
  String get all => 'Alle';

  @override
  String get statusDone => 'Erledigt';

  @override
  String get emptyInboxTitle => 'Posteingang ist leer';

  @override
  String get toDo => 'Zu erledigen';

  @override
  String get completed => 'Abgeschlossen';

  @override
  String get deleteTaskConfirm => 'Diese Aufgabe löschen?';

  @override
  String get taskTitleHint => 'Was müssen Sie tun?';

  @override
  String get lessOptions => 'Weniger Optionen';

  @override
  String get moreOptions => 'Mehr Optionen';

  @override
  String get taskNoteHint => 'Notiz hinzufügen...';

  @override
  String get title => 'Titel';

  @override
  String get timeBlockTitleHint => 'Blocknamen eingeben';

  @override
  String get startTime => 'Startzeit';

  @override
  String get endTime => 'Endzeit';

  @override
  String get add => 'Hinzufügen';

  @override
  String get top3 => 'Top 3 Prioritäten';

  @override
  String get rank1 => '1.';

  @override
  String get rank2 => '2.';

  @override
  String get rank3 => '3.';

  @override
  String get brainDump => 'Gedankensammlung';

  @override
  String get timeline => 'Zeitstrahl';

  @override
  String get dragToSchedule => 'Hierher ziehen zum Planen';

  @override
  String get emptyTop3Slot => 'Tippen oder ziehen zum Hinzufügen';

  @override
  String get dayStartTime => 'Tagesbeginn';

  @override
  String get dayEndTime => 'Tagesende';

  @override
  String get planner => 'Timebox';

  @override
  String get copyToTomorrow => 'Auf morgen verschieben';

  @override
  String get copiedToTomorrow => 'Auf morgen verschoben';

  @override
  String rolloverBadge(int count) {
    return 'Übertrag ${count}x';
  }

  @override
  String get appearance => 'Erscheinungsbild';

  @override
  String get theme => 'Design';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Hell';

  @override
  String get themeDark => 'Dunkel';

  @override
  String get notificationDescription => 'Zeitblock-Benachrichtigungen erhalten';

  @override
  String get notificationTiming => 'Benachrichtigungszeit';

  @override
  String minutesBefore(int count) {
    return '$count Min. vorher';
  }

  @override
  String get noCalendarConnected => 'Kein Kalender verbunden';

  @override
  String get comingSoon => 'Demnächst verfügbar';

  @override
  String get timeSettings => 'Zeiteinstellungen';

  @override
  String get dayTimeRange => 'Tageszeitbereich';

  @override
  String get defaultTimeBlockDuration => 'Standard-Zeitblockdauer';

  @override
  String get data => 'Daten';

  @override
  String get exportData => 'Daten exportieren';

  @override
  String get exportDataDescription => 'Als CSV-Datei exportieren';

  @override
  String get resetSettings => 'Einstellungen zurücksetzen';

  @override
  String get resetSettingsConfirm =>
      'Alle Einstellungen auf Standard zurücksetzen?';

  @override
  String get settingsReset => 'Einstellungen wurden zurückgesetzt';

  @override
  String get longPressToSelect => 'Lange drücken um Zeitbereich auszuwählen';

  @override
  String get selectTask => 'Aufgabe auswählen';

  @override
  String get noUnscheduledTasks => 'Keine ungeplanten Aufgaben';

  @override
  String get addNewTask => 'Neue Aufgabe hinzufügen';

  @override
  String get addNewTaskHint => 'Aufgabentitel eingeben...';

  @override
  String timeRangeLabel(String start, String end) {
    return '$start - $end';
  }

  @override
  String get assignToTimeBlock => 'Zeitblock zuweisen';

  @override
  String get mergeBlocks => 'Blöcke zusammenführen';

  @override
  String get overlapWarning => 'Warnung: Zeitblöcke überlappen sich';

  @override
  String get taskAssigned => 'Aufgabe zugewiesen';

  @override
  String get tapToCancel => 'Außerhalb tippen zum Abbrechen';

  @override
  String get statistics => 'Statistiken';

  @override
  String get todayHighlights => 'Highlights des Tages';

  @override
  String get completedTasksCount => 'Abgeschlossene Aufgaben';

  @override
  String get focusTimeMinutes => 'Fokuszeit';

  @override
  String get timeSavedMinutes => 'Eingesparte Zeit';

  @override
  String get top3Achievement => 'Top 3 Erreichung';

  @override
  String get trend => 'Produktivitätstrend';

  @override
  String get tagAnalysis => 'Tag-Analyse';

  @override
  String get insights => 'Einblicke';

  @override
  String get daily => 'Täglich';

  @override
  String get weekly => 'Wöchentlich';

  @override
  String get monthly => 'Monatlich';

  @override
  String get focusModeTooltip => 'Fokusmodus';

  @override
  String get startAlarm => 'Start-Alarm';

  @override
  String get endAlarm => 'End-Alarm';

  @override
  String get notifyBeforeStart => 'Vor dem Start benachrichtigen';

  @override
  String get notifyBeforeEnd => 'Vor dem Ende benachrichtigen';

  @override
  String get selectMultipleTimings => 'Mehrere Zeiten auswählbar';

  @override
  String get dailyReminder => 'Tägliche Erinnerung';

  @override
  String get dailyReminderDesc => 'Benachrichtigung an Tagen ohne App-Nutzung';

  @override
  String get dailyReminderTime => 'Erinnerungszeit';

  @override
  String get notificationPermissionRequired =>
      'Benachrichtigungsberechtigung erforderlich';

  @override
  String get notificationPermissionDesc =>
      'Bitte erlauben Sie Benachrichtigungen für Zeitblock-Alarme';

  @override
  String get openSettings => 'Einstellungen öffnen';

  @override
  String get permissionGranted => 'Berechtigung erteilt';

  @override
  String get permissionDenied => 'Berechtigung verweigert';

  @override
  String get requestPermission => 'Berechtigung anfordern';

  @override
  String hourBefore(int count) {
    return '${count}h vorher';
  }

  @override
  String get alarmSettings => 'Alarm-Einstellungen';

  @override
  String get alarmTimingNote => 'Mehrfachauswahl möglich';

  @override
  String get noonTime => 'Mittag (12:00)';

  @override
  String get mathChallenge => 'Mathe-Aufgabe';

  @override
  String mathChallengeProgress(int current, int total) {
    return '$current / $total';
  }

  @override
  String get enterAnswer => 'Antwort eingeben';

  @override
  String get wrongAnswer => 'Falsch. Bitte erneut versuchen.';

  @override
  String get focusLockEnabled => 'Bildschirmsperre aktiviert';

  @override
  String get overlayPermissionRequired => 'Overlay-Berechtigung erforderlich';

  @override
  String get noActiveTimeBlock => 'Kein aktiver Zeitblock';

  @override
  String get createTimeBlockFirst =>
      'Erstellen Sie zuerst einen Zeitblock im Kalender';

  @override
  String get exitFocus => 'Beenden';

  @override
  String get statsCompletionRates => 'Abschlussraten';

  @override
  String get statsTaskPipeline => 'Aufgabenfluss';

  @override
  String get statsPlanVsActual => 'Geplant vs Tatsächlich';

  @override
  String get statsPriorityBreakdown => 'Leistung nach Priorität';

  @override
  String get statsFocusSummary => 'Fokus-Analyse';

  @override
  String get statsTopInsights => 'Einblicke';

  @override
  String get statsScheduled => 'Geplant';

  @override
  String get statsCompleted => 'Abgeschlossen';

  @override
  String get statsRolledOver => 'Übertragen';

  @override
  String get statsEfficiency => 'Genauigkeit';

  @override
  String get statsAccomplished => 'Erreicht';

  @override
  String get statsNoData => 'Noch keine Daten';

  @override
  String get statsTop3Performance => 'Top 3 Erreichung';

  @override
  String get statsTop3Completed => 'Abgeschlossen';

  @override
  String get statsTop3Days => 'Tage mit Top 3';

  @override
  String get statsTop3PerfectDays => 'Perfekte Tage';

  @override
  String get statsTop3Daily => 'Täglicher Fortschritt';

  @override
  String get days => ' Tage';

  @override
  String get navTimeline => 'Zeitachse';

  @override
  String get navReport => 'Bericht';

  @override
  String get suggestedTasks => 'Vorschläge';

  @override
  String get taskSuggestionsHint => 'Aufgaben, die Sie zuvor erledigt haben';

  @override
  String get topSuccessTasks => 'Am häufigsten erledigte Aufgaben';

  @override
  String get topFailureTasks => 'Schwer zu erledigende Aufgaben';

  @override
  String get completionCount => 'Erledigungsanzahl';

  @override
  String get taskRankings => 'Aufgabenranking';

  @override
  String get privacyPolicy => 'Datenschutzrichtlinie';

  @override
  String get termsOfService => 'Nutzungsbedingungen';

  @override
  String get privacyPolicyContent =>
      'Datenschutzrichtlinie\n\nLetzte Aktualisierung: 1. Januar 2026\n\n1. Datenerfassung\nDiese App verarbeitet vom Benutzer eingegebene Daten wie Aufgaben und Zeitaufzeichnungen.\n\n2. Datenspeicherung\nAlle Daten werden nur lokal auf Ihrem Gerät gespeichert. Es werden keine Daten an externe Server übertragen.\n\n3. Dritte\nDiese App verwendet Google AdMob für Werbung. AdMob kann Werbe-Identifikatoren erfassen. Weitere Informationen finden Sie in der Datenschutzrichtlinie von Google.\n\n4. Datenlöschung\nAlle auf dem Gerät gespeicherten Daten werden automatisch gelöscht, wenn Sie die App deinstallieren.\n\n5. Kontakt\nFür Datenschutzanfragen: myclick90@gmail.com';

  @override
  String get termsOfServiceContent =>
      'Nutzungsbedingungen\n\nLetzte Aktualisierung: 1. Januar 2026\n\n1. Dienstbeschreibung\nTimebox Planner ist eine mobile Anwendung, die Ihnen bei der Zeitverwaltung und Terminplanung hilft.\n\n2. Benutzerverantwortung\nBenutzer sind für alle in die App eingegebenen Daten verantwortlich und dürfen die App nur für rechtmäßige Zwecke nutzen.\n\n3. Haftungsausschluss\nDiese App wird wie besehen bereitgestellt. Der Entwickler haftet nicht für direkte oder indirekte Schäden durch Datenverlust, verpasste Termine oder andere Probleme.\n\n4. Geistiges Eigentum\nAlle geistigen Eigentumsrechte am Design, Code und Inhalt der App gehören dem Entwickler.\n\n5. Änderungen der Bedingungen\nDiese Bedingungen können mit vorheriger Ankündigung geändert werden. Änderungen werden über App-Updates mitgeteilt.';

  @override
  String durationFormat(int hours, int minutes) {
    return '${hours}h ${minutes}min';
  }

  @override
  String get previousDay => 'Vorheriger Tag';

  @override
  String get nextDay => 'Nächster Tag';

  @override
  String get noTitle => 'Ohne Titel';

  @override
  String get incomplete => 'Unvollständig';

  @override
  String get revert => 'Rückgängig';

  @override
  String get statusChange => 'Statusänderung';

  @override
  String get timeBlockResult => 'Zeitblock-Ergebnis';

  @override
  String get reverted => 'Rückgängig gemacht';

  @override
  String get markedComplete => 'Als abgeschlossen markiert';

  @override
  String get markedIncomplete => 'Als unvollständig markiert';

  @override
  String get deleteTimeBlock => 'Zeitblock löschen';

  @override
  String get deleteTimeBlockConfirm => 'Diesen Zeitblock wirklich löschen?';

  @override
  String get removeFromTop3 => 'Aus Top 3 entfernen';

  @override
  String scoreUp(int change) {
    return '+$change gegenüber gestern!';
  }

  @override
  String scoreDown(int change) {
    return '-$change gegenüber gestern';
  }

  @override
  String get scoreSame => 'Gleich wie gestern';

  @override
  String get average => 'Ø';

  @override
  String get dailyReminderTitle => 'Plane deinen Tag!';

  @override
  String get dailyReminderBody => 'Der erste Schritt zu deinen Zielen.';

  @override
  String get monday => 'Montag';

  @override
  String get tuesday => 'Dienstag';

  @override
  String get wednesday => 'Mittwoch';

  @override
  String get thursday => 'Donnerstag';

  @override
  String get friday => 'Freitag';

  @override
  String get saturday => 'Samstag';

  @override
  String get sunday => 'Sonntag';

  @override
  String get insightPeriodYesterday => 'gestern';

  @override
  String get insightPeriodToday => 'heute';

  @override
  String get insightPeriodWeekFirstHalf => 'die erste Wochenhälfte';

  @override
  String insightFocusTimeTitle(String dayName, String hour) {
    return 'Höchste Konzentration um $hour Uhr am $dayName';
  }

  @override
  String get insightFocusTimeDesc => 'Plane wichtige Aufgaben in dieser Zeit';

  @override
  String insightTagAccuracyFasterTitle(String tagName, String minutes) {
    return '$tagName-Aufgaben ${minutes}min schneller erledigt';
  }

  @override
  String insightTagAccuracySlowerTitle(String tagName, String minutes) {
    return '$tagName-Aufgaben brauchten ${minutes}min länger';
  }

  @override
  String get insightTagAccuracyFasterDesc =>
      'Deine Zeitschätzungen werden genauer';

  @override
  String get insightTagAccuracySlowerDesc =>
      'Plane mehr Zeit für diese Art von Aufgabe ein';

  @override
  String insightRolloverTitle(String rolloverCount, String taskCount) {
    return '$rolloverCount von $taskCount Aufgaben wurden übertragen';
  }

  @override
  String get insightRolloverDesc =>
      'Teile Aufgaben auf oder setze neue Prioritäten';

  @override
  String insightStreakTitle(String days) {
    return '$days Tage in Folge geplant!';
  }

  @override
  String get insightStreakDesc => 'Beständigkeit ist der Schlüssel zum Erfolg';

  @override
  String insightScoreUpTitle(String period, String scoreDiff) {
    return 'Produktivität $scoreDiff Punkte höher als $period';
  }

  @override
  String get insightScoreUpDesc => 'Weiter so!';

  @override
  String insightScoreDownTitle(String period, String scoreDiff) {
    return 'Produktivität $scoreDiff Punkte niedriger als $period';
  }

  @override
  String get insightScoreDownDesc => 'Passe deinen Plan etwas an';

  @override
  String insightBestDayTitle(String dayName) {
    return '$dayName ist dein produktivster Tag';
  }

  @override
  String insightBestDayDesc(String score) {
    return 'Durchschnittliche Punktzahl: $score';
  }

  @override
  String insightTimeSavedTitle(String period, String minutes) {
    return '${minutes}min gespart gegenüber $period-Plan';
  }

  @override
  String get insightTimeSavedDesc => 'Dein Zeitmanagement ist effizient';

  @override
  String insightTimeOverTitle(String period, String minutes) {
    return '${minutes}min über $period-Plan';
  }

  @override
  String get insightTimeOverDesc => 'Versuche großzügigere Zeitschätzungen';

  @override
  String get insightTaskFirstTitle => 'Erste Aufgabe des Tages erledigt!';

  @override
  String get insightTaskFirstDesc => 'Guter Start';

  @override
  String get insightTaskAllCompleteTitle => 'Alle Aufgaben erledigt!';

  @override
  String insightTaskAllCompleteDesc(String total) {
    return 'Alle $total Aufgaben geschafft';
  }

  @override
  String get insightTaskNoneTitle => 'Noch keine Aufgabe erledigt';

  @override
  String get insightTaskNoneDesc => 'Fang klein an';

  @override
  String insightTaskPartialTitle(String total, String completed) {
    return '$completed von $total Aufgaben erledigt';
  }

  @override
  String insightTaskPartialDesc(String remaining) {
    return 'Noch $remaining, weiter so!';
  }

  @override
  String insightFocusEffTitle(String percent) {
    return 'Fokus-Effizienz: $percent%';
  }

  @override
  String get insightFocusEffHighDesc => 'Hohe Konzentration beibehalten';

  @override
  String get insightFocusEffMedDesc => 'Konzentration auf mittlerem Niveau';

  @override
  String get insightFocusEffLowDesc => 'Verbessere deine Fokus-Umgebung';

  @override
  String insightTimeEstTitle(String percent) {
    return 'Zeitschätzungs-Genauigkeit: $percent%';
  }

  @override
  String get insightTimeEstHighDesc => 'Deine Zeitschätzungen sind genau';

  @override
  String get insightTimeEstMedDesc => 'Passe deine Zeitschätzungen an';

  @override
  String get insightTimeEstLowDesc =>
      'Notiere die tatsächliche Zeit zur Verbesserung';

  @override
  String get insightTop3AllCompleteTitle => 'Alle Top 3 erreicht!';

  @override
  String get insightTop3AllCompleteDesc => 'Auf das Wichtigste konzentriert';

  @override
  String insightTop3PartialTitle(String completed) {
    return '$completed von Top 3 erreicht';
  }

  @override
  String insightTop3PartialDesc(String remaining) {
    return 'Noch $remaining zu erreichen';
  }

  @override
  String get insightScoreGreatTitle => 'Was für ein toller Tag!';

  @override
  String insightScoreGreatDesc(String score) {
    return 'Produktivitätswert: $score';
  }

  @override
  String get insightScoreNormalTitle => 'Gute Arbeit heute';

  @override
  String insightScoreNormalDesc(String score) {
    return 'Produktivitätswert: $score';
  }

  @override
  String insightWeekAvgTitle(String score) {
    return 'Wochendurchschnitt: $score Punkte';
  }

  @override
  String get insightWeekAvgHighDesc => 'Tolle Leistung die ganze Woche';

  @override
  String get insightWeekAvgLowDesc => 'Nächste Woche wird besser';

  @override
  String insightMonthAvgTitle(String score) {
    return 'Monatsdurchschnitt: $score Punkte';
  }

  @override
  String get insightMonthAvgHighDesc => 'Konstante Leistung den ganzen Monat';

  @override
  String get insightMonthAvgLowDesc => 'Setze neue Ziele und starte neu';

  @override
  String insightMonthBestTitle(String month, String day) {
    return 'Bester Tag des Monats: $day.$month.';
  }

  @override
  String insightMonthBestDesc(String score) {
    return 'Punktzahl an dem Tag: $score';
  }

  @override
  String get demoMode => 'Demo-Modus';

  @override
  String get demoModeDescription => 'Beispieldaten für App Store Screenshots';

  @override
  String get demoModeEnable => 'Demo-Modus aktivieren';

  @override
  String get demoModeDisable => 'Demo-Modus deaktivieren';

  @override
  String get demoModeEnabled => 'Demo-Modus aktiviert';

  @override
  String get demoModeDisabled => 'Demo-Modus deaktiviert';

  @override
  String get demoModeGenerating => 'Beispieldaten werden erstellt...';

  @override
  String get demoModeClearing => 'Demo-Daten werden gelöscht...';

  @override
  String timeBlockStartAlarmTitle(String title, String time) {
    return '$title - $time vor Beginn';
  }

  @override
  String get timeBlockStartAlarmBody => 'Beginnt bald. Mach dich bereit!';

  @override
  String timeBlockEndAlarmTitle(String title, String time) {
    return '$title - $time vor Ende';
  }

  @override
  String get timeBlockEndAlarmBody => 'Zeit zum Abschließen.';

  @override
  String get focusSessionCompleteTitle => 'Fokus-Sitzung abgeschlossen!';

  @override
  String get focusSessionCompleteBody => 'Gute Arbeit! Mach eine kurze Pause.';

  @override
  String get statDescProductivityScoreTitle => 'Produktivitätswert';

  @override
  String get statDescProductivityScoreBody =>
      'Ein 0–100 Score aus Abschlussrate, Zeitgenauigkeit und Zeitblock-Ausführung.';

  @override
  String get statDescCompletionRingsTitle => 'Abschlussringe';

  @override
  String get statDescCompletionRingsBody =>
      'Zeigt Aufgaben-Abschlussrate, Zeitblock-Ausführungsrate und Zeitgenauigkeit.';

  @override
  String get statDescTaskPipelineTitle => 'Aufgabenfluss';

  @override
  String get statDescTaskPipelineBody =>
      'Zeigt den Fluss von Gesamt → Geplant → Abgeschlossen → Übertragen.';

  @override
  String get statDescTop3StatsTitle => 'Top 3 Erreichung';

  @override
  String get statDescTop3StatsBody =>
      'Zeigt den Erreichungsstatus deiner 3 wichtigsten Aufgaben.';

  @override
  String get statDescTaskRankingTitle => 'Aufgabenranking';

  @override
  String get statDescTaskRankingBody =>
      'Rankt wiederkehrende Aufgaben nach Abschluss-Erfolg/-Misserfolg.';

  @override
  String get statDescFocusSummaryTitle => 'Fokus-Analyse';

  @override
  String get statDescFocusSummaryBody =>
      'Fokus-Effizienz, Zeit, Sitzungsanzahl und Pausendauer.';

  @override
  String get statDescTrendChartTitle => 'Produktivitätstrend';

  @override
  String get statDescTrendChartBody =>
      'Zeigt tägliche Produktivitätswert-Änderungen als Liniendiagramm.';

  @override
  String get statDescTagAnalysisTitle => 'Tag-Analyse';

  @override
  String get statDescTagAnalysisBody =>
      'Zeigt Aufgabenanzahl und geplante Zeit nach Tag.';

  @override
  String get statDescInsightsTitle => 'Einblicke';

  @override
  String get statDescInsightsBody =>
      'Automatisch generierte Leistungsanalyse basierend auf deinen Daten.';
}
