// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appName => 'Timebox Planner';

  @override
  String get inbox => 'Boîte de réception';

  @override
  String get calendar => 'Calendrier';

  @override
  String get focus => 'Concentration';

  @override
  String get analytics => 'Analyses';

  @override
  String get settings => 'Paramètres';

  @override
  String get task => 'Tâche';

  @override
  String get tasks => 'Tâches';

  @override
  String get addTask => 'Ajouter une tâche';

  @override
  String get editTask => 'Modifier la tâche';

  @override
  String get deleteTask => 'Supprimer la tâche';

  @override
  String get taskTitle => 'Titre';

  @override
  String get taskNote => 'Note';

  @override
  String get estimatedDuration => 'Durée estimée';

  @override
  String get subtasks => 'Sous-tâches';

  @override
  String get addSubtask => 'Ajouter une sous-tâche';

  @override
  String get priority => 'Priorité';

  @override
  String get priorityHigh => 'Haute';

  @override
  String get priorityMedium => 'Moyenne';

  @override
  String get priorityLow => 'Basse';

  @override
  String get status => 'Statut';

  @override
  String get statusTodo => 'À faire';

  @override
  String get statusInProgress => 'En cours';

  @override
  String get statusCompleted => 'Terminé';

  @override
  String get statusDelayed => 'Retardé';

  @override
  String get statusSkipped => 'Ignoré';

  @override
  String get tag => 'Étiquette';

  @override
  String get tags => 'Étiquettes';

  @override
  String get addTag => 'Ajouter une étiquette';

  @override
  String get timeBlock => 'Bloc de temps';

  @override
  String get createTimeBlock => 'Créer un bloc de temps';

  @override
  String get moveTimeBlock => 'Déplacer le bloc de temps';

  @override
  String get resizeTimeBlock => 'Redimensionner le bloc de temps';

  @override
  String get conflictDetected => 'Conflit d\'horaire détecté';

  @override
  String get focusMode => 'Mode concentration';

  @override
  String get startFocus => 'Démarrer la concentration';

  @override
  String get pauseFocus => 'Pause';

  @override
  String get resumeFocus => 'Reprendre';

  @override
  String get completeFocus => 'Terminer';

  @override
  String get skipFocus => 'Passer';

  @override
  String get timeRemaining => 'Temps restant';

  @override
  String get today => 'Aujourd\'hui';

  @override
  String get tomorrow => 'Demain';

  @override
  String get thisWeek => 'Cette semaine';

  @override
  String get minutes => 'minutes';

  @override
  String get hours => 'heures';

  @override
  String minutesShort(int count) {
    return '${count}min';
  }

  @override
  String hoursShort(int count) {
    return '${count}h';
  }

  @override
  String get productivityScore => 'Score de productivité';

  @override
  String get plannedVsActual => 'Planifié vs Réel';

  @override
  String get completionRate => 'Taux de complétion';

  @override
  String get rolloverTasks => 'Tâches reportées';

  @override
  String get darkMode => 'Mode sombre';

  @override
  String get language => 'Langue';

  @override
  String get notifications => 'Notifications';

  @override
  String get calendarSync => 'Sync. calendrier';

  @override
  String get profile => 'Profil';

  @override
  String get logout => 'Déconnexion';

  @override
  String get save => 'Enregistrer';

  @override
  String get cancel => 'Annuler';

  @override
  String get delete => 'Supprimer';

  @override
  String get confirm => 'Confirmer';

  @override
  String get edit => 'Modifier';

  @override
  String get done => 'Terminé';

  @override
  String get emptyInbox => 'La boîte de réception est vide';

  @override
  String get emptyInboxDescription =>
      'Ajoutez une nouvelle tâche pour commencer';

  @override
  String get emptyCalendar => 'Aucun planning pour aujourd\'hui';

  @override
  String get emptyCalendarDescription =>
      'Glissez des tâches pour créer votre planning';

  @override
  String get error => 'Erreur';

  @override
  String get errorGeneric => 'Une erreur s\'est produite';

  @override
  String get errorNetwork => 'Vérifiez votre connexion réseau';

  @override
  String get retry => 'Réessayer';
}
