#!/usr/bin/env sh

# ------------------------------------------------------------
# Gradle wrapper bootstrapper + launcher
# Downloads gradle-wrapper.jar automatically if missing, then runs it.
# ------------------------------------------------------------

APP_HOME=$(cd "$(dirname "$0")"; pwd -P)
JAR_PATH="$APP_HOME/gradle/wrapper/gradle-wrapper.jar"
WRAPPER_VERSION="8.7"
WRAPPER_URL="https://repo.gradle.org/gradle/libs-releases-local/org/gradle/gradle-wrapper/${WRAPPER_VERSION}/gradle-wrapper-${WRAPPER_VERSION}.jar"

# Download gradle-wrapper.jar if missing
if [ ! -f "$JAR_PATH" ]; then
  echo "gradle-wrapper.jar not found; downloading ${WRAPPER_URL} ..." >&2
  mkdir -p "$(dirname "$JAR_PATH")"
  if command -v curl >/dev/null 2>&1; then
    curl -fsSL "$WRAPPER_URL" -o "$JAR_PATH" || { echo "Download failed." >&2; exit 1; }
  elif command -v wget >/dev/null 2>&1; then
    wget -q "$WRAPPER_URL" -O "$JAR_PATH" || { echo "Download failed." >&2; exit 1; }
  else
    echo "Neither curl nor wget is available to fetch gradle-wrapper.jar." >&2
    exit 1
  fi
fi

# Set JAVA_HOME and java lookup
if [ -n "$JAVA_HOME" ] ; then
  JAVA_EXE="$JAVA_HOME/bin/java"
else
  JAVA_EXE="java"
fi

exec "$JAVA_EXE" -Dorg.gradle.appname=gradlew -classpath "$JAR_PATH" org.gradle.wrapper.GradleWrapperMain "$@"
