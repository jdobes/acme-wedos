FROM registry.access.redhat.com/ubi10/ubi-minimal:10.2-1791784796@sha256:9712ae522acef7e90c571280b4faf69614b59395448d6bfb1c780c3bbf168218

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
