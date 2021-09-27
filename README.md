# win-aspnet-docker-demo
Runs a simple ASP.NET 4.8 image, based on Windows Server 2019 Core.

## Usage
You may substitute someapp with whatever name you please.

```
docker build . -t someapp:latest
docker run -d --name someapp -p 8080:80 someapp:latest
curl http://localhost:8080
docker logs someapp --follow
```

The last command locks you into a live log reader. After a little bit, [LogMonitor](https://github.com/microsoft/windows-container-tools/tree/master/LogMonitor) logs should start flowing into the terminal if you refresh http://localhost:8080 in the browser. (IIS writes a bit slowly)

## Files

### Dockerfile
- Uses ASP.NET 4.8 on Windows Server core 2019 LTSC. Auto-installs IIS. (WebServer)
- Powershell ErrorAction is modified to allow [LogMonitor](https://github.com/microsoft/windows-container-tools/tree/master/LogMonitor) and [ServiceMonitor](https://github.com/Microsoft/IIS.ServiceMonitor) to throw warnings without critical failure.
- LOGMONITOR_VERSION is used to download the desired version of [LogMonitor](https://github.com/microsoft/windows-container-tools/tree/master/LogMonitor).
- Configs and startup are copied.
- curl.exe is used to download [LogMonitor](https://github.com/microsoft/windows-container-tools/tree/master/LogMonitor).
- start.ps1 is the ENTRYPOINT.

### start.ps1
- Stops w3svc and hands it over to [ServiceMonitor](https://github.com/Microsoft/IIS.ServiceMonitor), which will kill the container if the App Pool stops/dies/restarts.
- Runs [LogMonitor](https://github.com/microsoft/windows-container-tools/tree/master/LogMonitor) and [ServiceMonitor](https://github.com/Microsoft/IIS.ServiceMonitor) and starts w3svc with both attached.

### LogMonitorConfig.json
- Configures [LogMonitor](https://github.com/microsoft/windows-container-tools/tree/master/LogMonitor).

### index.html
- Whatever page you want shown on the localhost root.