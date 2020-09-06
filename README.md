# Geoserver service sample on Docker

## Setup

Build and run the project:
```
make build
make run
```

Build and release the project:
```
make build
make tag
make push
```
Custom configuration files can go in the directory `./rootfs/usr/local/tomcat/webapps/geoserver`

## TODOs

- Need to parse with variable the web.xml file
