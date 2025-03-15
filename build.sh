#!/bin/bash
set -Eeuo pipefail

docker build . -t "$REGISTRY/sparnord/arch:$BUILD_VERSION"
docker tag "$REGISTRY/sparnord/arch:$BUILD_VERSION" "$REGISTRY/sparnord/arch:latest"

if [[ $1 == "--release" ]]; then
	docker login "$REGISTRY" -u "$USERNAME" -p "$PASSWORD"
	docker push "$REGISTRY/sparnord/arch:$BUILD_VERSION"
	docker push "$REGISTRY/sparnord/arch:latest"
	docker logout "$REGISTRY"
fi
