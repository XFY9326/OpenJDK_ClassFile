#!/usr/bin/env sh

CACHE_DIR=".git_cache"
OPEN_JDK_GIT="https://github.com/openjdk/jdk.git"
TARGET_BRANCH="master"
TARGET_SUB_DIR="src/jdk.jdeps/share/classes/com/sun/tools/classfile/"
INPUT_DIR="src/jdk.jdeps/share/classes"
OUTPUT_DIR="src"


if [ ! -d "$CACHE_DIR" ]; then
  git clone --depth 1 --no-checkout --no-tags --branch $TARGET_BRANCH --sparse "$OPEN_JDK_GIT" "$CACHE_DIR" || exit 1
  cd "$CACHE_DIR"
  git sparse-checkout set "$TARGET_SUB_DIR"
  git checkout $TARGET_BRANCH
  cd ..
else
  cd "$CACHE_DIR"
  git pull origin $TARGET_BRANCH
  cd ..
fi

if [ -d "$OUTPUT_DIR" ]; then
  rm -rf "$OUTPUT_DIR"
fi

cp -r "$CACHE_DIR/$INPUT_DIR" "$OUTPUT_DIR"


