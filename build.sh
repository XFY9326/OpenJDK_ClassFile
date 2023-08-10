#!/usr/bin/env sh

JAR_NAME="ClassFile.jar"
BUILD_DIR="build"
CLASS_BUILD_DIR="$BUILD_DIR/classes"
JAR_BUILD_DIR="$BUILD_DIR/jar"
SRC_DIR="src"


if [ -d "$BUILD_DIR" ]; then
  rm -rf "$BUILD_DIR"
fi

cd "$SRC_DIR"
find . -name "*.java" | xargs javac -d "../$CLASS_BUILD_DIR"
cd ..

if [ ! -d "$JAR_BUILD_DIR" ]; then
  mkdir -p "$JAR_BUILD_DIR"
fi

cd "$CLASS_BUILD_DIR"
find . -name "*.class" | xargs jar cvf "../../$JAR_BUILD_DIR/$JAR_NAME"
