#!/usr/bin/env bash

SRC_DIR=${1:-/project/source}
TARGET_DIR=${2:-/project/target}

cd ${SRC_DIR}

# Build the project: create all the jar files
mvn clean install jar:test-jar -DskipTests
# Copy the jar files into the target directory
find . -name "*.jar" -exec cp {} ${TARGET_DIR} \;
# Copy all the dependencies into the target directory
mvn dependency:copy-dependencies -DoutputDirectory=${TARGET_DIR}
