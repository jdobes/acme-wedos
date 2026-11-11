FROM registry.access.redhat.com/ubi10/ubi-minimal:10.3-1793834883@sha256:cc3d766e796fbb50d6fcd599f4bad4c231aeae41822c6e86e7da664a996221ca

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
