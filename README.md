# acme-wedos
traefik dns-01 ACME lego httpreq (https://go-acme.github.io/lego/dns/httpreq/) microservice for wedos.cz

## Usage
    podman build -t acme_wedos -f api/Dockerfile .
    podman run -p 8000:8000 --rm acme_wedos

    curl -X POST -H "content-type: application/json" -d '{"fqdn": "_acme-challenge.domain.", "value": "aaaaaa"}' http://localhost:8000/present

## Multi-arch build
    docker buildx build --platform linux/amd64,linux/arm64 --push -t jdobes/acme_wedos:latest -t jdobes/acme_wedos:0.1 .
