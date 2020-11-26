@ECHO OFF

title Van's Shutdown

color 0a

mode 100,50

call :main

EXIT /B %ERRORLEVEL%

:main
cls
echo.   
echo   ****           **** ************ *****         ********   ********   ****     **** ************
echo   ****           **** ************ *****        ********** **********  *****   ***** ************
echo    ****  *****  ****  *****        *****       ****   **** ****   **** ****** ****** *****     
echo    **** ******* ****  **********   *****       ****        ****   **** ************* **********
echo     ******* *******   **********   *****       ****        ****   **** ****  *  **** **********
echo     ******   ******   *****        *****       ****   **** ****   **** ****     **** *****
echo      ****     ****    ************ ***********  *********   *********  ****     **** ************
echo      ****     ****    ************ ***********   *******     *******   ****     **** ************
echo.
echo.
echo.
echo                                       to Van's Command
echo.
echo.
echo.
pause

call :dashboard

:dashboard
cls
echo.
echo.
echo.
echo.
echo                                         [1] Shutdown
echo                                         [2] Shutdown and Lock
echo                                         [3] Abort Shutdown
echo                                         [4] Attrib
echo                                         [b] Back
echo                                         [e] Exit
echo.

set /p action=.                                     What do you want to do? 

if %action%==1 (call :shut)
if %action%==2 (call :shutlock)
if %action%==3 (call :abort)
if %action%==4 (call :attrib)
if %action%==b (call :back main)
if %action%==e Exit
EXIT /B 0

:shut
  set /p timeShut= Enter hour(s):
  if %timeShut%==b (call :back dashboard)
  if %timeShut%==e Exit
  set /a shutSeconds= (%timeShut% * 3600)
  cls
  echo %timeShut% hour(s) to shutdown...
  start shutdown.exe /s /t %shutSeconds%
  echo This message will close automatically
  TIMEOUT /T 10
EXIT /B 0

:shutlock
  set /p timeShut= Enter hour(s):
  if %timeShut%==b (call :back dashboard)
  if %timeShut%==e Exit
  set /a shutSeconds= (%timeShut% * 3600)
  cls
  echo %timeShut% hour(s) to shutdown...
  start shutdown.exe /s /t %shutSeconds%
  echo This computer will be locked down
  TIMEOUT /T 10
  rundll32.exe user32.dll, LockWorkStation
EXIT /B 0

:abort
  start shutdown.exe -a
  cls
  echo Shutdown cancelled
  echo Redirecting...
  TIMEOUT /T 5   
call :main

:back
  if %~1==main (call :main)
  if %~1==dashboard (call :dashboard)
exit /b 0

:attrib
  set /p drive= Enter drive letter:
  if %drive%==b (call :back dashboard)
  if %drive%==e Exit
  start attrib.exe -s -h -r /s /dxi %drive%:*.* 
  echo Attrib Success
  pause
EXIT /B 0
