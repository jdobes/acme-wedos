FROM registry.access.redhat.com/ubi10/ubi-minimal:10.2-1791321979@sha256:295f32b566834844b98ca6b51152b0a8a43d9d1d85d9bfd1cc6ce97748ef55d8

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
