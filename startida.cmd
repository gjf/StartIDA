@ECHO OFF
REM  QBFC Project Options Begin
REM HasVersionInfo: Yes
REM Companyname: HSH
REM Productname: IDA Starter (v7.x)
REM Filedescription: Makes IDA and modules portable
REM Copyrights: © Fixxxer
REM Trademarks: 
REM Originalname: StartIDA.exe
REM Comments: Works with IDA 7.x
REM Productversion:  2. 9. 0. 0
REM Fileversion:  2. 9. 0. 0
REM Internalname: StartIDA.exe
REM ExeType: ghost
REM Architecture: x86
REM Appicon: X:\FIXXXER\Program Files\Analysis\HEX\IDA\StartIDA\idag.ico
REM AdministratorManifest: Yes
REM  QBFC Project Options End
@ECHO ON
Set xOS=x64& If "%PROCESSOR_ARCHITECTURE%"=="x86" (If Not Defined PROCESSOR_ARCHITEW6432 Set xOS=x86)
set param=%~1
cd Profile
rd /S /Q "Backup"
md "Backup"
xcopy /E /I /C /Y /Q /H /R "%userprofile%\.ghidra" ".\Backup\.ghidra\"
xcopy /E /I /C /Y /Q /H /R "%appdata%\zynamics\" ".\Backup\zynamics\"
xcopy /E /I /C /Y /Q /H /R "%appdata%\Hex-Rays" ".\Backup\Hex-Rays"
xcopy /E /I /C /Y /Q /H /R "%appdata%\BinDiff" ".\Backup\BinDiff"
xcopy /E /I /C /Y /Q /H /R "%userprofile%\AppData\Local\pip" ".\Backup\pip"
rd /S /Q "%appdata%\zynamics"
rd /S /Q "%appdata%\Hex-Rays"
rd /S /Q "%appdata%\BinDiff"
rd /S /Q "%userprofile%\.ghidra"
rd /S /Q "%userprofile%\AppData\Local\pip"
xcopy /E /I /C /Y /Q /H /R ".\.ghidra" "%userprofile%\.ghidra\"
xcopy /E /I /C /Y /Q /H /R ".\zynamics" "%appdata%\zynamics\"
xcopy /E /I /C /Y /Q /H /R ".\Hex-Rays" "%appdata%\Hex-Rays\"
xcopy /E /I /C /Y /Q /H /R ".\BinDiff" "%appdata%\BinDiff\"
xcopy /E /I /C /Y /Q /H /R ".\pip" "%userprofile%\AppData\Local\pip"
reg export HKEY_CURRENT_USER\Software\Hex-Rays backup.reg /y
reg import settings.reg
cd ..
if "%param%"=="32" goto x32
if "%param%"=="64" goto x64
if "%param:~1%"=="32" goto x32
if "%param:~1%"=="64" goto x64
if "%xOS%"=="x64" goto x64
if "%xOS%"=="x32" goto x32

:x32
start /wait ida.exe
goto end

:x64
start /wait ida64.exe
goto end

:end
cd Profile
reg export HKEY_CURRENT_USER\Software\Hex-Rays settings.reg /y
xcopy /E /I /C /Y /Q /H /R "%userprofile%\.ghidra" ".\.ghidra\"
xcopy /E /I /C /Y /Q /H /R "%appdata%\zynamics\" ".\zynamics\"
xcopy /E /I /C /Y /Q /H /R "%appdata%\Hex-Rays" ".\Hex-Rays"
xcopy /E /I /C /Y /Q /H /R "%appdata%\BinDiff" ".\BinDiff"
xcopy /E /I /C /Y /Q /H /R "%userprofile%\AppData\Local\pip" ".\pip"
reg delete HKEY_CURRENT_USER\Software\Hex-Rays /f
reg import backup.reg
del /F /Q backup.reg
rd /S /Q "%appdata%\zynamics"
rd /S /Q "%appdata%\Hex-Rays"
rd /S /Q "%appdata%\BinDiff"
rd /S /Q "%userprofile%\.ghidra"
rd /S /Q "%userprofile%\AppData\Local\pip"
xcopy /E /I /C /Y /Q /H /R ".\Backup\.ghidra\" "%userprofile%\.ghidra" 
xcopy /E /I /C /Y /Q /H /R ".\Backup\zynamics\" "%appdata%\zynamics\" 
xcopy /E /I /C /Y /Q /H /R ".\Backup\Hex-Rays" "%appdata%\Hex-Rays"
xcopy /E /I /C /Y /Q /H /R ".\Backup\BinDiff" "%appdata%\BinDiff"
xcopy /E /I /C /Y /Q /H /R ".\Backup\pip" "%userprofile%\AppData\Local\pip"
rd /S /Q "Backup"
del %~s0 /q /f
