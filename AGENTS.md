# Ghostty Configuration Repository

이 저장소는 [Ghostty](https://ghostty.org) 터미널 에뮬레이터의 환경설정 파일을 버전 관리한다.

## 저장소 구조

```
ghostty-configs/
├── ghostty/            # $HOME/.config/ghostty 에 심링크되는 설정 디렉토리
│   └── config.ghostty  # 메인 설정 파일
└── install.sh          # 심링크 생성 스크립트
```

`install.sh`를 실행하면 `ghostty/` 디렉토리가 `~/.config/ghostty`로 심링크된다.

## 설정 파일 로딩 순서

Ghostty는 아래 순서로 설정 파일을 로드하며, 뒤에 로드된 값이 앞의 값을 덮어쓴다.

1. **macOS 전용**: `$HOME/Library/Application Support/com.mitchellh.ghostty/config.ghostty` (또는 `config`)
2. **XDG 경로** (모든 플랫폼): `$XDG_CONFIG_HOME/ghostty/config.ghostty` (또는 `config`)
   - `XDG_CONFIG_HOME` 미설정 시 기본값: `$HOME/.config/ghostty/config`

파일 이름은 `config.ghostty` (1.2.3 이전 버전은 `config`).

## 설정 파일 문법

### 기본 형식

`key = value` 형태의 단순한 텍스트 파일이다.

```ini
# 주석은 # 으로 시작
font-family = JetBrains Mono
font-size = 14
background-opacity = 0.95
```

- key는 소문자, 하이픈(`-`)으로 구분
- `=` 주변 공백은 자유
- 값에 따옴표는 선택 (공백 포함 시 권장)
- 빈 줄은 무시
- 빈 값(`font-family =`)은 해당 설정을 기본값으로 리셋

### 데이터 타입

| 타입 | 예시 |
|------|------|
| String | `font-family = "JetBrains Mono"` |
| Boolean | `mouse-hide-while-typing = true` |
| Integer | `font-size = 14` |
| Float | `background-opacity = 0.95` |
| Color | `background = #1e1e1e` 또는 `foreground = white` (X11 색상명) |
| Percentage | `adjust-cell-width = 20%` |
| Duration | `notify-on-command-finish-after = 5s` |
| Enum | `cursor-style = bar` (block, bar, underline, block_hollow) |

### 반복 키 (리스트)

같은 키를 여러 번 지정하면 리스트/폴백으로 동작한다.

```ini
font-family = JetBrains Mono
font-family = Menlo
```

### 다른 설정 파일 포함

```ini
config-file = ./base.ghostty
config-file = ?./optional.ghostty   # ? 접두사: 파일 없어도 에러 없음
```

`config-file`로 포함된 파일이 나중에 처리되므로, 포함 이후 같은 키를 다시 쓰면 덮어쓰지 못한다.

## 주요 설정 카테고리

### 폰트

```ini
font-family = JetBrains Mono
font-family-bold = JetBrains Mono Bold
font-size = 14
font-style = Regular
font-synthetic-style = false
font-feature = calt
font-feature = liga
```

### 색상 및 외관

```ini
background = #1e1e1e
foreground = #d4d4d4
background-opacity = 0.95
background-blur = true
cursor-color = #f2d5cf
cursor-style = bar
cursor-opacity = 0.8
palette = 0=#51576d
palette = 1=#e78284
```

### 테마

내장 테마 수백 개를 제공한다. `ghostty +list-themes`로 목록 확인 가능.

```ini
# 단일 테마
theme = Catppuccin Frappe

# 시스템 다크/라이트 모드 자동 전환
theme = dark:Catppuccin Frappe,light:Catppuccin Latte
```

커스텀 테마 파일은 `$XDG_CONFIG_HOME/ghostty/themes/` 디렉토리에 놓는다. 테마 파일 형식은 일반 설정 파일과 동일하며, 테마가 먼저 로드되고 사용자 설정이 덮어쓴다.

### 윈도우

```ini
window-width = 120
window-height = 40
window-padding-x = 8
window-padding-y = 8
window-decoration = auto
window-save-state = always
maximize = false
fullscreen = false
```

### 터미널 동작

```ini
command = /bin/zsh
working-directory = home
scrollback-limit = 10000000
shell-integration = true
```

### 키바인딩

`keybind = 트리거=액션` 형식이다.

```ini
# 기본 키바인딩
keybind = ctrl+c=copy_to_clipboard
keybind = ctrl+v=paste_from_clipboard
keybind = ctrl+shift+n=new_window
keybind = ctrl+shift+t=new_tab

# 글로벌 키바인딩 (다른 앱에서도 동작)
keybind = global:ctrl+grave=toggle_window

# 연속 키 (시퀀스)
keybind = ctrl+a>n=new_tab

# 파라미터가 있는 액션
keybind = ctrl+plus=increase_font_size:1.5
keybind = ctrl+minus=decrease_font_size:1.5

# 텍스트 전송
keybind = ctrl+shift+e=text:\x1b[1;5E
```

주요 수식키: `ctrl`, `shift`, `cmd` (macOS), `alt`

주요 액션: `copy_to_clipboard`, `paste_from_clipboard`, `new_tab`, `new_window`, `next_tab`, `previous_tab`, `close_tab`, `close_window`, `scroll_to_top`, `scroll_to_bottom`, `scroll_page_up`, `scroll_page_down`, `increase_font_size`, `decrease_font_size`, `reset_font_size`, `reset`, `clear_screen`, `toggle_window`, `select_all`

### 환경변수

```ini
env = TERM_PROGRAM=ghostty
env = MY_VAR=value
```

## CLI에서 설정 덮어쓰기

모든 설정 키를 CLI 플래그로 사용할 수 있다.

```bash
ghostty --font-family="Fira Code" --font-size=16 --background=282c34
```

## 런타임 리로드

- macOS: `Cmd+Shift+,`
- Linux: `Ctrl+Shift+,`

일부 옵션은 런타임 리로드가 불가능하며, 새 터미널에만 적용된다.
