FROM registry.access.redhat.com/ubi10/ubi-minimal:10.2-1780550715@sha256:2c20ac20ca1ecbbbd583603feabd9cc51e7e8ea5a82e5088e20a9494794b2574

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
