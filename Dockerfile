FROM registry.access.redhat.com/ubi10/ubi-minimal:10.1-1778576723@sha256:145c54e19de7ea25d958b54d981f95762d1a22d17f45fa8f013a5ea07f8ad68c

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
