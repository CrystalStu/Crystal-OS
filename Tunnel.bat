@ECHO OFF

REM #####################################################################
REM Crystal-OS
REM Powered by Crystal Studio
REM --------------------------------------------------------------------------------------------------
REM Modules: Crystal-OS Communication Tunnel (for Windows)
REM Programmers: TURX(turuixuan@foxmail.com)
REM Contact Address: No.150, Zhongshan Rd., Nanchang, Jiangxi Province, China (CHN330000)
REM #####################################################################

SET ENEM=If you use the command except [1] now, you will probably cannot work your git out.
ECHO CHECKING...
ECHO\
GIT version
IF NOT "%ERRORLEVEL%"=="0" (SET GITSTATE=Uninstalled. Please use [1] to install that.&&SET ENE=%ENEM%) ELSE (SET GITSTATE=Already installed.&&SET ENE=You can do your work properly.)
GIT LFS version
IF NOT "%ERRORLEVEL%"=="0" (SET LFSSTATE=Uninstalled. Please use [1] to install that, if you installed that, please try to restart your computer and reopen the window again.&&SET ENE=%ENEM%) ELSE (SET LFSSTATE=Already installed.&&SET ENE=You can do your work properly.)

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
ECHO ---------------------------------------------
SET/P SOLUTION=Please enter what you want to do (1-4): 
ECHO\

IF "%SOLUTION%"=="1" (GOTO 1S) ELSE GOTO 1E
:1S
	START /WAIT installer\Git-Base.exe
	START /WAIT installer\Git-Large-File-Support.exe
	SET PATH=%PATH%;C:\Program Files\Git LFS
	GIT-LFS install
	GOTO UNPACK
REM	GOTO EXIT
:1E
IF "%SOLUTION%"=="2" (GOTO 2S) ELSE GOTO 2E
:2S
	pack.exe a -hp%PSW% -m5 -y -as -ed repo\code.repo Crystal-OS\Code
REM	pack.exe a -hp%PSW% -m5 -y -as -ed repo\tool-mingw.repo Crystal-OS\Tools\mingw
REM	pack.exe a -hp%PSW% -m5 -y -as -ed repo\tool-nasm.repo Crystal-OS\Tools\nasm
REM	pack.exe a -hp%PSW% -m5 -y -as -ed repo\tool-nasm-64.repo Crystal-OS\Tools\nasm_64
REM	pack.exe a -hp%PSW% -m5 -y -as -ed repo\tool-qemu.repo Crystal-OS\Tools\qemu
REM	pack.exe a -hp%PSW% -m5 -y -as -ed repo\tool-winhex.repo Crystal-OS\Tools\winhex
REM	pack.exe a -hp%PSW% -m5 -y -as -ed repo\tool-winimage.repo Crystal-OS\Tools\winimage
	ECHO /Crystal-OS>.gitignore
	ECHO /DEVTMP>>.gitignore
	ECHO pass.dat>>.gitignore
	ECHO /repo filter=lfs diff=lfs merge=lfs -text>.gitattributes
	ECHO *.repo filter=lfs diff=lfs merge=lfs -text>>.gitattributes
	GIT add .
	GIT commit -a -m "COMMIT_REQUEST_BY_TUNNEL (D:%CD%,T:%TIME%,U:%USERNAME%)"
	GIT push origin master
	GOTO EXIT
:2E
IF "%SOLUTION%"=="3" (GOTO 3S) ELSE GOTO 3E
:3S
	GIT fetch
	GIT pull origin master
	pack.exe x -p%PSW% -y repo\code.repo
	GOTO EXIT
:3E
IF "%SOLUTION%"=="4" (GOTO 4S) ELSE GOTO 4E
:4S
	GOTO EXIT
:4E
IF "%SOLUTION%"=="5" (GOTO 5S) ELSE GOTO 5E
:5S
:5E

ECHO Command not found.
GOTO EXIT

:UNPACK
	pack.exe x -p%PSW% -y repo\code.repo
	pack.exe x -p%PSW% -y repo\tool-mingw.repo
	pack.exe x -p%PSW% -y repo\tool-nasm.repo
	pack.exe x -p%PSW% -y repo\tool-nasm-64.repo
	pack.exe x -p%PSW% -y repo\tool-qemu.repo
	pack.exe x -p%PSW% -y repo\tool-winhex.repo
	pack.exe x -p%PSW% -y repo\tool-winimage.repo
	GOTO EXIT

:EXIT
	ECHO Compele!
	ECHO\
	ECHO Press any key to exit..
	PAUSE >NUL
	COLOR 07
	ECHO SESSION ENDED.