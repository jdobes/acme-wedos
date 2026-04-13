FROM registry.access.redhat.com/ubi10/ubi-minimal:10.1-1776071394@sha256:7fabf2ff42ba1c2b3e4efcdd9ae25de0bce0592edf59151b41e58057b40898ce

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
