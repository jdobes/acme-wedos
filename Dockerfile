FROM registry.access.redhat.com/ubi10/ubi-minimal:10.1-1774228210@sha256:c858c2eb5bd336d8c400f6ee976a9d731beccf3351fa7a6f485dced24ae4af17

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
