#!/bin/bash
set -Eeuo pipefail

docker build . -t "$REGISTRY/delusionallogic/arch-dev:$BUILD_VERSION"
docker tag "$REGISTRY/delusionallogic/arch-dev:$BUILD_VERSION" "$REGISTRY/delusionallogic/arch-dev:latest"

if [[ $1 == "--release" ]]; then
	docker login "$REGISTRY" -u "$USERNAME" -p "$PASSWORD"
	docker push "$REGISTRY/delusionallogic/arch-dev:$BUILD_VERSION"
	docker push "$REGISTRY/delusionallogic/arch-dev:latest"
	docker logout "$REGISTRY"
fi
