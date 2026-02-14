# 🚀 Food Delivery App - Quick Start Guide

## Prerequisites
- MySQL 8.0 running
- Java 17 installed
- Tomcat 9 at `C:\tomcat9`

---

## ⚡ Step 1: Start MySQL Database

Open **PowerShell as Administrator** and run:

```powershell
net start MySQL80
```

**To verify MySQL is running:**
```powershell
netstat -ano | findstr :3306
```

---

## ⚡ Step 2: Start Tomcat Server

Open **PowerShell** and run:

```powershell
$env:CATALINA_HOME = 'C:\tomcat9'; & 'C:\tomcat9\bin\startup.bat'
```

**Wait 5-10 seconds for Tomcat to start** (you'll see Java processes starting)

**To verify Tomcat is running:**
```powershell
netstat -ano | findstr :9000
```

---

## ⚡ Step 3: Check if App is Ready

Open **PowerShell** and run:

```powershell
Invoke-WebRequest http://localhost:9000/food-delivery/ -UseBasicParsing
```

You should see: `StatusCode : 200` ✅

---

## 🌐 Step 4: Open in Browser

### Access the app:
```
http://localhost:9000/food-delivery/
```

---

## 📝 Default Login Credentials

| Field | Value |
|-------|-------|
| **Email** | user@example.com |
| **Password** | password123 |

Or create a new account using the Signup button.

---

## 🛑 To Stop Everything

### Stop Tomcat:
```powershell
$env:CATALINA_HOME = 'C:\tomcat9'; & 'C:\tomcat9\bin\shutdown.bat'
```

### Stop MySQL:
```powershell
net stop MySQL80
```

---

## 🔍 If Something Goes Wrong

### Check Tomcat Logs:
```powershell
Get-Content 'C:\tomcat9\logs\catalina.log' -Tail 20
```

### Restart Everything:
```powershell
# Stop
$env:CATALINA_HOME = 'C:\tomcat9'; & 'C:\tomcat9\bin\shutdown.bat'; Start-Sleep -s 3

# Start MySQL
net start MySQL80; Start-Sleep -s 2

# Start Tomcat
& 'C:\tomcat9\bin\startup.bat'; Start-Sleep -s 5

# Verify
Invoke-WebRequest http://localhost:9000/food-delivery/ -UseBasicParsing
```

---

## 📱 App Features

✅ **Authentication** - Sign up & Login  
✅ **Browse Restaurants** - View all restaurants  
✅ **Select Menu Items** - View items for each restaurant  
✅ **Add to Cart** - Add items with quantity  
✅ **Checkout** - Place orders with delivery address  
✅ **Order History** - View past orders  
✅ **Profile** - Manage user profile  
✅ **Dark Mode** - Toggle dark/light theme  
✅ **Responsive Design** - Works on desktop & mobile  

---

## 🎨 Modern UI Features

- Gradient backgrounds & buttons
- Smooth hover animations
- Glass-morphism effects
- Dark mode support
- Professional card designs
- Fast back navigation fixed

---

## 💡 Tips

- **Images not loading?** The app may still be deploying. Wait 10 seconds.
- **Port 9000 in use?** Kill the process: `Stop-Process -Port 9000 -Force`
- **Need to rebuild?** From project folder: `mvn clean package -DskipTests`

---

**Enjoy your Food Delivery App! 🍕**
