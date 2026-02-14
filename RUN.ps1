# ========================================
# Food Delivery App - One-Click Start
# ========================================

Write-Host "`n" -ForegroundColor Blue
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "   FOOD DELIVERY APP - START SCRIPT" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "`n"

# Step 1: Start MySQL
Write-Host "[1/3] Starting MySQL Database..." -ForegroundColor Yellow
try {
    net start MySQL80 2>$null | Out-Null
    Write-Host "✓ MySQL started!" -ForegroundColor Green
    Start-Sleep -Seconds 2
} catch {
    Write-Host "⚠ MySQL may already be running or not installed" -ForegroundColor Yellow
    Start-Sleep -Seconds 1
}

# Step 2: Stop old Tomcat if running
Write-Host "[2/3] Stopping any old Tomcat instances..." -ForegroundColor Yellow
Stop-Process -Name java -Force -ErrorAction SilentlyContinue
Start-Sleep -Seconds 2

# Step 3: Start Tomcat
Write-Host "[2/3] Starting Tomcat Server..." -ForegroundColor Yellow
$env:CATALINA_HOME = 'C:\tomcat9'

if (Test-Path 'C:\tomcat9\bin\startup.bat') {
    & 'C:\tomcat9\bin\startup.bat' 2>$null | Out-Null
    Write-Host "✓ Tomcat started!" -ForegroundColor Green
    Write-Host "⏳ Waiting for app to initialize..." -ForegroundColor Cyan
    Start-Sleep -Seconds 8
} else {
    Write-Host "✗ ERROR: Tomcat not found at C:\tomcat9" -ForegroundColor Red
    Write-Host "  Please check your Tomcat installation path" -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}

# Step 4: Verify app is running
Write-Host "[3/3] Verifying app is ready..." -ForegroundColor Yellow
$appReady = $false
for ($i = 1; $i -le 5; $i++) {
    try {
        $response = Invoke-WebRequest 'http://localhost:9000/food-delivery/' -UseBasicParsing -TimeoutSec 2 -ErrorAction Stop
        if ($response.StatusCode -eq 200) {
            $appReady = $true
            break
        }
    } catch {
        Write-Host "  Attempt $i/5..." -ForegroundColor DarkGray
        Start-Sleep -Seconds 1
    }
}

if ($appReady) {
    Write-Host "✓ App is READY!" -ForegroundColor Green
} else {
    Write-Host "⏳ App is starting... may take a moment" -ForegroundColor Yellow
}

# Summary
Write-Host "`n"
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "   ✓ EVERYTHING IS RUNNING!" -ForegroundColor Green
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "`n"

Write-Host "📱 Open your browser and go to:" -ForegroundColor Cyan
Write-Host "   http://localhost:9000/food-delivery/" -ForegroundColor White
Write-Host "`n"

Write-Host "🔑 Default Login:" -ForegroundColor Cyan
Write-Host "   Email:    user@example.com" -ForegroundColor White
Write-Host "   Password: password123" -ForegroundColor White
Write-Host "`n"

Write-Host "💡 Or create a new account using the Signup button" -ForegroundColor Yellow
Write-Host "`n"

Write-Host "✨ Enjoy your modern Food Delivery App! 🍕" -ForegroundColor Green
Write-Host "`n"

# Display running processes
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "   Active Services:" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""
netstat -ano | Select-String ":3306|:9000" | ForEach-Object {
    Write-Host "   $_" -ForegroundColor Green
}
Write-Host ""

# Keep window open
Read-Host "Press Enter to exit"
