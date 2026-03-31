# Ghostty Configs

[Ghostty](https://ghostty.org) 터미널 에뮬레이터 설정 파일 저장소.

## 설치

```bash
./install.sh
```

`ghostty/` 디렉토리가 `~/.config/ghostty`로 심링크된다.

## 원격 서버 terminfo 설정

원격 서버에서 `missing or unsuitable terminal: xterm-ghostty` 오류가 발생하면, 서버에 terminfo가 없는 것이다. 로컬에서 아래 명령으로 복사한다 (서버당 한 번만 실행):

```bash
infocmp xterm-ghostty | ssh user@hostname 'tic -x -'
```

Ghostty 업데이트로 terminfo가 변경된 경우 다시 실행한다.
