IMAGE = empatica/jnlp-slave-with-java-build-tools
VERSION = 3.3-1

.PHONY: build push release

default: release

build:
	docker build -t $(IMAGE):$(VERSION) .

push:
	docker push $(IMAGE):$(VERSION)

release: build push
	docker tag $(IMAGE):$(VERSION) $(IMAGE):latest
	docker push $(IMAGE):latest
