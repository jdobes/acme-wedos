FROM registry.access.redhat.com/ubi10/ubi-minimal:10.2-1779722607@sha256:6edd84087c7c05b9464de987d9a9bc210be1ec9c426aa6c5aaff39aa32f0bbc3

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
