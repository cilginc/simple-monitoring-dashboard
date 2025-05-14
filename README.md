# Simple Monitoring

This project is part of [roadmap.sh](https://roadmap.sh/projects/simple-monitoring-dashboard) DevOps projects.

## Install Netdata on a Linux system

```bash
cd simple-monitoring-dashboard
chmod +x setup.sh 
./setup.sh
```

This script configured to do:
- Install `stable` versions
- Disabled Telemetry

Access the dashboard on [localhost:19999](http://localhost:19999/)

## Test your system

```bash
chmod +x test_dashboard.sh
./test_dashboard.sh
```

## Clean your system

```bash
chmod +x cleanup.sh 
./cleanup.sh
```
