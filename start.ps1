Write-Output "Stopping w3svc"
Stop-Service w3svc

Write-Output "Running LogMonitor and ServiceMonitor"
C:\LogMonitor.exe C:\ServiceMonitor.exe w3svc