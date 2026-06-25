@echo off
setlocal
cd /d "%~dp0"

set "PYEXE=%~dp0python\python.exe"
if not exist "%PYEXE%" set "PYEXE=python"

if not exist logs mkdir logs

echo ============================================
echo   Adami-Canvas
echo ============================================
echo Current folder: %cd%
echo Python: %PYEXE%
echo.

echo [1/4] Checking folder...
if not exist "%~dp0adami_canvas_backend\server.py" (
    echo ERROR: adami_canvas_backend\server.py not found.
    echo This usually means the zip was not fully extracted.
    pause
    exit /b 1
)

echo [2/4] Checking Python...
"%PYEXE%" --version
if errorlevel 1 (
    echo ERROR: Python cannot start.
    pause
    exit /b 1
)

echo.
echo [3/4] Checking dependencies...
"%PYEXE%" -c "import os,sys; sys.path.insert(0, os.getcwd()); import fastapi, uvicorn, requests, pydantic, httpx; import PIL; import adami_canvas_backend.server; print('deps and project import ok')"
if errorlevel 1 (
    echo.
    echo Dependencies or project import failed. Installing dependencies from local packages...
    "%PYEXE%" -m pip --version >NUL 2^>^&1
    if errorlevel 1 (
        if exist "%~dp0get-pip.py" (
            "%PYEXE%" "%~dp0get-pip.py"
        ) else (
            echo ERROR: pip is missing and get-pip.py was not found.
            pause
            exit /b 1
        )
    )
    "%PYEXE%" -m pip install --no-index --find-links="%~dp0packages" -r "%~dp0requirements.txt"
    if errorlevel 1 (
        echo.
        echo Local install failed. Trying online install...
        "%PYEXE%" -m pip install -r "%~dp0requirements.txt"
        if errorlevel 1 (
            echo ERROR: dependency install failed.
            pause
            exit /b 1
        )
    )
)

echo.
echo [4/4] Starting server...
echo Open this in browser: http://127.0.0.1:3000/
echo Keep this black window open while using the app.
echo.

start "" "http://127.0.0.1:3000/"
"%PYEXE%" "%~dp0main.py" 1^>"%~dp0logs\server.log" 2^>"%~dp0logs\last_error.log"

echo.
echo Server stopped or failed.
echo If browser cannot open, check logs\last_error.log below:
echo --------------------------------------------
if exist "%~dp0logs\last_error.log" type "%~dp0logs\last_error.log"
echo --------------------------------------------
pause


