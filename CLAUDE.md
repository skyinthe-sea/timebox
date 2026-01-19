# Timebox Planner

시간 관리 및 일정 플래너 앱 (Flutter)

## 앱 개요

**핵심 가치:** 사용자가 제한된 시간을 시각적으로 인지하고, 계획(Plan)과 실행(Act)의 간극을 줄이도록 돕는다.

**주요 기능:**
- 브레인 덤프 (빠른 할 일 추가)
- 타임박싱 캘린더 (드래그 앤 드롭)
- 포커스 모드 (집중 타이머)
- 계획 vs 실제 시간 분석

## 기술 스택

- Flutter 3.x / Dart 3.x
- 상태관리: flutter_bloc
- 의존성 주입: get_it
- 함수형 에러 처리: dartz (Either)
- 다국어: flutter_localizations + intl
- 광고: google_mobile_ads

## 필수 적용 사항 (모든 작업 시 반드시 준수)

### 1. 테마 (Light/Dark Mode)

모든 UI는 라이트/다크 모드를 모두 지원해야 함.

**2026 트렌디 컬러 팔레트:**

| 구분 | Light Mode | Dark Mode |
|------|------------|-----------|
| Primary | `#6366F1` (Indigo) | `#818CF8` (Light Indigo) |
| Secondary | `#F472B6` (Pink) | `#F9A8D4` (Light Pink) |
| Background | `#FAFAFA` | `#0F0F0F` |
| Surface | `#FFFFFF` | `#1A1A1A` |
| On Primary | `#FFFFFF` | `#000000` |
| On Background | `#171717` | `#FAFAFA` |
| Border/Divider | `#E5E5E5` | `#2A2A2A` |
| Success | `#10B981` | `#34D399` |
| Warning | `#F59E0B` | `#FBBF24` |
| Error | `#EF4444` | `#F87171` |

- ThemeData: `lib/config/themes/app_theme.dart`
- 컬러 상수: `lib/config/themes/app_colors.dart`

### 2. 다국어 (i18n)

**지원 언어:** ko (기본), en, ja, hi, zh, fr, de

**규칙:**
- 하드코딩 문자열 절대 금지
- `lib/l10n/app_*.arb` 파일 사용
- 새 문자열 추가 시 모든 7개 언어 ARB 파일에 키 추가

### 3. 반응형 디자인

**타겟:** 모바일 전용 (iOS, Android)

**브레이크포인트:**
- Small: < 360dp
- Medium: 360dp ~ 414dp
- Large: > 414dp

### 4. 광고 배너

- 위젯: `lib/core/widgets/ad_banner.dart`
- 주요 화면 상단에 배치

### 5. 위젯 커스터마이징

- 사용자가 대시보드에 원하는 위젯만 배치 가능 (추후 구현)

---

## 프로젝트 구조 (클린 아키텍처)

