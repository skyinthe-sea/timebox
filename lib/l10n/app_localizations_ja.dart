// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appName => 'タイムボックスプランナー';

  @override
  String get inbox => 'インボックス';

  @override
  String get calendar => 'カレンダー';

  @override
  String get focus => '集中';

  @override
  String get analytics => '分析';

  @override
  String get settings => '設定';

  @override
  String get task => 'タスク';

  @override
  String get tasks => 'タスク一覧';

  @override
  String get addTask => 'タスクを追加';

  @override
  String get editTask => 'タスクを編集';

  @override
  String get deleteTask => 'タスクを削除';

  @override
  String get taskTitle => 'タイトル';

  @override
  String get taskNote => 'メモ';

  @override
  String get estimatedDuration => '予想所要時間';

  @override
  String get subtasks => 'サブタスク';

  @override
  String get addSubtask => 'サブタスクを追加';

  @override
  String get priority => '優先度';

  @override
  String get priorityHigh => '高';

  @override
  String get priorityMedium => '中';

  @override
  String get priorityLow => '低';

  @override
  String get status => 'ステータス';

  @override
  String get statusTodo => '未完了';

  @override
  String get statusInProgress => '進行中';

  @override
  String get statusCompleted => '完了';

  @override
  String get statusDelayed => '遅延';

  @override
  String get statusSkipped => 'スキップ';

  @override
  String get tag => 'タグ';

  @override
  String get tags => 'タグ一覧';

  @override
  String get addTag => 'タグを追加';

  @override
  String get timeBlock => 'タイムブロック';

  @override
  String get createTimeBlock => 'タイムブロックを作成';

  @override
  String get moveTimeBlock => 'タイムブロックを移動';

  @override
  String get resizeTimeBlock => 'タイムブロックのサイズを変更';

  @override
  String get conflictDetected => 'スケジュールの競合が検出されました';

  @override
  String get focusMode => '集中モード';

  @override
  String get startFocus => '集中開始';

  @override
  String get pauseFocus => '一時停止';

  @override
  String get resumeFocus => '再開';

  @override
  String get completeFocus => '完了';

  @override
  String get skipFocus => 'スキップ';

  @override
  String get timeRemaining => '残り時間';

  @override
  String get today => '今日';

  @override
  String get tomorrow => '明日';

  @override
  String get thisWeek => '今週';

  @override
  String get minutes => '分';

  @override
  String get hours => '時間';

  @override
  String minutesShort(int count) {
    return '$count分';
  }

  @override
  String hoursShort(int count) {
    return '$count時間';
  }

  @override
  String get productivityScore => '生産性スコア';

  @override
  String get plannedVsActual => '計画 vs 実績';

  @override
  String get completionRate => '完了率';

  @override
  String get rolloverTasks => '繰り越しタスク';

  @override
  String get darkMode => 'ダークモード';

  @override
  String get language => '言語';

  @override
  String get notifications => '通知';

  @override
  String get calendarSync => 'カレンダー同期';

  @override
  String get profile => 'プロフィール';

  @override
  String get logout => 'ログアウト';

  @override
  String get save => '保存';

  @override
  String get cancel => 'キャンセル';

  @override
  String get delete => '削除';

  @override
  String get confirm => '確認';

  @override
  String get edit => '編集';

  @override
  String get done => '完了';

  @override
  String get emptyInbox => 'インボックスは空です';

  @override
  String get emptyInboxDescription => '新しいタスクを追加してください';

  @override
  String get emptyCalendar => '今日の予定はありません';

  @override
  String get emptyCalendarDescription => 'タスクをドラッグしてスケジュールを作成してください';

  @override
  String get error => 'エラー';

  @override
  String get errorGeneric => '問題が発生しました';

  @override
  String get errorNetwork => 'ネットワーク接続を確認してください';

  @override
  String get retry => '再試行';

  @override
  String get noActiveSession => 'アクティブなセッションがありません';

  @override
  String get startFocusDescription => '集中セッションを開始して生産性を高めましょう';

  @override
  String get quickStart => 'クイックスタート';

  @override
  String get paused => '一時停止中';

  @override
  String get skip => 'スキップ';

  @override
  String get complete => '完了';

  @override
  String get sessionCompleted => 'セッション完了！';

  @override
  String get selectDuration => '時間を選択';

  @override
  String get filter => 'フィルター';

  @override
  String get all => 'すべて';

  @override
  String get statusDone => '完了';

  @override
  String get emptyInboxTitle => 'インボックスは空です';

  @override
  String get toDo => '未完了';

  @override
  String get completed => '完了済み';

  @override
  String get deleteTaskConfirm => 'このタスクを削除しますか？';

  @override
  String get taskTitleHint => '何をしますか？';

  @override
  String get lessOptions => 'オプションを隠す';

  @override
  String get moreOptions => 'その他のオプション';

  @override
  String get taskNoteHint => 'メモを追加...';

  @override
  String get title => 'タイトル';

  @override
  String get timeBlockTitleHint => 'ブロック名を入力';

  @override
  String get startTime => '開始時間';

  @override
  String get endTime => '終了時間';

  @override
  String get add => '追加';

  @override
  String get top3 => '最重要タスク3つ';

  @override
  String get rank1 => '1位';

  @override
  String get rank2 => '2位';

  @override
  String get rank3 => '3位';

  @override
  String get brainDump => 'ブレインダンプ';

  @override
  String get timeline => 'タイムライン';

  @override
  String get dragToSchedule => 'ドラッグしてスケジュール';

  @override
  String get emptyTop3Slot => 'タップまたはドラッグして追加';

  @override
  String get dayStartTime => '1日の開始時間';

  @override
  String get dayEndTime => '1日の終了時間';

  @override
  String get planner => 'タイムボックス';

  @override
  String get copyToTomorrow => '明日も行う';

  @override
  String get copiedToTomorrow => '明日にコピーしました';

  @override
  String rolloverBadge(int count) {
    return '繰越 $count回';
  }

  @override
  String get appearance => '外観';

  @override
  String get theme => 'テーマ';

  @override
  String get themeSystem => 'システム設定';

  @override
  String get themeLight => 'ライト';

  @override
  String get themeDark => 'ダーク';

  @override
  String get notificationDescription => 'タイムブロックの通知を受け取る';

  @override
  String get notificationTiming => '通知タイミング';

  @override
  String minutesBefore(int count) {
    return '$count分前';
  }

  @override
  String get noCalendarConnected => '接続されたカレンダーはありません';

  @override
  String get comingSoon => '近日公開';

  @override
  String get timeSettings => '時間設定';

  @override
  String get dayTimeRange => '1日の時間範囲';

  @override
  String get defaultTimeBlockDuration => 'デフォルトのタイムブロック長';

  @override
  String get data => 'データ';

  @override
  String get exportData => 'データをエクスポート';

  @override
  String get exportDataDescription => 'CSVファイルにエクスポート';

  @override
  String get resetSettings => '設定をリセット';

  @override
  String get resetSettingsConfirm => 'すべての設定を初期状態に戻しますか？';

  @override
  String get settingsReset => '設定がリセットされました';

  @override
  String get longPressToSelect => '長押しして時間範囲を選択';

  @override
  String get selectTask => 'タスクを選択';

  @override
  String get noUnscheduledTasks => '未スケジュールのタスクはありません';

  @override
  String get addNewTask => '新しいタスクを追加';

  @override
  String get addNewTaskHint => 'タスクのタイトルを入力...';

  @override
  String timeRangeLabel(String start, String end) {
    return '$start - $end';
  }

  @override
  String get assignToTimeBlock => 'タイムブロックに割り当て';

  @override
  String get mergeBlocks => 'ブロックを結合';

  @override
  String get overlapWarning => '警告: タイムブロックが重複しています';

  @override
  String get taskAssigned => 'タスクが割り当てられました';

  @override
  String get tapToCancel => '外側をタップしてキャンセル';

  @override
  String get statistics => '統計';

  @override
  String get todayHighlights => '今日のハイライト';

  @override
  String get completedTasksCount => '完了タスク';

  @override
  String get focusTimeMinutes => '集中時間';

  @override
  String get timeSavedMinutes => '節約した時間';

  @override
  String get top3Achievement => 'Top 3達成';

  @override
  String get trend => 'トレンド';

  @override
  String get tagAnalysis => 'タグ別分析';

  @override
  String get insights => 'インサイト';

  @override
  String get daily => '日次';

  @override
  String get weekly => '週次';

  @override
  String get monthly => '月次';

  @override
  String get focusModeTooltip => '集中モード';

  @override
  String get startAlarm => '開始アラーム';

  @override
  String get endAlarm => '終了アラーム';

  @override
  String get notifyBeforeStart => '開始前に通知';

  @override
  String get notifyBeforeEnd => '終了前に通知';

  @override
  String get selectMultipleTimings => '複数選択可能';

  @override
  String get dailyReminder => '毎日のリマインダー';

  @override
  String get dailyReminderDesc => 'アプリを開いていない日に通知';

  @override
  String get dailyReminderTime => 'リマインダー時間';

  @override
  String get notificationPermissionRequired => '通知権限が必要です';

  @override
  String get notificationPermissionDesc => 'タイムブロック通知を受け取るには通知権限を許可してください';

  @override
  String get openSettings => '設定を開く';

  @override
  String get permissionGranted => '権限許可済み';

  @override
  String get permissionDenied => '権限拒否';

  @override
  String get requestPermission => '権限をリクエスト';

  @override
  String hourBefore(int count) {
    return '$count時間前';
  }

  @override
  String get alarmSettings => 'アラーム設定';

  @override
  String get alarmTimingNote => '複数選択可能';

  @override
  String get noonTime => '正午 (12:00)';

  @override
  String get mathChallenge => '計算問題';

  @override
  String mathChallengeProgress(int current, int total) {
    return '$current / $total';
  }

  @override
  String get enterAnswer => '答えを入力';

  @override
  String get wrongAnswer => '不正解です。もう一度お試しください。';

  @override
  String get focusLockEnabled => '画面ロックが有効です';

  @override
  String get overlayPermissionRequired => 'オーバーレイ権限が必要です';

  @override
  String get noActiveTimeBlock => '進行中のタイムブロックがありません';

  @override
  String get createTimeBlockFirst => 'まずカレンダーでタイムブロックを作成してください';

  @override
  String get exitFocus => '終了する';

  @override
  String get statsCompletionRates => '完了率';

  @override
  String get statsTaskPipeline => 'タスクフロー';

  @override
  String get statsPlanVsActual => '計画 vs 実績';

  @override
  String get statsPriorityBreakdown => '優先度別実績';

  @override
  String get statsFocusSummary => '集中分析';

  @override
  String get statsTopInsights => 'インサイト';

  @override
  String get statsScheduled => 'スケジュール';

  @override
  String get statsCompleted => '完了';

  @override
  String get statsRolledOver => '繰り越し';

  @override
  String get statsEfficiency => '効率';

  @override
  String get statsNoData => 'まだデータがありません';

  @override
  String get navTimeline => 'タイムライン';

  @override
  String get navReport => 'レポート';

  @override
  String get suggestedTasks => 'おすすめタスク';

  @override
  String get taskSuggestionsHint => '以前やったことのあるタスクです';

  @override
  String get topSuccessTasks => '最も完了しやすいタスク';

  @override
  String get topFailureTasks => '完了が難しいタスク';

  @override
  String get completionCount => '完了回数';

  @override
  String get taskRankings => 'タスクランキング';

  @override
  String get privacyPolicy => 'プライバシーポリシー';

  @override
  String get termsOfService => '利用規約';

  @override
  String get privacyPolicyContent =>
      'プライバシーポリシー\n\n最終更新日: 2026年1月1日\n\n1. 収集項目\n本アプリは、タスクや時間記録など、ユーザーが入力したデータを処理します。\n\n2. 保存方法\nすべてのデータはお使いの端末にローカル保存されます。外部サーバーへの送信は行いません。\n\n3. 第三者提供\n本アプリは広告表示のためにGoogle AdMobを使用しています。AdMobは広告識別子を収集する場合があります。詳細はGoogleのプライバシーポリシーをご参照ください。\n\n4. データの削除\nアプリを削除すると、端末に保存されたすべてのデータが自動的に削除されます。\n\n5. お問い合わせ\nプライバシーに関するお問い合わせ: myclick90@gmail.com';

  @override
  String get termsOfServiceContent =>
      '利用規約\n\n最終更新日: 2026年1月1日\n\n1. サービス説明\nTimebox Plannerは、時間管理とスケジュール計画を支援するモバイルアプリケーションです。\n\n2. ユーザーの責任\nユーザーは、アプリに入力するすべてのデータに対して責任を負い、合法的な目的でのみアプリを使用する必要があります。\n\n3. 免責事項\n本アプリは「現状のまま」提供されます。データの損失やスケジュールの見逃しなどによる直接的・間接的な損害について、開発者は責任を負いません。\n\n4. 知的財産権\n本アプリのデザイン、コード、コンテンツに関するすべての知的財産権は開発者に帰属します。\n\n5. 規約の変更\n本規約は事前通知の上、変更されることがあります。変更はアプリのアップデートを通じてお知らせします。';

  @override
  String durationFormat(int hours, int minutes) {
    return '$hours時間$minutes分';
  }

  @override
  String get previousDay => '前日';

  @override
  String get nextDay => '翌日';

  @override
  String get noTitle => 'タイトルなし';

  @override
  String get incomplete => '未完了';

  @override
  String get revert => '元に戻す';

  @override
  String get statusChange => 'ステータス変更';

  @override
  String get timeBlockResult => 'タイムブロック結果';

  @override
  String get reverted => '元に戻しました';

  @override
  String get markedComplete => '完了にしました';

  @override
  String get markedIncomplete => '未完了にしました';

  @override
  String get deleteTimeBlock => 'タイムブロックを削除';

  @override
  String get deleteTimeBlockConfirm => 'このタイムブロックを削除しますか？';

  @override
  String get removeFromTop3 => 'Top 3から削除';

  @override
  String scoreUp(int change) {
    return '昨日より$changeポイント上昇！';
  }

  @override
  String scoreDown(int change) {
    return '昨日より$changeポイント低下';
  }

  @override
  String get scoreSame => '昨日と同じ';

  @override
  String get average => '平均';

  @override
  String get dailyReminderTitle => '今日の計画を立てましょう！';

  @override
  String get dailyReminderBody => '目標達成への第一歩です。';

  @override
  String get monday => '月曜日';

  @override
  String get tuesday => '火曜日';

  @override
  String get wednesday => '水曜日';

  @override
  String get thursday => '木曜日';

  @override
  String get friday => '金曜日';

  @override
  String get saturday => '土曜日';

  @override
  String get sunday => '日曜日';

  @override
  String get insightPeriodYesterday => '昨日';

  @override
  String get insightPeriodToday => '今日';

  @override
  String get insightPeriodWeekFirstHalf => '今週前半';

  @override
  String insightFocusTimeTitle(String dayName, String hour) {
    return '$dayName$hour時に最も集中力が高かったです';
  }

  @override
  String get insightFocusTimeDesc => 'この時間帯に重要なタスクを配置してみてください';

  @override
  String insightTagAccuracyFasterTitle(String tagName, String minutes) {
    return '$tagNameタスクを$minutes分早く完了しました';
  }

  @override
  String insightTagAccuracySlowerTitle(String tagName, String minutes) {
    return '$tagNameタスクに$minutes分多くかかりました';
  }

  @override
  String get insightTagAccuracyFasterDesc => '時間見積もりが正確になっています';

  @override
  String get insightTagAccuracySlowerDesc => 'このタイプのタスクにもう少し時間を割り当ててみてください';

  @override
  String insightRolloverTitle(String rolloverCount, String taskCount) {
    return '$taskCount件中$rolloverCount件の繰り越しタスクがあります';
  }

  @override
  String get insightRolloverDesc => 'タスクを細分化するか優先順位を見直してみてください';

  @override
  String insightStreakTitle(String days) {
    return '$days日連続で計画を実行中です！';
  }

  @override
  String get insightStreakDesc => '継続は成功の鍵です';

  @override
  String insightScoreUpTitle(String period, String scoreDiff) {
    return '$periodより生産性が$scoreDiffポイント上昇しました';
  }

  @override
  String get insightScoreUpDesc => '良い流れを維持しましょう！';

  @override
  String insightScoreDownTitle(String period, String scoreDiff) {
    return '$periodより生産性が$scoreDiffポイント低下しました';
  }

  @override
  String get insightScoreDownDesc => '計画を少し調整してみてください';

  @override
  String insightBestDayTitle(String dayName) {
    return '$dayNameが最も生産的な曜日です';
  }

  @override
  String insightBestDayDesc(String score) {
    return '平均スコア: $scoreポイント';
  }

  @override
  String insightTimeSavedTitle(String period, String minutes) {
    return '$periodの計画より$minutes分節約しました';
  }

  @override
  String get insightTimeSavedDesc => '効率的な時間管理ができています';

  @override
  String insightTimeOverTitle(String period, String minutes) {
    return '$periodの計画より$minutes分超過しました';
  }

  @override
  String get insightTimeOverDesc => '時間見積もりを少し余裕を持たせてみてください';

  @override
  String get insightTaskFirstTitle => '今日の最初のタスクを完了しました！';

  @override
  String get insightTaskFirstDesc => '良いスタートです';

  @override
  String get insightTaskAllCompleteTitle => '今日のすべてのタスクを完了しました！';

  @override
  String insightTaskAllCompleteDesc(String total) {
    return '合計$total個のタスクを達成しました';
  }

  @override
  String get insightTaskNoneTitle => 'まだ完了したタスクがありません';

  @override
  String get insightTaskNoneDesc => '小さなことから始めてみましょう';

  @override
  String insightTaskPartialTitle(String total, String completed) {
    return '$total個中$completed個のタスクを完了';
  }

  @override
  String insightTaskPartialDesc(String remaining) {
    return 'あと$remaining個、頑張りましょう！';
  }

  @override
  String insightFocusEffTitle(String percent) {
    return '集中効率 $percent%';
  }

  @override
  String get insightFocusEffHighDesc => '高い集中力を維持しています';

  @override
  String get insightFocusEffMedDesc => '集中力は普通レベルです';

  @override
  String get insightFocusEffLowDesc => '集中環境を改善してみてください';

  @override
  String insightTimeEstTitle(String percent) {
    return '時間予測精度 $percent%';
  }

  @override
  String get insightTimeEstHighDesc => '時間見積もりが正確です';

  @override
  String get insightTimeEstMedDesc => '時間見積もりを少し調整してみてください';

  @override
  String get insightTimeEstLowDesc => '実際の所要時間を記録して予測を改善しましょう';

  @override
  String get insightTop3AllCompleteTitle => 'Top 3をすべて達成しました！';

  @override
  String get insightTop3AllCompleteDesc => '最も重要なことに集中しました';

  @override
  String insightTop3PartialTitle(String completed) {
    return 'Top 3中$completed個達成';
  }

  @override
  String insightTop3PartialDesc(String remaining) {
    return 'あと$remaining個達成しましょう';
  }

  @override
  String get insightScoreGreatTitle => '素晴らしい一日でした！';

  @override
  String insightScoreGreatDesc(String score) {
    return '生産性スコア $scoreポイント';
  }

  @override
  String get insightScoreNormalTitle => '今日もお疲れ様でした';

  @override
  String insightScoreNormalDesc(String score) {
    return '生産性スコア $scoreポイント';
  }

  @override
  String insightWeekAvgTitle(String score) {
    return '今週の平均スコア: $scoreポイント';
  }

  @override
  String get insightWeekAvgHighDesc => '一週間ずっと素晴らしかったです';

  @override
  String get insightWeekAvgLowDesc => '来週はもっと良くなりますよ';

  @override
  String insightMonthAvgTitle(String score) {
    return '今月の平均スコア: $scoreポイント';
  }

  @override
  String get insightMonthAvgHighDesc => '一ヶ月間着実に頑張りました';

  @override
  String get insightMonthAvgLowDesc => '目標を再設定して再スタートしましょう';

  @override
  String insightMonthBestTitle(String month, String day) {
    return '今月のベストデー: $month月$day日';
  }

  @override
  String insightMonthBestDesc(String score) {
    return 'その日のスコア: $scoreポイント';
  }
}
