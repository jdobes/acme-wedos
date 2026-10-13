FROM registry.access.redhat.com/ubi10/ubi-minimal:10.2-1791891203@sha256:552f8cc1ddb0bc9e411065c78499aa4dbc2c4ea9bd057aa0e6e44940db13acb5

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
