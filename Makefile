include .env

.DEFAULT: all

all: build run
release: build tag push

build:
	@echo "[INFO] Building $(IMAGE) docker image"
	docker build -t $(IMAGE) .
run:
	@echo "[INFO] Running $(IMAGE) docker image"
	docker run \
		--rm \
		--detach=true \
		--name $(IMAGE) \
		--publish $(CNT_PORT):8080 \
		$(IMAGE)
		#--volume=data:/var/lib/geoserver-data 
tag:
	@echo "[INFO] Tagging $(IMAGE) docker image to $(IMAGE_TAG)"
	docker tag $(IMAGE):$(IMAGE_TAG) $(REGISTRY)/$(IMAGE):$(IMAGE_TAG)

push:
	@echo "[INFO] Pushing $(REGISTRY)/$(IMAGE)/$(IMAGE_TAG)"
	docker push $(REGISTRY)/$(IMAGE):$(IMAGE_TAG)
