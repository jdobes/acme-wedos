FROM registry.access.redhat.com/ubi10/ubi-minimal:10.2-1792457157@sha256:c769ab6615ab32d02d5b3d65ff2eae6bc668ba823e77f46b78a4181f54d17a27

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
