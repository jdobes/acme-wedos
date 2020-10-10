# acme-wedos
traefik dns-01 ACME lego httpreq (https://go-acme.github.io/lego/dns/httpreq/) microservice for wedos.cz

## Usage
    podman build -t lunch_api -f api/Dockerfile .
    podman run -p 8000:8000 --rm acme_wedos

    curl -X POST -H "content-type: application/json" -d '{"fqdn": "_acme-challenge.domain.", "value": "aaaaaa"}' http://localhost:8000/present
