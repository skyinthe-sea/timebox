// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appName => 'Таймбокс Планнер';

  @override
  String get inbox => 'Входящие';

  @override
  String get calendar => 'Календарь';

  @override
  String get focus => 'Фокус';

  @override
  String get analytics => 'Аналитика';

  @override
  String get settings => 'Настройки';

  @override
  String get task => 'Задача';

  @override
  String get tasks => 'Задачи';

  @override
  String get addTask => 'Добавить задачу';

  @override
  String get editTask => 'Редактировать задачу';

  @override
  String get deleteTask => 'Удалить задачу';

  @override
  String get taskTitle => 'Название';

  @override
  String get taskNote => 'Заметка';

  @override
  String get estimatedDuration => 'Ожидаемая длительность';

  @override
  String get subtasks => 'Подзадачи';

  @override
  String get addSubtask => 'Добавить подзадачу';

  @override
  String get priority => 'Приоритет';

  @override
  String get priorityHigh => 'Высокий';

  @override
  String get priorityMedium => 'Средний';

  @override
  String get priorityLow => 'Низкий';

  @override
  String get status => 'Статус';

  @override
  String get statusTodo => 'К выполнению';

  @override
  String get statusInProgress => 'В процессе';

  @override
  String get statusCompleted => 'Завершено';

  @override
  String get statusDelayed => 'Отложено';

  @override
  String get statusSkipped => 'Пропущено';

  @override
  String get tag => 'Тег';

  @override
  String get tags => 'Теги';

  @override
  String get addTag => 'Добавить тег';

  @override
  String get timeBlock => 'Таймблок';

  @override
  String get createTimeBlock => 'Создать таймблок';

  @override
  String get moveTimeBlock => 'Переместить таймблок';

  @override
  String get resizeTimeBlock => 'Изменить размер таймблока';

  @override
  String get conflictDetected => 'Обнаружен конфликт расписания';

  @override
  String get focusMode => 'Режим фокуса';

  @override
  String get startFocus => 'Начать фокус';

  @override
  String get pauseFocus => 'Пауза';

  @override
  String get resumeFocus => 'Продолжить';

  @override
  String get completeFocus => 'Завершить';

  @override
  String get skipFocus => 'Пропустить';

  @override
  String get timeRemaining => 'Осталось времени';

  @override
  String get today => 'Сегодня';

  @override
  String get tomorrow => 'Завтра';

  @override
  String get thisWeek => 'На этой неделе';

  @override
  String get minutes => 'минут';

  @override
  String get hours => 'часов';

  @override
  String minutesShort(int count) {
    return '$count мин';
  }

  @override
  String hoursShort(int count) {
    return '$count ч';
  }

  @override
  String get productivityScore => 'Показатель продуктивности';

  @override
  String get plannedVsActual => 'План vs Факт';

  @override
  String get completionRate => 'Процент выполнения';

  @override
  String get rolloverTasks => 'Перенесённые задачи';

  @override
  String get darkMode => 'Тёмный режим';

  @override
  String get language => 'Язык';

  @override
  String get notifications => 'Уведомления';

  @override
  String get calendarSync => 'Синхронизация календаря';

  @override
  String get profile => 'Профиль';

  @override
  String get logout => 'Выход';

  @override
  String get save => 'Сохранить';

  @override
  String get cancel => 'Отмена';

  @override
  String get delete => 'Удалить';

  @override
  String get confirm => 'Подтвердить';

  @override
  String get edit => 'Редактировать';

  @override
  String get done => 'Готово';

  @override
  String get emptyInbox => 'Входящие пусты';

  @override
  String get emptyInboxDescription => 'Добавьте новую задачу';

  @override
  String get emptyCalendar => 'Нет событий на сегодня';

  @override
  String get emptyCalendarDescription =>
      'Перетащите задачу для создания расписания';

  @override
  String get error => 'Ошибка';

  @override
  String get errorGeneric => 'Что-то пошло не так';

  @override
  String get errorNetwork => 'Проверьте подключение к сети';

  @override
  String get retry => 'Повторить';

  @override
  String get noActiveSession => 'Нет активной сессии';

  @override
  String get startFocusDescription =>
      'Начните сессию фокуса для повышения продуктивности';

  @override
  String get quickStart => 'Быстрый старт';

  @override
  String get paused => 'На паузе';

  @override
  String get skip => 'Пропустить';

  @override
  String get complete => 'Завершить';

  @override
  String get sessionCompleted => 'Сессия завершена!';

  @override
  String get selectDuration => 'Выберите длительность';

  @override
  String get filter => 'Фильтр';

  @override
  String get all => 'Все';

  @override
  String get statusDone => 'Выполнено';

  @override
  String get emptyInboxTitle => 'Входящие пусты';

  @override
  String get toDo => 'К выполнению';

  @override
  String get completed => 'Завершено';

  @override
  String get deleteTaskConfirm => 'Удалить эту задачу?';

  @override
  String get taskTitleHint => 'Что нужно сделать?';

  @override
  String get lessOptions => 'Скрыть опции';

  @override
  String get moreOptions => 'Больше опций';

  @override
  String get taskNoteHint => 'Добавить заметку...';

  @override
  String get title => 'Название';

  @override
  String get timeBlockTitleHint => 'Введите название блока';

  @override
  String get startTime => 'Начало';

  @override
  String get endTime => 'Окончание';

  @override
  String get add => 'Добавить';

  @override
  String get top3 => 'Топ 3 приоритета';

  @override
  String get rank1 => '1-й';

  @override
  String get rank2 => '2-й';

  @override
  String get rank3 => '3-й';

  @override
  String get brainDump => 'Быстрая запись';

  @override
  String get timeline => 'Таймлайн';

  @override
  String get dragToSchedule => 'Перетащите для планирования';

  @override
  String get emptyTop3Slot => 'Нажмите или перетащите для добавления';

  @override
  String get dayStartTime => 'Начало дня';

  @override
  String get dayEndTime => 'Конец дня';

  @override
  String get planner => 'Таймбокс';

  @override
  String get copyToTomorrow => 'Повторить завтра';

  @override
  String get copiedToTomorrow => 'Скопировано на завтра';

  @override
  String rolloverBadge(int count) {
    return 'Перенос: $count';
  }

  @override
  String get appearance => 'Внешний вид';

  @override
  String get theme => 'Тема';

  @override
  String get themeSystem => 'Системная';

  @override
  String get themeLight => 'Светлая';

  @override
  String get themeDark => 'Тёмная';

  @override
  String get notificationDescription => 'Получать уведомления о таймблоках';

  @override
  String get notificationTiming => 'Время уведомления';

  @override
  String minutesBefore(int count) {
    return 'За $count мин';
  }

  @override
  String get noCalendarConnected => 'Календарь не подключён';

  @override
  String get comingSoon => 'Скоро';

  @override
  String get timeSettings => 'Настройки времени';

  @override
  String get dayTimeRange => 'Диапазон дня';

  @override
  String get defaultTimeBlockDuration => 'Длительность таймблока по умолчанию';

  @override
  String get data => 'Данные';

  @override
  String get exportData => 'Экспорт данных';

  @override
  String get exportDataDescription => 'Экспорт в CSV файл';

  @override
  String get resetSettings => 'Сбросить настройки';

  @override
  String get resetSettingsConfirm => 'Сбросить все настройки?';

  @override
  String get settingsReset => 'Настройки сброшены';

  @override
  String get longPressToSelect => 'Долгое нажатие для выбора диапазона';

  @override
  String get selectTask => 'Выберите задачу';

  @override
  String get noUnscheduledTasks => 'Нет незапланированных задач';

  @override
  String get addNewTask => 'Добавить новую задачу';

  @override
  String get addNewTaskHint => 'Введите название задачи...';

  @override
  String timeRangeLabel(String start, String end) {
    return '$start - $end';
  }

  @override
  String get assignToTimeBlock => 'Назначить в таймблок';

  @override
  String get mergeBlocks => 'Объединить блоки';

  @override
  String get overlapWarning => 'Внимание: таймблоки перекрываются';

  @override
  String get taskAssigned => 'Задача назначена';

  @override
  String get tapToCancel => 'Нажмите снаружи для отмены';

  @override
  String get statistics => 'Статистика';

  @override
  String get todayHighlights => 'Итоги дня';

  @override
  String get completedTasksCount => 'Выполнено задач';

  @override
  String get focusTimeMinutes => 'Время фокуса';

  @override
  String get timeSavedMinutes => 'Сэкономлено времени';

  @override
  String get top3Achievement => 'Топ 3 достижения';

  @override
  String get trend => 'Тренд';

  @override
  String get tagAnalysis => 'Анализ по тегам';

  @override
  String get insights => 'Инсайты';

  @override
  String get daily => 'День';

  @override
  String get weekly => 'Неделя';

  @override
  String get monthly => 'Месяц';

  @override
  String get focusModeTooltip => 'Режим фокуса';

  @override
  String get startAlarm => 'Уведомление о начале';

  @override
  String get endAlarm => 'Уведомление об окончании';

  @override
  String get notifyBeforeStart => 'Уведомить до начала';

  @override
  String get notifyBeforeEnd => 'Уведомить до окончания';

  @override
  String get selectMultipleTimings => 'Можно выбрать несколько';

  @override
  String get dailyReminder => 'Ежедневное напоминание';

  @override
  String get dailyReminderDesc => 'Напоминание в дни без активности';

  @override
  String get dailyReminderTime => 'Время напоминания';

  @override
  String get notificationPermissionRequired =>
      'Требуется разрешение на уведомления';

  @override
  String get notificationPermissionDesc =>
      'Разрешите уведомления для получения напоминаний о таймблоках';

  @override
  String get openSettings => 'Открыть настройки';

  @override
  String get permissionGranted => 'Разрешение получено';

  @override
  String get permissionDenied => 'Разрешение отклонено';

  @override
  String get requestPermission => 'Запросить разрешение';

  @override
  String hourBefore(int count) {
    return 'За $count ч';
  }

  @override
  String get alarmSettings => 'Настройки уведомлений';

  @override
  String get alarmTimingNote => 'Множественный выбор';

  @override
  String get noonTime => 'Полдень (12:00)';

  @override
  String get mathChallenge => 'Математическая задача';

  @override
  String mathChallengeProgress(int current, int total) {
    return '$current / $total';
  }

  @override
  String get enterAnswer => 'Введите ответ';

  @override
  String get wrongAnswer => 'Неправильно. Попробуйте снова.';

  @override
  String get focusLockEnabled => 'Блокировка экрана включена';

  @override
  String get overlayPermissionRequired => 'Требуется разрешение на оверлей';

  @override
  String get noActiveTimeBlock => 'Нет активного таймблока';

  @override
  String get createTimeBlockFirst => 'Сначала создайте таймблок в календаре';

  @override
  String get exitFocus => 'Выход';

  @override
  String get statsCompletionRates => 'Процент выполнения';

  @override
  String get statsTaskPipeline => 'Поток задач';

  @override
  String get statsPlanVsActual => 'План vs Факт';

  @override
  String get statsPriorityBreakdown => 'По приоритетам';

  @override
  String get statsFocusSummary => 'Анализ фокуса';

  @override
  String get statsTopInsights => 'Инсайты';

  @override
  String get statsScheduled => 'Запланировано';

  @override
  String get statsCompleted => 'Выполнено';

  @override
  String get statsRolledOver => 'Перенесено';

  @override
  String get statsEfficiency => 'Эффективность';

  @override
  String get statsNoData => 'Пока нет данных';

  @override
  String get navTimeline => 'Таймлайн';

  @override
  String get navReport => 'Отчёт';

  @override
  String get suggestedTasks => 'Рекомендуемые задачи';

  @override
  String get taskSuggestionsHint => 'Задачи, которые вы часто выполняли';

  @override
  String get topSuccessTasks => 'Самые успешные задачи';

  @override
  String get topFailureTasks => 'Сложные задачи';

  @override
  String get completionCount => 'Выполнено раз';

  @override
  String get taskRankings => 'Рейтинг задач';

  @override
  String get privacyPolicy => 'Политика конфиденциальности';

  @override
  String get termsOfService => 'Условия использования';

  @override
  String get privacyPolicyContent =>
      'Политика конфиденциальности\n\nПоследнее обновление: 1 января 2026\n\n1. Собираемые данные\nПриложение обрабатывает данные о задачах и времени, которые вы вводите.\n\n2. Хранение данных\nВсе данные хранятся локально на вашем устройстве и не передаются на внешние серверы.\n\n3. Третьи стороны\nПриложение использует Google AdMob для показа рекламы. AdMob может собирать рекламные идентификаторы. Подробнее см. политику конфиденциальности Google.\n\n4. Удаление данных\nПри удалении приложения все данные автоматически удаляются.\n\n5. Контакты\nПо вопросам конфиденциальности: myclick90@gmail.com';

  @override
  String get termsOfServiceContent =>
      'Условия использования\n\nПоследнее обновление: 1 января 2026\n\n1. Описание сервиса\nTimebox Planner — мобильное приложение для управления временем и планирования.\n\n2. Ответственность пользователя\nВы несёте ответственность за все данные, которые вводите, и должны использовать приложение в законных целях.\n\n3. Ограничение ответственности\nПриложение предоставляется «как есть». Разработчик не несёт ответственности за потерю данных или пропущенные события.\n\n4. Интеллектуальная собственность\nВсе права на дизайн, код и контент принадлежат разработчику.\n\n5. Изменения условий\nУсловия могут быть изменены с предварительным уведомлением через обновление приложения.';

  @override
  String durationFormat(int hours, int minutes) {
    return '$hours ч $minutes мин';
  }

  @override
  String get previousDay => 'Предыдущий день';

  @override
  String get nextDay => 'Следующий день';

  @override
  String get noTitle => 'Без названия';

  @override
  String get incomplete => 'Не завершено';

  @override
  String get revert => 'Отменить';

  @override
  String get statusChange => 'Изменить статус';

  @override
  String get timeBlockResult => 'Результат таймблока';

  @override
  String get reverted => 'Отменено';

  @override
  String get markedComplete => 'Отмечено как выполнено';

  @override
  String get markedIncomplete => 'Отмечено как не выполнено';

  @override
  String get deleteTimeBlock => 'Удалить таймблок';

  @override
  String get deleteTimeBlockConfirm => 'Удалить этот таймблок?';

  @override
  String get removeFromTop3 => 'Убрать из Топ 3';

  @override
  String scoreUp(int change) {
    return 'На $change баллов выше вчерашнего!';
  }

  @override
  String scoreDown(int change) {
    return 'На $change баллов ниже вчерашнего';
  }

  @override
  String get scoreSame => 'Как вчера';

  @override
  String get average => 'Среднее';

  @override
  String get dailyReminderTitle => 'Составьте план на сегодня!';

  @override
  String get dailyReminderBody => 'Первый шаг к достижению цели.';

  @override
  String get monday => 'Понедельник';

  @override
  String get tuesday => 'Вторник';

  @override
  String get wednesday => 'Среда';

  @override
  String get thursday => 'Четверг';

  @override
  String get friday => 'Пятница';

  @override
  String get saturday => 'Суббота';

  @override
  String get sunday => 'Воскресенье';

  @override
  String get insightPeriodYesterday => 'Вчера';

  @override
  String get insightPeriodToday => 'Сегодня';

  @override
  String get insightPeriodWeekFirstHalf => 'Начало недели';

  @override
  String insightFocusTimeTitle(String dayName, String hour) {
    return 'Максимальная концентрация в $dayName в $hour:00';
  }

  @override
  String get insightFocusTimeDesc => 'Планируйте важные задачи на это время';

  @override
  String insightTagAccuracyFasterTitle(String tagName, String minutes) {
    return 'Задачи с тегом $tagName выполнены на $minutes мин быстрее';
  }

  @override
  String insightTagAccuracySlowerTitle(String tagName, String minutes) {
    return 'Задачи с тегом $tagName заняли на $minutes мин больше';
  }

  @override
  String get insightTagAccuracyFasterDesc =>
      'Ваши оценки времени становятся точнее';

  @override
  String get insightTagAccuracySlowerDesc =>
      'Выделяйте больше времени на такие задачи';

  @override
  String insightRolloverTitle(String rolloverCount, String taskCount) {
    return 'Перенесённых задач: $taskCount из $rolloverCount';
  }

  @override
  String get insightRolloverDesc =>
      'Разбивайте задачи на меньшие или пересмотрите приоритеты';

  @override
  String insightStreakTitle(String days) {
    return '$days дней подряд выполняете план!';
  }

  @override
  String get insightStreakDesc => 'Постоянство — ключ к успеху';

  @override
  String insightScoreUpTitle(String period, String scoreDiff) {
    return 'Продуктивность выросла на $scoreDiff баллов по сравнению с $period';
  }

  @override
  String get insightScoreUpDesc => 'Продолжайте в том же духе!';

  @override
  String insightScoreDownTitle(String period, String scoreDiff) {
    return 'Продуктивность снизилась на $scoreDiff баллов по сравнению с $period';
  }

  @override
  String get insightScoreDownDesc => 'Немного скорректируйте план';

  @override
  String insightBestDayTitle(String dayName) {
    return '$dayName — ваш самый продуктивный день';
  }

  @override
  String insightBestDayDesc(String score) {
    return 'Средний балл: $score';
  }

  @override
  String insightTimeSavedTitle(String period, String minutes) {
    return 'Сэкономлено $minutes мин за $period';
  }

  @override
  String get insightTimeSavedDesc => 'Отличное управление временем';

  @override
  String insightTimeOverTitle(String period, String minutes) {
    return 'Превышение на $minutes мин за $period';
  }

  @override
  String get insightTimeOverDesc => 'Закладывайте немного больше времени';

  @override
  String get insightTaskFirstTitle => 'Первая задача дня выполнена!';

  @override
  String get insightTaskFirstDesc => 'Хорошее начало';

  @override
  String get insightTaskAllCompleteTitle => 'Все задачи на сегодня выполнены!';

  @override
  String insightTaskAllCompleteDesc(String total) {
    return 'Выполнено задач: $total';
  }

  @override
  String get insightTaskNoneTitle => 'Пока нет выполненных задач';

  @override
  String get insightTaskNoneDesc => 'Начните с малого';

  @override
  String insightTaskPartialTitle(String total, String completed) {
    return 'Выполнено $completed из $total задач';
  }

  @override
  String insightTaskPartialDesc(String remaining) {
    return 'Осталось $remaining, вы справитесь!';
  }

  @override
  String insightFocusEffTitle(String percent) {
    return 'Эффективность фокуса: $percent%';
  }

  @override
  String get insightFocusEffHighDesc => 'Отличная концентрация';

  @override
  String get insightFocusEffMedDesc => 'Средний уровень концентрации';

  @override
  String get insightFocusEffLowDesc => 'Улучшите условия для фокуса';

  @override
  String insightTimeEstTitle(String percent) {
    return 'Точность оценки времени: $percent%';
  }

  @override
  String get insightTimeEstHighDesc => 'Точные оценки времени';

  @override
  String get insightTimeEstMedDesc => 'Немного скорректируйте оценки';

  @override
  String get insightTimeEstLowDesc =>
      'Записывайте фактическое время для улучшения оценок';

  @override
  String get insightTop3AllCompleteTitle => 'Все Топ 3 выполнены!';

  @override
  String get insightTop3AllCompleteDesc => 'Вы сфокусировались на главном';

  @override
  String insightTop3PartialTitle(String completed) {
    return 'Выполнено $completed из Топ 3';
  }

  @override
  String insightTop3PartialDesc(String remaining) {
    return 'Осталось ещё $remaining';
  }

  @override
  String get insightScoreGreatTitle => 'Отличный день!';

  @override
  String insightScoreGreatDesc(String score) {
    return 'Балл продуктивности: $score';
  }

  @override
  String get insightScoreNormalTitle => 'Хорошая работа сегодня';

  @override
  String insightScoreNormalDesc(String score) {
    return 'Балл продуктивности: $score';
  }

  @override
  String insightWeekAvgTitle(String score) {
    return 'Средний балл за неделю: $score';
  }

  @override
  String get insightWeekAvgHighDesc => 'Отличная неделя';

  @override
  String get insightWeekAvgLowDesc => 'Следующая неделя будет лучше';

  @override
  String insightMonthAvgTitle(String score) {
    return 'Средний балл за месяц: $score';
  }

  @override
  String get insightMonthAvgHighDesc => 'Стабильно хороший месяц';

  @override
  String get insightMonthAvgLowDesc => 'Пересмотрите цели и начните заново';

  @override
  String insightMonthBestTitle(String month, String day) {
    return 'Лучший день месяца: $day.$month';
  }

  @override
  String insightMonthBestDesc(String score) {
    return 'Балл того дня: $score';
  }
}
