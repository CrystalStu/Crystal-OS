COLOR 6F
ECHO CHECKING RUNTIME...
IF NOT "%ADM%"=="1" (ECHO Need administrator permission.&&GOTO EXIT)
ver|find "6">nul&&GOTO SVK
ver|find "10">nul&&GOTO SVK
ECHO Cannot run without NT6/10.&&GOTO EXIT
:SVK
CLS
ECHO VERIFYING YOUR IDENTITY...
GIT config user.email >%CD%\tmp\user.dat
FOR /F %%i IN (tmp\user.dat) DO SET NOU=%%i
FOR /F %%i IN (permissions\%NOU%.per) DO SET REF=%%i
IF NOT "%CRYSTALOSDEVELOPRFIRST%" == "0" (CALL scripts\cr.bat)
IF NOT EXIST %CD%\permissions\%NOU%.per (ECHO No permission.&&GOTO EXIT)
IF "%REF%" == "0" (ECHO No permission remaining, ask TURX.&&GOTO EXIT)
IF "%CRYSTALOSDEVELOPRFIRST%" == "0" (IF NOT "%REF%"=="%CRYOSDEVREF%" (ECHO Permission had been modified, try to restart the administrative console or contact TURX.&&GOTO EXIT))
SET /A REF=%REF%-1
IF NOT "%CRYSTALOSDEVELOPRFIRST%" == "0" (GOTO VRK)
REM wmic ENVIRONMENT create name="CRYOSDEVREF",username="<system>",VariableValue="%REF%"
WMIC ENVIRONMENT where "name='CRYOSDEVREF' and username='<system>'" set VariableValue="%REF%"
ECHO %REF% >%CD%\permissions\%NOU%.per
:VRK
GOTO KE
:EXIT
ECHO WAEX >WAEX.tmp
:KE