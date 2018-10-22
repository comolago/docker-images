# Golang Image
Edit the files to fit version to what you need.

For example, to set it to build Golang 1.7 image, modify 
```
spec:
  output:
    to:
      kind: ImageStreamTag
      name: go-s2i:1.7
  strategy:
    type: Docker
    dockerStrategy:
      from:
        kind: DockerImage
        name: docker.io/library/golang:1.7
```
otherwise, if the defined version is the one you want, simply leave it unmodified

Switch to a project dedicated to images to be used for software compilation purposes, for example
```
oc project toolchain
```
Create the imagestream
```
oc apply -f imagestream.yaml  
```
Create The build configuration
```
oc apply -f buildconfig.yaml 
```
Build it
```
oc start-build go-s2i
```
Wait until it completes
```
oc get builds
NAME       TYPE      FROM          STATUS     STARTED              DURATION
go-s2i-1   Docker    Git@3c6e7c2   Complete   About a minute ago   11s
```
