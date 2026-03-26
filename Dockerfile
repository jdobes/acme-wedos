FROM registry.access.redhat.com/ubi10/ubi-minimal:10.1-1774545417@sha256:7bd3d2e7f5c507aebd1575d0f2fab9fe3e882e25fee54fa07f7970aa8bbc5fab

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
