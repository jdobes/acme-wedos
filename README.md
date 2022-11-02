# acme-wedos
traefik dns-01 ACME lego httpreq (https://go-acme.github.io/lego/dns/httpreq/) microservice for wedos.cz

## Usage
    podman build -t acme_wedos -f ./Dockerfile .
    podman run -p 8000:8000 -e APP_USER=foo -e APP_PASS=bar --rm acme_wedos

    curl -u foo:bar -X POST -H "content-type: application/json" -d '{"fqdn": "_acme-challenge.domain.", "value": "aaaaaa"}' http://localhost:8000/present

## Release
    dnf install -y qemu-user-static # needed for buildah cross-arch build
    podman login docker.io

    podman build -f ./Dockerfile --platform linux/amd64,linux/arm64 --manifest acme_wedos .
    podman manifest inspect acme_wedos
    podman manifest push --all acme_wedos docker://docker.io/jdobes/acme_wedos:$(git rev-parse --short HEAD)
    podman manifest rm acme_wedos
