FROM registry.access.redhat.com/ubi10/ubi-minimal:10.2-1777462752@sha256:5a1acbfad56de537f978184e662a02ba8141d82a3ce0d2aca183bfad812b0ea7

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
