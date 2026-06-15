FROM registry.access.redhat.com/ubi10/ubi-minimal:10.2-1781509346@sha256:76c113359a458e3f04057762b5bd4a9837a6987520434dea158c728280116713

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
