FROM registry.access.redhat.com/ubi10/ubi-minimal:10.2-1791269426@sha256:843abc6aab53312a9e3fb5edccbdb15c84794fe41e7b01de7447329ac1e086ad

ADD *.txt /acme_wedos/

RUN microdnf install -y python3-pip && microdnf clean all && \
    pip3 install -r /acme_wedos/requirements.txt && \
    rm -rf /root/.cache

ADD *.py /acme_wedos/
ADD *.yml /acme_wedos/

EXPOSE 8000

ENV WAPI_USER=user
ENV WAPI_PASS=pass

CMD python3 -m acme_wedos.acme_wedos
