# PowerShell script to run the Lithography Stepper GUI
Write-Host "Starting the Hacker Fab Lithography Stepper GUI..."
#update the below command to the specific file location
cd C:\Users\OWNER\Downloads\stepper_modified\stepper_modified
py -3.10 ./src/gui.py
