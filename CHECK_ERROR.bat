@echo off
setlocal
cd /d "%~dp0"
set "PYEXE=%~dp0python\python.exe"
if not exist "%PYEXE%" set "PYEXE=python"

echo ============================================
echo   Adami-Canvas Diagnose
echo ============================================
echo Folder: %cd%
echo Python: %PYEXE%
echo.

"%PYEXE%" --version
echo.

echo Project folder check:
if exist "%~dp0adami_canvas_backend\server.py" (echo adami_canvas_backend OK) else (echo adami_canvas_backend MISSING)
echo.

echo Python path and import check:
"%PYEXE%" -c "import os,sys; print('cwd=', os.getcwd()); print('before=', sys.path[:5]); sys.path.insert(0, os.getcwd()); print('after=', sys.path[:5]); import adami_canvas_backend.server; print('import adami_canvas_backend OK')"
echo.

echo Dependency check:
"%PYEXE%" -c "import fastapi; print('fastapi OK')"
"%PYEXE%" -c "import uvicorn; print('uvicorn OK')"
"%PYEXE%" -c "import requests; print('requests OK')"
"%PYEXE%" -c "import pydantic; print('pydantic OK')"
"%PYEXE%" -c "import httpx; print('httpx OK')"
"%PYEXE%" -c "import PIL; print('PIL OK')"
echo.

echo Last error log:
if exist logs\last_error.log type logs\last_error.log
pause


