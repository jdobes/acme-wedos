FROM registry.access.redhat.com/ubi10/ubi-minimal:10.2-1782283038@sha256:5bc43c1af14ccc8bf73bb0306db13edcae1a30589569e9cdf7db5d4668b3ed24

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
