IMAGE ?= "alpine-s2i:latest"

all: build

build:
	docker build -t $(IMAGE) .

push:
	docker push $(IMAGE)

clean:
	docker rmi $(IMAGE)