```
lib/
├── main.dart                              # 앱 진입점
├── app.dart                               # MaterialApp 설정
├── injection_container.dart               # 의존성 주입 (get_it)
│
├── config/
│   ├── routes/
│   │   ├── app_router.dart                # 라우트 설정
│   │   └── route_names.dart               # 라우트 상수
│   └── themes/
│       ├── app_theme.dart                 # ThemeData
│       ├── app_colors.dart                # 컬러 팔레트
│       └── app_text_styles.dart           # 타이포그래피
│
├── core/
│   ├── constants/
│   │   ├── app_constants.dart             # 앱 상수
│   │   └── duration_presets.dart          # 시간 프리셋
│   ├── error/
│   │   ├── exceptions.dart                # 커스텀 예외
│   │   └── failures.dart                  # Failure 클래스
│   ├── usecases/
│   │   └── usecase.dart                   # UseCase 베이스
│   ├── utils/
│   │   ├── date_time_utils.dart           # 날짜/시간 유틸
│   │   └── extensions/
│   │       └── context_extensions.dart    # BuildContext 확장
│   └── widgets/
│       ├── ad_banner.dart                 # 광고 배너
│       ├── loading_indicator.dart         # 로딩
│       └── empty_state_widget.dart        # 빈 상태
│
├── l10n/
│   ├── app_ko.arb                         # 한국어
│   ├── app_en.arb                         # 영어
│   ├── app_ja.arb                         # 일본어
│   ├── app_hi.arb                         # 힌디어
│   ├── app_zh.arb                         # 중국어
│   ├── app_fr.arb                         # 프랑스어
│   └── app_de.arb                         # 독일어
│
└── features/
    ├── task/                              # 할 일 관리 (인박스)
    │   ├── domain/
    │   │   ├── entities/
    │   │   │   ├── task.dart              # Task 엔티티
    │   │   │   ├── subtask.dart           # Subtask 엔티티
    │   │   │   └── tag.dart               # Tag 엔티티
    │   │   └── repositories/
    │   │       └── task_repository.dart   # 인터페이스
    │   └── presentation/
    │       ├── pages/inbox_page.dart
    │       └── widgets/
    │           ├── task_quick_add.dart    # 브레인 덤프
    │           └── task_list_item.dart
    │
    ├── timeblock/                         # 타임박싱 캘린더
    │   ├── domain/
    │   │   ├── entities/
    │   │   │   ├── time_block.dart        # TimeBlock 엔티티
    │   │   │   └── calendar_event.dart    # 외부 캘린더 일정
    │   │   └── repositories/
    │   │       ├── time_block_repository.dart
    │   │       └── calendar_repository.dart
    │   └── presentation/
    │       ├── pages/calendar_page.dart
    │       └── widgets/
    │           ├── timeline_view.dart     # 메인 타임라인
    │           └── time_block_card.dart   # 드래그 가능 블록
    │
    ├── focus/                             # 포커스 모드
    │   ├── domain/
    │   │   ├── entities/
    │   │   │   ├── focus_session.dart     # 세션 엔티티
    │   │   │   └── session_status.dart    # 상태 열거형
    │   │   └── repositories/
    │   │       └── focus_repository.dart
    │   └── presentation/
    │       ├── pages/focus_mode_page.dart
    │       └── widgets/
    │           ├── countdown_timer.dart   # 카운트다운
    │           └── timer_controls.dart    # 컨트롤 버튼
    │
    ├── analytics/                         # 분석 및 리뷰
    │   ├── domain/
    │   │   ├── entities/
    │   │   │   ├── productivity_stats.dart
    │   │   │   └── time_comparison.dart
    │   │   └── repositories/
    │   │       └── analytics_repository.dart
    │   └── presentation/
    │       └── pages/analytics_page.dart
    │
    └── settings/                          # 설정
        ├── domain/
        │   ├── entities/
        │   │   └── user_settings.dart
        │   └── repositories/
        │       └── settings_repository.dart
        └── presentation/
            └── pages/settings_page.dart
```

---

## 핵심 데이터 모델

### Task (할 일)
- id, title, note
- estimatedDuration (예상 시간)
- tags, priority (high/medium/low)
- status (todo/done/archived)
- subtasks (하위 할 일)

### TimeBlock (시간 블록)
- id, taskId (연결된 Task)
- startTime, endTime (계획)
- actualStart, actualEnd (실제)
- status (pending/inProgress/completed/delayed/skipped)
- isExternal (외부 캘린더 여부)

### FocusSession (집중 세션)
- timeBlockId, taskId
- plannedDuration, actualDuration
- pauseRecords (일시정지 기록)

---

## 명령어

```bash
# 실행
flutter run

# 빌드
flutter build apk
flutter build ios

# 다국어 생성
flutter gen-l10n

# 코드 생성 (freezed, json_serializable 등)
flutter pub run build_runner build --delete-conflicting-outputs

# 테스트
flutter test

# 분석
flutter analyze
```

## 코드 스타일

- 파일명: snake_case (`home_screen.dart`)
- 클래스명: PascalCase (`HomeScreen`)
- 변수/함수명: camelCase (`getUserData`)
- 상수: camelCase 또는 SCREAMING_SNAKE_CASE
- private 멤버: `_` prefix (`_counter`)
