#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SOURCE_DIR="$SCRIPT_DIR/ghostty"
TARGET_DIR="$HOME/.config/ghostty"

if [ -L "$TARGET_DIR" ]; then
    echo "기존 심링크를 제거합니다: $TARGET_DIR"
    rm "$TARGET_DIR"
elif [ -d "$TARGET_DIR" ]; then
    echo "오류: $TARGET_DIR 가 이미 디렉토리로 존재합니다. 수동으로 확인해주세요."
    exit 1
fi

mkdir -p "$(dirname "$TARGET_DIR")"
ln -s "$SOURCE_DIR" "$TARGET_DIR"
echo "심링크 생성 완료: $TARGET_DIR -> $SOURCE_DIR"
