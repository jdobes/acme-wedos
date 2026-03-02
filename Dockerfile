FROM registry.access.redhat.com/ubi10/ubi-minimal:10.1-1772441549@sha256:29599cb2a44f3275232bc5fc48d26e069e8ba72b710229bed6652633725aa31a

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
