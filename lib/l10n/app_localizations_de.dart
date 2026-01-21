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
  String get planner => 'Planer';

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
}
