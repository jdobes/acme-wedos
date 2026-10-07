FROM registry.access.redhat.com/ubi10/ubi-minimal:10.2-1791346265@sha256:91eaa992c90c4271691b047c12fec69cdabe7977305e168c4060f094ff2a73e0

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
