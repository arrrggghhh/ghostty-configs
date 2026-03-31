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

## Ghostty 설정 레퍼런스 조회

설정 옵션을 추가하거나 변경할 때는 반드시 Context7을 통해 최신 Ghostty 문서를 조회한다.

### Context7 사용법

```bash
# 1단계: 설정 관련 문서 조회
npx ctx7@latest docs /ghostty-org/ghostty "<질문>"

# 예시
npx ctx7@latest docs /ghostty-org/ghostty "font configuration options"
npx ctx7@latest docs /ghostty-org/ghostty "keybind syntax and available actions"
npx ctx7@latest docs /ghostty-org/ghostty "theme configuration dark light mode"
npx ctx7@latest docs /ghostty-org/ghostty "window padding and decoration options"
```

### Context7 Library ID

| ID | 용도 |
|----|------|
| `/ghostty-org/ghostty` | 설정 옵션, API, 내부 동작 레퍼런스 |
| `/ghostty-org/website` | 공식 웹사이트 문서, 가이드 |

### 조회해야 하는 경우

- 설정 키의 정확한 이름, 타입, 허용 값을 확인할 때
- 새로운 설정 옵션을 추가할 때
- 키바인딩 액션 목록이나 문법을 확인할 때
- 테마, 폰트 등 특정 카테고리의 전체 옵션을 파악할 때
- 설정 간 상호작용이나 로딩 순서를 확인할 때

### 주의사항

- 기억에 의존하지 말고 항상 Context7로 최신 문서를 확인한다
- Ghostty는 활발히 개발 중이므로 옵션이 추가/변경/제거될 수 있다
- 설정 파일 형식: `key = value` (key는 소문자, 하이픈 구분)
- 파일 이름: `config.ghostty` (1.2.3 이전 버전은 `config`)
