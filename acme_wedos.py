#!/usr/bin/env python3

import datetime
import hashlib
import json
import logging
import os
import sys

import connexion
import pytz
import requests

WAPI_USER = os.getenv("WAPI_USER", "").strip()
WAPI_PASS = os.getenv("WAPI_PASS", "").strip()
WAPI_URL = "https://api.wedos.com/wapi/json"

LOGGER = logging.getLogger(__name__)
LOGGER.setLevel(logging.INFO)

def perform_request(request):
    LOGGER.info(f"WAPI Request: {json.dumps(request)}")
    response = requests.post(WAPI_URL, data={"request": json.dumps(request)})
    LOGGER.info(f"WAPI Response: {json.dumps(response.json())}")
    return response

def do_command(action, fqdn, value):
    if not WAPI_USER or not WAPI_PASS:
        LOGGER.error("WAPI_USER and WAPI_PASS must be set!")
        return
    if action not in ["present", "cleanup"]:
        LOGGER.error(f"Invalid action: {action}")
        return

    wapi_pass_hash = hashlib.sha1(WAPI_PASS.encode("UTF-8")).hexdigest()
    hour = datetime.datetime.now(tz=pytz.timezone("Europe/Prague")).hour
    auth = hashlib.sha1(f"{WAPI_USER}{wapi_pass_hash}{hour}".encode("UTF-8")).hexdigest()
    request = {"request": {"user": WAPI_USER, "auth": auth}}

    acme, domain = fqdn.split(".", 1)
    domain = domain[:-1] if domain.endswith(".") else domain

    if action == "present":
        request["request"]["command"] = "dns-row-add"
        request["request"]["data"] = {"domain": domain, "name": acme, "ttl": 1800, "type": "TXT", "rdata": value}
        perform_request(request)
        request["request"]["command"] = "dns-domain-commit"
        request["request"]["data"] = {"name": domain}
        perform_request(request)
    else:
        request["request"]["command"] = "dns-rows-list"
        request["request"]["data"] = {"domain": domain}
        response = perform_request(request)
        for record in response.json()["response"].get("data", {}).get("row", []):
            if record["rdtype"] == "TXT" and record["name"] == acme and record["rdata"] == value:
                request["request"]["command"] = "dns-row-delete"
                request["request"]["data"] = {"domain": domain, "row_id": record["ID"]}
                perform_request(request)
        request["request"]["command"] = "dns-domain-commit"
        request["request"]["data"] = {"name": domain}
        perform_request(request)


def present():
    data = connexion.request.get_json()
    LOGGER.info(f"present command: {data}")
    do_command("present", data["fqdn"], data["value"])
    return 200


def cleanup():
    data = connexion.request.get_json()
    LOGGER.info(f"cleanup command: {data}")
    do_command("cleanup", data["fqdn"], data["value"])
    return 200


def main():
    logging.basicConfig(format="%(asctime)s:%(levelname)s:%(name)s:%(message)s")
    app = connexion.FlaskApp(__name__, options={"openapi_spec_path": "/api/openapi.json"})
    app.add_api('openapi.spec.yml', validate_responses=True, strict_validation=True)

    @app.app.after_request
    def set_default_headers(response): # pylint: disable=unused-variable
        response.headers["Access-Control-Allow-Origin"] = "*"
        response.headers["Access-Control-Allow-Headers"] = "Content-Type, Access-Control-Allow-Headers"
        response.headers['Access-Control-Allow-Methods'] = 'GET, OPTIONS'
        return response

    app.run(host="0.0.0.0", port=8000)


if __name__ == "__main__":
    main()
