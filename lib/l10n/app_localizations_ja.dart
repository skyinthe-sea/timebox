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
}
