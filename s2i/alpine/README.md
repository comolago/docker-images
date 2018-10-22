# Alpine Linux S2I Runtime Image

## Overview
This Docker image can be used as **runtime** image to **create very compact application Docker images**.

This is usefull for example with Golang (GO) applications, since they can be compiled to run without the need of shared libraries.
This allows to create images of **a few tens of MB in size**!

At container start, by default it runs */opt/app-root/bin/container-entrypoint*, so this **has to be your main application binary path (or a symlink to it)**: this is to provide something thant can be easily boot-up proiding the fewest options.

By doing so, simply issuing:

`$ docker run -d -v8080:8080 yourapp`

is enough to start your application.

## Container creation
Assign it a name, make it  and push it to your registry:
 
```
$ export IMAGE=registry.domain.local:5000/prod/s2i/alpine:3.8
$ make
$ make push
```
In this example your registry URL is *registry.domain.local:5000* and your are storing *alpine:3.8* image beneath *prod/s2i* path.

## Building your application and injecting it into the runtime image
This is a 2 steps process: you have to

* **build** your application using a **scratch S2I** Docker image
* **inject** the results of the build of the previous step into the **S2I Runtime** Docker image, so to create a new Docker image with your application inside it.

Sample invocation is:

`$ s2i build <source code path/URL> <scratch-s2i> <new-app-image-name> --runtime-image=<runtime-s2i>`

where:

* **source code path/URL** is the path of the GIT repo of the application you are building
* **scratch-s2i** is the S2I docker image you are going to use to build your application
* **new-app-image-name** is the name you want to assign to the Docker image of the application you are building
* **runtime-s2i** is the name of Alpine Linux S2I Runtime Image

For example:

`$ s2i build https://github.com/user/app.git registry.domain.local:5000/prod/s2i/go:1.11 app --runtime-image=registry.domain.local:5000/prod/s2i/alpine:3.8`

In this example we are using an S2I enhanced version of the official Golang 1.11 image to build the application source, and then we inject the compiled runtimes into the S2I enhanced Alpine 3.8 Runtime image.
