FROM registry.access.redhat.com/ubi10/ubi-minimal:10.2-1785215492@sha256:e67b677631295d59d11e11f5f1406868e1228c2b5af426c9b3469a6732aaa144

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
