@echo off
set regpath=HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment
set javahome=%~dp0jdk1.8.0_91
echo === 准备设置环境变量: JAVA_HOME=%javahome%
echo === 准备设置环境变量(后面有个.): classPath=%%JAVA_HOME%%\lib\tools.jar;%%JAVA_HOME%%\lib\dt.jar;.
echo === 准备设置环境变量: PATH=%%JAVA_HOME%%\bin
set /P EN=请确认后按 回车键 开始设置!
echo.
echo.
echo === 新创建环境变量 JAVA_HOME=%javahome%
setx "JAVA_HOME" "%javahome%"
echo === 新创建环境变量 classPath=%%JAVA_HOME%%\lib\tools.jar;%%JAVA_HOME%%%\lib\dt.jar;.
setx "classPath" "%%JAVA_HOME%%\lib\tools.jar;%%JAVA_HOME%%%\lib\dt.jar;."
echo === 新追加环境变量(追加到最前面) PATH=%%JAVA_HOME%%\bin
for /f "tokens=1,* delims=:" %%a in ('reg QUERY "%regpath%" /v "path"') do (
    set "L=%%a"
    set "P=%%b"
)
set "Y=%L:~-1%:%P%"
setx path "%%JAVA_HOME%%\bin;%Y%"
echo.
echo.
echo === 请按任意键退出! 
pause>nul