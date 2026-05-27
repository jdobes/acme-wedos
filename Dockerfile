FROM registry.access.redhat.com/ubi10/ubi-minimal:10.2-1779862102@sha256:7dc60d7777e010c50f5e041ff069112b379c3d5eef2823d20871c67cf663f10c

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
