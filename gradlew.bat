@ECHO OFF
setlocal

set APP_HOME=%~dp0
set JAR_PATH=%APP_HOME%gradle\wrapper\gradle-wrapper.jar
set WRAPPER_VERSION=8.7
set WRAPPER_URL=https://repo.gradle.org/gradle/libs-releases-local/org/gradle/gradle-wrapper/%WRAPPER_VERSION%/gradle-wrapper-%WRAPPER_VERSION%.jar

IF NOT EXIST "%JAR_PATH%" (
  ECHO gradle-wrapper.jar not found; downloading %WRAPPER_URL% ...
  if exist "%ProgramFiles%\PowerShell\pwsh.exe" (
    "%ProgramFiles%\PowerShell\pwsh.exe" -NoProfile -Command "Invoke-WebRequest -UseBasicParsing -Uri '%WRAPPER_URL%' -OutFile '%JAR_PATH%'" || goto :download_error
  ) else if exist "%SystemRoot%\System32\WindowsPowerShell1.0\powershell.exe" (
    powershell -NoProfile -Command "Invoke-WebRequest -UseBasicParsing -Uri '%WRAPPER_URL%' -OutFile '%JAR_PATH%'" || goto :download_error
  ) else (
    ECHO PowerShell not found. Please download gradle-wrapper.jar manually:
    ECHO   %WRAPPER_URL%
    EXIT /B 1
  )
)

:run
set JAVA_EXE=java
if not "%JAVA_HOME%"=="" set JAVA_EXE="%JAVA_HOME%in\java.exe"
%JAVA_EXE% -Dorg.gradle.appname=gradlew -classpath "%JAR_PATH" org.gradle.wrapper.GradleWrapperMain %*
exit /B %ERRORLEVEL%

:download_error
ECHO Failed to download gradle-wrapper.jar
exit /B 1
