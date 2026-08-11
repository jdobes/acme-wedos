FROM registry.access.redhat.com/ubi10/ubi-minimal:10.2-1786398535@sha256:1e429ea364534f7baf494bac5cc54996b9b9d300f1da90e7b1dfa0ce455bfe39

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
