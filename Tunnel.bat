@ECHO OFF

REM #####################################################################
REM Crystal-OS
REM Powered by Crystal Studio
REM --------------------------------------------------------------------------------------------------
REM Modules: Crystal-OS Communication Tunnel (for Windows)
REM Programmers: TURX(turuixuan@foxmail.com)
REM Contact Address: No.150, Zhongshan Rd., Nanchang, Jiangxi Province, China (CHN330000)
REM #####################################################################

IF "%DBG%"=="1" (@ECHO ON)

SET ENEM=If you use the command except [1] now, you will probably cannot work your git out.
ECHO CHECKING RUNTIME...
ECHO\
GIT version
IF NOT "%ERRORLEVEL%"=="0" (SET GITSTATE=Uninstalled. Please use [1] to install that.&&SET ENE=%ENEM%&&SET INSTALLED=0) ELSE (SET GITSTATE=Already installed.&&SET ENE=You can do your work properly.&&SET INSTALLED=1)
GIT LFS version
IF NOT "%ERRORLEVEL%"=="0" (SET LFSSTATE=Uninstalled. Please use [1] to install that, if you installed that, please try to restart your computer and reopen the window again.&&SET ENE=%ENEM%&&SET INSTALLED=0) ELSE (SET LFSSTATE=Already installed.&&SET ENE=You can do your work properly.&&SET INSTALLED=1)
CALL scripts\ca.bat
CLS

CALL scripts\cl.bat
IF EXIST WAEX.tmp (DEL WAEX.TMP /F /Q&&GOTO EXIT)
CLS

COLOR 3F
FOR /F %%i IN (pass.dat) DO SET PSW=%%i

TITLE Crystal-OS Communication Tunnel
ECHO Crystal-OS Communication Tunnel
ECHO ---------------------------------------------
ECHO Tasks:
ECHO 1) Install;
ECHO 2) Upload;
ECHO 3) Update;
ECHO 4) Exit.
ECHO ---------------------------------------------
ECHO Information:
ECHO Now directory: %CD%
ECHO Now time:      %TIME%
ECHO ---------------------------------------------
ECHO Environment:
ECHO Git     installed: %GITSTATE%
ECHO Git-LFS installed: %LFSSTATE%
ECHO Result           : %ENE%
ECHO Now Git Account  : %NOU%
ECHO Times Remaining  : %REF%
ECHO ---------------------------------------------
SET/P SOLUTION=Please enter what you want to do (1-4): 
ECHO\

IF "%SOLUTION%"=="1" (GOTO 1S) ELSE GOTO 1E
:1S
	IF "%INSTALLED%"=="1" (GOTO 1K)
	START /WAIT installer\Git-Base.exe
	START /WAIT installer\Git-Large-File-Support.exe
	SET PATH=%PATH%;C:\Program Files\Git LFS
	GIT-LFS install
:1K
	IF "%INSTALLED%"=="0" (ECHO Your environment has not got ready now to unpack.&&GOTO EXIT)
	GOTO UNPACK
REM	GOTO EXIT
:1E
IF "%SOLUTION%"=="2" (GOTO 2S) ELSE GOTO 2E
:2S
	pack.exe a -hp%PSW% -m5 -y -as -ed repo\code.rar Crystal-OS\Code
REM	pack.exe a -hp%PSW% -m5 -y -as -ed repo\tool-mingw.rar Crystal-OS\Tools\mingw
REM	pack.exe a -hp%PSW% -m5 -y -as -ed repo\tool-nasm.rar Crystal-OS\Tools\nasm
REM	pack.exe a -hp%PSW% -m5 -y -as -ed repo\tool-nasm-64.rar Crystal-OS\Tools\nasm_64
REM	pack.exe a -hp%PSW% -m5 -y -as -ed repo\tool-qemu.rar Crystal-OS\Tools\qemu
REM	pack.exe a -hp%PSW% -m5 -y -as -ed repo\tool-winhex.rar Crystal-OS\Tools\winhex
REM	pack.exe a -hp%PSW% -m5 -y -as -ed repo\tool-winimage.rar Crystal-OS\Tools\winimage
	ECHO /repo filter=lfs diff=lfs merge=lfs -text>.gitattributes
	ECHO *.rar filter=lfs diff=lfs merge=lfs -text>>.gitattributes
	GIT add .
	GIT commit -a -m "COMMIT_REQUEST_BY_TUNNEL (D:%CD%,T:%TIME%,U:%USERNAME%)"
	GIT push origin master
	GOTO EXIT_NORMAL
:2E
IF "%SOLUTION%"=="3" (GOTO 3S) ELSE GOTO 3E
:3S
	GIT fetch
	GIT pull origin master
	pack.exe x -p%PSW% -y repo\code.rar
	GOTO EXIT_NORMAL
:3E
IF "%SOLUTION%"=="4" (GOTO 4S) ELSE GOTO 4E
:4S
	GOTO EXIT_NORMAL
:4E
IF "%SOLUTION%"=="5" (GOTO 5S) ELSE GOTO 5E
:5S
:5E

ECHO Command not found.
GOTO EXIT

:UNPACK
	pack.exe x -p%PSW% -y repo\code.rar
	pack.exe x -p%PSW% -y repo\tool-mingw.rar
	pack.exe x -p%PSW% -y repo\tool-nasm.rar
	pack.exe x -p%PSW% -y repo\tool-nasm-64.rar
	pack.exe x -p%PSW% -y repo\tool-qemu.rar
	pack.exe x -p%PSW% -y repo\tool-winhex.rar
	pack.exe x -p%PSW% -y repo\tool-winimage.rar
	GOTO EXIT_NORMAL

:EXIT_NORMAL
	ECHO Compele!
	ECHO\
:EXIT
	ECHO Press any key to exit..
	PAUSE >NUL
	START CMD.EXE /K @ECHO Session ended at %TIME%, but the console cannot use to reopen the tunnel.
	EXIT