FROM mcr.microsoft.com/dotnet/framework/aspnet:4.8-windowsservercore-ltsc2019
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ARG LOGMONITOR_VERSION="v1.1"

COPY ./LogMonitorConfig.json C:\\LogMonitor\\LogMonitorConfig.json
COPY ./index.html C:\\inetpub\\wwwroot
COPY ./start.ps1 /start.ps1

RUN curl.exe -sSL -o /LogMonitor.exe "https://github.com/microsoft/windows-container-tools/releases/download/$($env:LOGMONITOR_VERSION)/LogMonitor.exe"

ENTRYPOINT ["powershell", "/start.ps1"]