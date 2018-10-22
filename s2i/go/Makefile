IMAGE ?= "go-s2i:latest"
INSTALL_PATH ?= /opt/app-root 
all: build
build:
	docker build -t $(IMAGE) --build-arg INSTALL_PATH=${INSTALL_PATH}.

clean:
	docker rmi $(IMAGE)

