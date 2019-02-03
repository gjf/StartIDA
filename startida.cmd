@ECHO OFF
REM  QBFC Project Options Begin
REM HasVersionInfo: Yes
REM Companyname: HSH
REM Productname: IDA Starter (v6.8)
REM Filedescription: Makes IDA and modules portable
REM Copyrights: © Gray Jack the Fixxxer
REM Trademarks: 
REM Originalname: StartIDA.exe
REM Comments: Works with IDA 6.8
REM Productversion:  1. 8. 0. 0
REM Fileversion:  1. 8. 0. 0
REM Internalname: StartIDA.exe
REM ExeType: ghost
REM Architecture: x86
REM Appicon: ..\idag.ico
REM AdministratorManifest: Yes
REM  QBFC Project Options End
@ECHO ON
set xOS=x64& If "%PROCESSOR_ARCHITECTURE%"=="x86" (If Not Defined PROCESSOR_ARCHITEW6432 Set xOS=x86)
set param=%~1
xcopy /E /I /C /Y /Q /H /R "%appdata%\zynamics" ".\Backup\zynamics"
xcopy /E /I /C /Y /Q /H /R "%appdata%\Hex-Rays" ".\Backup\Hex-Rays"
xcopy /E /I /C /Y /Q /H /R "%appdata%\IDA Pro" ".\Backup\IDA Pro"
call :removedir "%appdata%\zynamics"
call :removedir "%appdata%\Hex-Rays"
call :removedir "%appdata%\IDA Pro"
xcopy /E /I /C /Y /Q /H /R ".\BinDiff\INI" "%appdata%\"
xcopy /E /I /C /Y /Q /H /R ".\Hex-Rays" "%appdata%\"
xcopy /E /I /C /Y /Q /H /R ".\Hex-Rays\IDA Pro" "%appdata%\IDA Pro"
reg export HKEY_CURRENT_USER\Software\Hex-Rays backup.reg /y
reg import settings.reg
if "%param%"=="32" goto x32
if "%param%"=="64" goto x64
if "%param:~1%"=="32" goto x32
if "%param:~1%"=="64" goto x64
if "%xOS%"=="x64" goto x64
if "%xOS%"=="x32" goto x32

:x32
start /wait idaq.exe
goto end

:x64
start /wait idaq64.exe
goto end

:removedir
del /F /Q /S %1 > nul
rmdir /s /q %1
exit /b

:end
reg export HKEY_CURRENT_USER\Software\Hex-Rays settings.reg /y
xcopy /E /I /C /Y /Q /H /R "%appdata%\zynamics\*" ".\BinDiff\INI\zynamics"
xcopy /E /I /C /Y /Q /H /R "%appdata%\Hex-Rays\*" ".\Hex-Rays"
xcopy /E /I /C /Y /Q /H /R "%appdata%\IDA Pro" ".\Hex-Rays\IDA Pro" 
reg delete HKEY_CURRENT_USER\Software\Hex-Rays /f
reg import backup.reg
del /F /Q backup.reg
call :removedir "%appdata%\zynamics"
call :removedir "%appdata%\Hex-Rays"
call :removedir "%appdata%\IDA Pro"
xcopy /E /I /C /Y /Q /H /R ".\Backup\*" "%appdata%\"
call :removedir Backup
del /q /f %~s0
