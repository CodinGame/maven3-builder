#!/usr/bin/env bash

# Exit as soon as a command return status != 0
set -e

SRC_DIR=${1:-/project/target}
TARGET_DIR=${2:-/project/target/jars}

# Create target dir
mkdir -p ${TARGET_DIR}

cd ${SRC_DIR}

# Build the project: create all the jar files
mvn clean install jar:test-jar -DskipTests
# Copy the jar files into the target directory
find ${SRC_DIR} -name "*.jar" -not -path "${TARGET_DIR}/*" -exec cp {} ${TARGET_DIR} \;
# Copy all the dependencies into the target directory
mvn dependency:copy-dependencies -DoutputDirectory=${TARGET_DIR}

# Clean all except jars
shopt -s extglob
rm -rf !("jars")

# Clean .m2 directory
rm -rf ${HOME}/.m2
