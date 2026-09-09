FROM registry.access.redhat.com/ubi10/ubi-minimal:10.2-1788940913@sha256:26dc3089ab24491c1ba01ab92a7d502d181425b6021e362a07484daee696a3aa

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
