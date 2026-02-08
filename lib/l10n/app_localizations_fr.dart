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
  String get tagWork => 'Travail';

  @override
  String get tagPersonal => 'Personnel';

  @override
  String get tagHealth => 'Santé';

  @override
  String get tagStudy => 'Études';

  @override
  String get selectTag => 'Choisir une étiquette';

  @override
  String get newTag => 'Nouvelle étiquette';

  @override
  String get tagNameHint => 'Nom de l\'étiquette';

  @override
  String get selectColor => 'Choisir une couleur';

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

  @override
  String get noActiveSession => 'Aucune session active';

  @override
  String get startFocusDescription =>
      'Démarrez une session de concentration pour augmenter votre productivité';

  @override
  String get quickStart => 'Démarrage rapide';

  @override
  String get paused => 'En pause';

  @override
  String get skip => 'Passer';

  @override
  String get complete => 'Terminer';

  @override
  String get sessionCompleted => 'Session terminée !';

  @override
  String get selectDuration => 'Sélectionner la durée';

  @override
  String get filter => 'Filtrer';

  @override
  String get all => 'Tout';

  @override
  String get statusDone => 'Fait';

  @override
  String get emptyInboxTitle => 'La boîte de réception est vide';

  @override
  String get toDo => 'À faire';

  @override
  String get completed => 'Terminé';

  @override
  String get deleteTaskConfirm => 'Supprimer cette tâche ?';

  @override
  String get taskTitleHint => 'Que devez-vous faire ?';

  @override
  String get lessOptions => 'Moins d\'options';

  @override
  String get moreOptions => 'Plus d\'options';

  @override
  String get taskNoteHint => 'Ajouter une note...';

  @override
  String get title => 'Titre';

  @override
  String get timeBlockTitleHint => 'Entrer le nom du bloc';

  @override
  String get startTime => 'Heure de début';

  @override
  String get endTime => 'Heure de fin';

  @override
  String get add => 'Ajouter';

  @override
  String get top3 => 'Top 3 Priorités';

  @override
  String get rank1 => '1er';

  @override
  String get rank2 => '2ème';

  @override
  String get rank3 => '3ème';

  @override
  String get brainDump => 'Vidage Cérébral';

  @override
  String get timeline => 'Chronologie';

  @override
  String get dragToSchedule => 'Glissez pour planifier';

  @override
  String get emptyTop3Slot => 'Appuyez ou glissez pour ajouter';

  @override
  String get dayStartTime => 'Heure de début de journée';

  @override
  String get dayEndTime => 'Heure de fin de journée';

  @override
  String get planner => 'Timebox';

  @override
  String get copyToTomorrow => 'Reporter à demain';

  @override
  String get copiedToTomorrow => 'Reporté à demain';

  @override
  String rolloverBadge(int count) {
    return 'Report ${count}x';
  }

  @override
  String get appearance => 'Apparence';

  @override
  String get theme => 'Thème';

  @override
  String get themeSystem => 'Système';

  @override
  String get themeLight => 'Clair';

  @override
  String get themeDark => 'Sombre';

  @override
  String get notificationDescription =>
      'Recevoir les notifications de blocs de temps';

  @override
  String get notificationTiming => 'Délai de notification';

  @override
  String minutesBefore(int count) {
    return '$count min avant';
  }

  @override
  String get noCalendarConnected => 'Aucun calendrier connecté';

  @override
  String get comingSoon => 'Bientôt disponible';

  @override
  String get timeSettings => 'Paramètres de temps';

  @override
  String get dayTimeRange => 'Plage horaire de la journée';

  @override
  String get defaultTimeBlockDuration => 'Durée par défaut du bloc de temps';

  @override
  String get data => 'Données';

  @override
  String get exportData => 'Exporter les données';

  @override
  String get exportDataDescription => 'Exporter en fichier CSV';

  @override
  String get resetSettings => 'Réinitialiser les paramètres';

  @override
  String get resetSettingsConfirm =>
      'Réinitialiser tous les paramètres par défaut ?';

  @override
  String get settingsReset => 'Les paramètres ont été réinitialisés';

  @override
  String get longPressToSelect =>
      'Appuyez longuement pour sélectionner une plage horaire';

  @override
  String get selectTask => 'Sélectionner une tâche';

  @override
  String get noUnscheduledTasks => 'Aucune tâche non planifiée';

  @override
  String get addNewTask => 'Ajouter une nouvelle tâche';

  @override
  String get addNewTaskHint => 'Entrer le titre de la tâche...';

  @override
  String timeRangeLabel(String start, String end) {
    return '$start - $end';
  }

  @override
  String get assignToTimeBlock => 'Assigner au bloc de temps';

  @override
  String get mergeBlocks => 'Fusionner les blocs';

  @override
  String get overlapWarning => 'Attention : Les blocs de temps se chevauchent';

  @override
  String get taskAssigned => 'Tâche assignée';

  @override
  String get tapToCancel => 'Appuyez à l\'extérieur pour annuler';

  @override
  String get statistics => 'Statistiques';

  @override
  String get todayHighlights => 'Points forts du jour';

  @override
  String get completedTasksCount => 'Tâches terminées';

  @override
  String get focusTimeMinutes => 'Temps de concentration';

  @override
  String get timeSavedMinutes => 'Temps économisé';

  @override
  String get top3Achievement => 'Top 3 atteint';

  @override
  String get trend => 'Tendance de productivité';

  @override
  String get tagAnalysis => 'Analyse par étiquette';

  @override
  String get insights => 'Analyses';

  @override
  String get daily => 'Quotidien';

  @override
  String get weekly => 'Hebdomadaire';

  @override
  String get monthly => 'Mensuel';

  @override
  String get focusModeTooltip => 'Mode concentration';

  @override
  String get startAlarm => 'Alarme de début';

  @override
  String get endAlarm => 'Alarme de fin';

  @override
  String get notifyBeforeStart => 'Notifier avant le début';

  @override
  String get notifyBeforeEnd => 'Notifier avant la fin';

  @override
  String get selectMultipleTimings => 'Sélection multiple possible';

  @override
  String get dailyReminder => 'Rappel quotidien';

  @override
  String get dailyReminderDesc =>
      'Notification les jours sans utilisation de l\'app';

  @override
  String get dailyReminderTime => 'Heure du rappel';

  @override
  String get notificationPermissionRequired =>
      'Permission de notification requise';

  @override
  String get notificationPermissionDesc =>
      'Veuillez autoriser les notifications pour les alertes de bloc de temps';

  @override
  String get openSettings => 'Ouvrir les paramètres';

  @override
  String get permissionGranted => 'Permission accordée';

  @override
  String get permissionDenied => 'Permission refusée';

  @override
  String get requestPermission => 'Demander la permission';

  @override
  String hourBefore(int count) {
    return '${count}h avant';
  }

  @override
  String get alarmSettings => 'Paramètres d\'alarme';

  @override
  String get alarmTimingNote => 'Sélection multiple possible';

  @override
  String get noonTime => 'Midi (12:00)';

  @override
  String get mathChallenge => 'Défi mathématique';

  @override
  String mathChallengeProgress(int current, int total) {
    return '$current / $total';
  }

  @override
  String get enterAnswer => 'Entrez la réponse';

  @override
  String get wrongAnswer => 'Incorrect. Veuillez réessayer.';

  @override
  String get focusLockEnabled => 'Verrouillage d\'écran activé';

  @override
  String get overlayPermissionRequired => 'Permission de superposition requise';

  @override
  String get noActiveTimeBlock => 'Aucun bloc de temps actif';

  @override
  String get createTimeBlockFirst =>
      'Créez d\'abord un bloc de temps dans le calendrier';

  @override
  String get exitFocus => 'Quitter';

  @override
  String get statsCompletionRates => 'Taux de complétion';

  @override
  String get statsTaskPipeline => 'Flux de tâches';

  @override
  String get statsPlanVsActual => 'Planifié vs Réel';

  @override
  String get statsPriorityBreakdown => 'Performance par priorité';

  @override
  String get statsFocusSummary => 'Analyse de concentration';

  @override
  String get statsTopInsights => 'Analyses';

  @override
  String get statsScheduled => 'Planifié';

  @override
  String get statsCompleted => 'Terminé';

  @override
  String get statsRolledOver => 'Reporté';

  @override
  String get statsEfficiency => 'Précision';

  @override
  String get statsAccomplished => 'Atteint';

  @override
  String get statsNoData => 'Pas encore de données';

  @override
  String get statsTop3Performance => 'Réalisation Top 3';

  @override
  String get statsTop3Completed => 'Terminé';

  @override
  String get statsTop3Days => 'Jours avec Top 3';

  @override
  String get statsTop3PerfectDays => 'Jours parfaits';

  @override
  String get statsTop3Daily => 'Progression quotidienne';

  @override
  String get days => ' jours';

  @override
  String get navTimeline => 'Chronologie';

  @override
  String get navReport => 'Rapport';

  @override
  String get suggestedTasks => 'Suggestions';

  @override
  String get taskSuggestionsHint => 'Tâches que vous avez déjà effectuées';

  @override
  String get topSuccessTasks => 'Tâches les plus complétées';

  @override
  String get topFailureTasks => 'Tâches les plus difficiles';

  @override
  String get completionCount => 'Nombre de complétions';

  @override
  String get taskRankings => 'Classement des tâches';

  @override
  String get privacyPolicy => 'Politique de confidentialité';

  @override
  String get termsOfService => 'Conditions d\'utilisation';

  @override
  String get privacyPolicyContent =>
      'Politique de confidentialité\n\nDernière mise à jour : 1er janvier 2026\n\n1. Collecte de données\nCette application traite les données saisies par l\'utilisateur, telles que les tâches et les enregistrements de temps.\n\n2. Stockage des données\nToutes les données sont stockées localement sur votre appareil uniquement. Aucune donnée n\'est transmise à des serveurs externes.\n\n3. Tiers\nCette application utilise Google AdMob pour la publicité. AdMob peut collecter des identifiants publicitaires. Veuillez consulter la politique de confidentialité de Google pour plus de détails.\n\n4. Suppression des données\nToutes les données stockées sur l\'appareil sont automatiquement supprimées lorsque vous désinstallez l\'application.\n\n5. Contact\nPour les questions de confidentialité : myclick90@gmail.com';

  @override
  String get termsOfServiceContent =>
      'Conditions d\'utilisation\n\nDernière mise à jour : 1er janvier 2026\n\n1. Description du service\nTimebox Planner est une application mobile qui vous aide à gérer votre temps et planifier votre emploi du temps.\n\n2. Responsabilités de l\'utilisateur\nLes utilisateurs sont responsables de toutes les données saisies dans l\'application et doivent utiliser l\'application uniquement à des fins légales.\n\n3. Clause de non-responsabilité\nCette application est fournie telle quelle. Le développeur n\'est pas responsable des dommages directs ou indirects causés par la perte de données, les rendez-vous manqués ou d\'autres problèmes.\n\n4. Propriété intellectuelle\nTous les droits de propriété intellectuelle relatifs au design, au code et au contenu de l\'application appartiennent au développeur.\n\n5. Modification des conditions\nCes conditions peuvent être modifiées avec un préavis. Les changements seront communiqués par le biais des mises à jour de l\'application.';

  @override
  String durationFormat(int hours, int minutes) {
    return '${hours}h ${minutes}min';
  }

  @override
  String get previousDay => 'Jour précédent';

  @override
  String get nextDay => 'Jour suivant';

  @override
  String get noTitle => 'Sans titre';

  @override
  String get incomplete => 'Incomplet';

  @override
  String get revert => 'Annuler';

  @override
  String get statusChange => 'Changement de statut';

  @override
  String get timeBlockResult => 'Résultat du bloc de temps';

  @override
  String get reverted => 'Annulé';

  @override
  String get markedComplete => 'Marqué comme terminé';

  @override
  String get markedIncomplete => 'Marqué comme incomplet';

  @override
  String get deleteTimeBlock => 'Supprimer le bloc de temps';

  @override
  String get deleteTimeBlockConfirm =>
      'Voulez-vous supprimer ce bloc de temps ?';

  @override
  String get removeFromTop3 => 'Retirer du Top 3';

  @override
  String scoreUp(int change) {
    return '+$change par rapport à hier !';
  }

  @override
  String scoreDown(int change) {
    return '-$change par rapport à hier';
  }

  @override
  String get scoreSame => 'Identique à hier';

  @override
  String get average => 'moy';

  @override
  String get dailyReminderTitle => 'Planifiez votre journée !';

  @override
  String get dailyReminderBody => 'Le premier pas vers vos objectifs.';

  @override
  String get monday => 'Lundi';

  @override
  String get tuesday => 'Mardi';

  @override
  String get wednesday => 'Mercredi';

  @override
  String get thursday => 'Jeudi';

  @override
  String get friday => 'Vendredi';

  @override
  String get saturday => 'Samedi';

  @override
  String get sunday => 'Dimanche';

  @override
  String get insightPeriodYesterday => 'hier';

  @override
  String get insightPeriodToday => 'aujourd\'hui';

  @override
  String get insightPeriodWeekFirstHalf => 'la première moitié de la semaine';

  @override
  String insightFocusTimeTitle(String dayName, String hour) {
    return 'Pic de concentration à ${hour}h le $dayName';
  }

  @override
  String get insightFocusTimeDesc =>
      'Planifiez les tâches importantes pendant ce créneau';

  @override
  String insightTagAccuracyFasterTitle(String tagName, String minutes) {
    return 'Tâches $tagName terminées ${minutes}min plus vite';
  }

  @override
  String insightTagAccuracySlowerTitle(String tagName, String minutes) {
    return 'Tâches $tagName ont pris ${minutes}min de plus';
  }

  @override
  String get insightTagAccuracyFasterDesc =>
      'Vos estimations de temps deviennent plus précises';

  @override
  String get insightTagAccuracySlowerDesc =>
      'Essayez d\'allouer plus de temps pour ce type de tâche';

  @override
  String insightRolloverTitle(String rolloverCount, String taskCount) {
    return '$rolloverCount sur $taskCount tâches reportées';
  }

  @override
  String get insightRolloverDesc =>
      'Essayez de diviser les tâches ou de reprioriser';

  @override
  String insightStreakTitle(String days) {
    return '$days jours consécutifs de planification !';
  }

  @override
  String get insightStreakDesc => 'La régularité est la clé du succès';

  @override
  String insightScoreUpTitle(String period, String scoreDiff) {
    return 'Productivité en hausse de $scoreDiff pts vs $period';
  }

  @override
  String get insightScoreUpDesc => 'Continuez sur cette lancée !';

  @override
  String insightScoreDownTitle(String period, String scoreDiff) {
    return 'Productivité en baisse de $scoreDiff pts vs $period';
  }

  @override
  String get insightScoreDownDesc => 'Essayez d\'ajuster votre planning';

  @override
  String insightBestDayTitle(String dayName) {
    return '$dayName est votre jour le plus productif';
  }

  @override
  String insightBestDayDesc(String score) {
    return 'Score moyen : $score pts';
  }

  @override
  String insightTimeSavedTitle(String period, String minutes) {
    return '${minutes}min économisées vs plan $period';
  }

  @override
  String get insightTimeSavedDesc => 'Votre gestion du temps est efficace';

  @override
  String insightTimeOverTitle(String period, String minutes) {
    return '${minutes}min de dépassement vs plan $period';
  }

  @override
  String get insightTimeOverDesc =>
      'Essayez des estimations de temps plus généreuses';

  @override
  String get insightTaskFirstTitle => 'Première tâche du jour terminée !';

  @override
  String get insightTaskFirstDesc => 'Bon début';

  @override
  String get insightTaskAllCompleteTitle => 'Toutes les tâches terminées !';

  @override
  String insightTaskAllCompleteDesc(String total) {
    return '$total tâches accomplies';
  }

  @override
  String get insightTaskNoneTitle => 'Aucune tâche terminée';

  @override
  String get insightTaskNoneDesc => 'Commencez par quelque chose de simple';

  @override
  String insightTaskPartialTitle(String total, String completed) {
    return '$completed sur $total tâches terminées';
  }

  @override
  String insightTaskPartialDesc(String remaining) {
    return 'Plus que $remaining, courage !';
  }

  @override
  String insightFocusEffTitle(String percent) {
    return 'Efficacité de concentration : $percent%';
  }

  @override
  String get insightFocusEffHighDesc => 'Concentration élevée maintenue';

  @override
  String get insightFocusEffMedDesc => 'Niveau de concentration moyen';

  @override
  String get insightFocusEffLowDesc =>
      'Améliorez votre environnement de concentration';

  @override
  String insightTimeEstTitle(String percent) {
    return 'Précision des estimations : $percent%';
  }

  @override
  String get insightTimeEstHighDesc => 'Vos estimations sont précises';

  @override
  String get insightTimeEstMedDesc => 'Ajustez vos estimations de temps';

  @override
  String get insightTimeEstLowDesc =>
      'Notez le temps réel pour améliorer les estimations';

  @override
  String get insightTop3AllCompleteTitle => 'Top 3 atteint !';

  @override
  String get insightTop3AllCompleteDesc => 'Concentré sur l\'essentiel';

  @override
  String insightTop3PartialTitle(String completed) {
    return '$completed du Top 3 atteints';
  }

  @override
  String insightTop3PartialDesc(String remaining) {
    return 'Encore $remaining à atteindre';
  }

  @override
  String get insightScoreGreatTitle => 'Quelle journée !';

  @override
  String insightScoreGreatDesc(String score) {
    return 'Score de productivité : $score';
  }

  @override
  String get insightScoreNormalTitle => 'Bon travail aujourd\'hui';

  @override
  String insightScoreNormalDesc(String score) {
    return 'Score de productivité : $score';
  }

  @override
  String insightWeekAvgTitle(String score) {
    return 'Moyenne hebdo : $score pts';
  }

  @override
  String get insightWeekAvgHighDesc =>
      'Excellente performance toute la semaine';

  @override
  String get insightWeekAvgLowDesc => 'La semaine prochaine sera meilleure';

  @override
  String insightMonthAvgTitle(String score) {
    return 'Moyenne mensuelle : $score pts';
  }

  @override
  String get insightMonthAvgHighDesc => 'Performance régulière tout le mois';

  @override
  String get insightMonthAvgLowDesc => 'Redéfinissez vos objectifs et repartez';

  @override
  String insightMonthBestTitle(String month, String day) {
    return 'Meilleur jour du mois : $month/$day';
  }

  @override
  String insightMonthBestDesc(String score) {
    return 'Score ce jour-là : $score pts';
  }

  @override
  String get demoMode => 'Mode Démo';

  @override
  String get demoModeDescription =>
      'Données d\'exemple pour les captures d\'écran App Store';

  @override
  String get demoModeEnable => 'Activer le mode démo';

  @override
  String get demoModeDisable => 'Désactiver le mode démo';

  @override
  String get demoModeEnabled => 'Mode démo activé';

  @override
  String get demoModeDisabled => 'Mode démo désactivé';

  @override
  String get demoModeGenerating => 'Génération des données d\'exemple...';

  @override
  String get demoModeClearing => 'Suppression des données démo...';

  @override
  String timeBlockStartAlarmTitle(String title, String time) {
    return '$title - $time avant le début';
  }

  @override
  String get timeBlockStartAlarmBody => 'Ça commence bientôt. Préparez-vous !';

  @override
  String timeBlockEndAlarmTitle(String title, String time) {
    return '$title - $time avant la fin';
  }

  @override
  String get timeBlockEndAlarmBody => 'Il est temps de conclure.';

  @override
  String get focusSessionCompleteTitle => 'Session de concentration terminée !';

  @override
  String get focusSessionCompleteBody =>
      'Excellent travail ! Prenez une courte pause.';

  @override
  String get statDescProductivityScoreTitle => 'Score de productivité';

  @override
  String get statDescProductivityScoreBody =>
      'Score de 0 à 100 combinant taux de complétion, précision temporelle et exécution des blocs.';

  @override
  String get statDescCompletionRingsTitle => 'Anneaux de complétion';

  @override
  String get statDescCompletionRingsBody =>
      'Affiche le taux de complétion des tâches, le taux d\'exécution des blocs et la précision temporelle.';

  @override
  String get statDescTaskPipelineTitle => 'Flux de tâches';

  @override
  String get statDescTaskPipelineBody =>
      'Affiche le flux total → planifié → terminé → reporté.';

  @override
  String get statDescTop3StatsTitle => 'Réalisation Top 3';

  @override
  String get statDescTop3StatsBody =>
      'Affiche l\'état de réalisation de vos 3 tâches les plus importantes.';

  @override
  String get statDescTaskRankingTitle => 'Classement des tâches';

  @override
  String get statDescTaskRankingBody =>
      'Classe les tâches récurrentes par succès/échec de complétion.';

  @override
  String get statDescFocusSummaryTitle => 'Analyse de concentration';

  @override
  String get statDescFocusSummaryBody =>
      'Efficacité du mode focus, temps, nombre de sessions et durée des pauses.';

  @override
  String get statDescTrendChartTitle => 'Tendance de productivité';

  @override
  String get statDescTrendChartBody =>
      'Affiche l\'évolution quotidienne du score de productivité en graphique linéaire.';

  @override
  String get statDescTagAnalysisTitle => 'Analyse par tag';

  @override
  String get statDescTagAnalysisBody =>
      'Affiche le nombre de tâches et le temps planifié par tag.';

  @override
  String get statDescInsightsTitle => 'Analyses';

  @override
  String get statDescInsightsBody =>
      'Analyse de performance auto-générée basée sur vos données.';
}
