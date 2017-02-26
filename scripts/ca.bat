REM #####################################################################
REM Crystal-OS
REM Powered by Crystal Studio
REM --------------------------------------------------------------------------------------------------
REM Modules: Crystal-OS Build Enviroment Check Administrator Status Batch (for Windows)
REM Programmers: TURX(turuixuan@foxmail.com)
REM Contact Address: No.150, Zhongshan Rd., Nanchang, Jiangxi Province, China (CHN330000)
REM #####################################################################

SET ADM=1
bcdedit.exe >NUL
IF ERRORLEVEL==1 SET ADM=0