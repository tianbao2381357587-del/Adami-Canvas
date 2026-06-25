@echo off
setlocal
cd /d "%~dp0"
set "PYEXE=%~dp0python\python.exe"
if not exist "%PYEXE%" set "PYEXE=python"
if not exist logs mkdir logs

echo Installing dependencies...
"%PYEXE%" -m pip --version >NUL 2>&1
if errorlevel 1 (
    if exist "%~dp0get-pip.py" "%PYEXE%" "%~dp0get-pip.py"
)
"%PYEXE%" -m pip install --no-index --find-links="%~dp0packages" -r "%~dp0requirements.txt"
if errorlevel 1 (
    echo Local install failed. Trying online install...
    "%PYEXE%" -m pip install -r "%~dp0requirements.txt"
)
echo Done.
pause
