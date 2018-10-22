# Golang S2I Scratch Image
## Overview
This docker image can be used as a **scratch** image to build Golang (Go) applications that can be later injected into a **runtime** S2I image to create application Docker images.
## Openshift
See [here](/openshift/s2i/go)
## Docker / Kubernetes
### Container creation
Assign it a name, make it  and push it to your registry:
 
```
$ export GO_VERSION=1.11
$ export IMAGE=registry.domain.local:5000/prod/s2i/go:${GO_VERSION}
$ make
$ make push
```
In this example your registry URL is *registry.domain.local:5000* and your are storing *go:1.11* image beneath *prod/s2i* path.

### Application requisites
* Application project should be handled by **make**
* Makefile should have an **install** goal that installs under *${INSTALL_PATH}* - INSTALL_PATH should be an environment variable, so that you can redefine it as you like. S2I scratch file defines it by defaults to */opt/app-root*.

```
install:
        mkdir -p ${INSTALL_PATH}/bin
        cp ${GOBIN}/* ${INSTALL_PATH}/bin
	... other stuff ...
```
* Makefile should have a **define-entrypoint** goal, that defines the main binary of your application. This is the binary that is executed at container startup, and the path **should** be *${INSTALL_PATH}/bin/container-entrypoint*.

An example snippet is:

```
define-entrypoint:
        ln -s ${INSTALL_PATH}/bin/${APP} ${INSTALL_PATH}/bin/container-entrypoint
```

### Building your application and injecting it into the runtime image
This is a 2 steps process: you have to

* **build** your application using a **scratch S2I** Docker image
* **inject** the results of the build of the previous step into the **S2I runtime** Docker image, so to create a new Docker image with your application inside it.

Sample invocation is:

`$ s2i build <source code path/URL> <scratch-s2i> <new-app-image-name> --runtime-image=<runtime-s2i>`

where:

* **source code path/URL** is the path of the GIT repo of the application you are building
* **scratch-s2i** is the S2I scratch Docker image you are going to use to build your application
* **new-app-image-name** is the name you want to assign to the Docker image of the application you are building
* **runtime-s2i** is the name of the S2I runtime Image

For example:

`$ s2i build https://github.com/user/app.git registry.domain.local:5000/prod/s2i/go:1.11 app --runtime-image=registry.domain.local:5000/prod/s2i/alpine:3.8`

In this example we are using an S2I enhanced version of the official Golang 1.11 image to build the application source, and then we inject the compiled runtimes into the S2I enhanced Alpine 3.8 runtime image. 
