FROM registry.access.redhat.com/ubi10/ubi-minimal:10.1-1778461919@sha256:a41db89ac688576827fbd3e8e3ef145fd7f4db28d7f533c154f96224fcd20595

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
