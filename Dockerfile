FROM registry.access.redhat.com/ubi10/ubi-minimal:10.1-1776646707@sha256:8935d83eadb5c9f621c13f4dfab7e1bbd8d948317dc67157279911ede1013112

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
