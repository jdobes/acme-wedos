FROM registry.access.redhat.com/ubi10/ubi-minimal:10.1-1776834797@sha256:2a4785f399dc7ae2f3ca85f68bac0ccac47f3e73464a47c21e4f7ae46b55a053

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
