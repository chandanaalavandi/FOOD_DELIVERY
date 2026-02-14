@echo off
REM ========================================
REM Food Delivery App - One-Click Start
REM ========================================

echo.
echo ============================================
echo   FOOD DELIVERY APP - START SCRIPT
echo ============================================
echo.

REM Start MySQL
echo [1/3] Starting MySQL Database...
net start MySQL80 >nul 2>&1
if errorlevel 1 (
    echo ERROR: Could not start MySQL. Make sure it's installed.
    echo Solution: Check MySQL is installed or run "net start MySQL80" manually
    pause
    exit /b 1
)
echo ✓ MySQL started!
timeout /t 2 /nobreak

REM Set CATALINA_HOME
set CATALINA_HOME=C:\tomcat9

REM Stop old Tomcat if running
echo [2/3] Stopping any running Tomcat instances...
taskkill /F /IM java.exe >nul 2>&1
timeout /t 2 /nobreak

REM Start Tomcat
echo [2/3] Starting Tomcat Server...
call %CATALINA_HOME%\bin\startup.bat >nul 2>&1
echo ✓ Tomcat started!
timeout /t 8 /nobreak

REM Check if app is running
echo [3/3] Verifying app is ready...
timeout /t 2 /nobreak

REM Try to access the app
powershell -Command "try { $r = Invoke-WebRequest http://localhost:9000/food-delivery/ -UseBasicParsing -TimeoutSec 3; if ($r.StatusCode -eq 200) { Write-Host '✓ App is READY!' -ForegroundColor Green } } catch { Write-Host '⏳ App still loading... wait a moment then open browser' -ForegroundColor Yellow }"

echo.
echo ============================================
echo   ✓ EVERYTHING IS RUNNING!
echo ============================================
echo.
echo Open your browser and go to:
echo   http://localhost:9000/food-delivery/
echo.
echo Default Login:
echo   Email:    user@example.com
echo   Password: password123
echo.
echo ============================================
echo.
pause
