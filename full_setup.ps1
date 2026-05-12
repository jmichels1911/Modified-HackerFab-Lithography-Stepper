# Full System Setup for Lithography Stepper
Write-Host "Starting Full System Setup..." -ForegroundColor Cyan

# --- STEP 1: CHECK AND INSTALL PYTHON ---
$pythonVersion = "3.10.11"
$installerPath = "$env:TEMP\python-$pythonVersion-amd64.exe"
$downloadUrl = "https://www.python.org/ftp/python/$pythonVersion/python-$pythonVersion-amd64.exe"

Write-Host "`nChecking for Python 3.10..."
$pythonCheck = try { py -3.10 --version 2>&1 } catch { $null }

if ($pythonCheck -notmatch "Python 3.10") {
    Write-Host "Python 3.10 not found. Downloading official installer..." -ForegroundColor Yellow
    Invoke-WebRequest -Uri $downloadUrl -OutFile $installerPath
    
    Write-Host "Installing Python 3.10 silently... (This may take a minute)" -ForegroundColor Yellow
    # /quiet hides the UI. PrependPath=1 adds Python to Windows environment variables.
    Start-Process -FilePath $installerPath -ArgumentList "/quiet InstallAllUsers=0 PrependPath=1 Include_test=0" -Wait
    Write-Host "Python installed successfully!" -ForegroundColor Green
    
    # Force the current terminal to recognize the newly installed Python path
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
} else {
    Write-Host "Python 3.10 is already installed." -ForegroundColor Green
}

# --- STEP 2: INSTALL LIBRARIES ---
Write-Host "`nInstalling standard Python libraries from requirements.txt..." -ForegroundColor Cyan
# Upgrade pip first to avoid errors with newer packages
py -3.10 -m pip install --upgrade pip
py -3.10 -m pip install -r requirements.txt
py -3.10 -m pip install spinnaker_python-4.3.0.190-cp310-cp310-win_amd64.whl

# --- STEP 3: FLIR WARNING ---
Write-Host "`n=======================================================" -ForegroundColor Yellow
Write-Host "IMPORTANT: FLIR CAMERA (PySpin) NOT INCLUDED IN PIP" -ForegroundColor Yellow
Write-Host "=======================================================" -ForegroundColor Yellow
Write-Host "Remember to install your Spinnaker SDK Python wheel manually:"
Write-Host "py -3.10 -m pip install spinnaker_python-3.X.X.X-cp310-cp310-win_amd64.whl`n"
Read-Host -Prompt "Press Enter to exit"
