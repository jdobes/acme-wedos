FROM registry.access.redhat.com/ubi10/ubi-minimal:10.2-1784094212@sha256:af74bce19b9ab6446362310c9d18ffb4671ac11b2a4d36263047d9f57a653d80

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
