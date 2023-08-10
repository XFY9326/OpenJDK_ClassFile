#!/usr/bin/env sh

CACHE_DIR=".git_cache"
OPEN_JDK_GIT="https://github.com/openjdk/jdk.git"
TARGET_BRANCH="master"
TARGET_SUB_DIR="src/jdk.jdeps/share/classes/com/sun/tools/classfile/"
INPUT_DIR="src/jdk.jdeps/share/classes/com/sun/tools/classfile/"
OUTPUT_DIR="src"
OUTPUT_PACKAGE_NAME="openjdk.classfile"
OUTPUT_PACKAGE_DIR="$OUTPUT_DIR/openjdk/classfile/"


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

mkdir -p "$OUTPUT_PACKAGE_DIR"

cp -r "$CACHE_DIR/$INPUT_DIR"* "$OUTPUT_PACKAGE_DIR"

if [ -f "$OUTPUT_DIR/module-info.java" ]; then
  rm -rf "$OUTPUT_DIR/module-info.java"
fi

PKG_PATTERN="com\.sun\.tools\.classfile"
PKG_REPLACEMENT="$OUTPUT_PACKAGE_NAME"
find "$OUTPUT_DIR" -type f -name "*.java" | xargs sed -r -i "s/$PKG_PATTERN/$PKG_REPLACEMENT/g"
