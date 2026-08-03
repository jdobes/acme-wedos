FROM registry.access.redhat.com/ubi10/ubi-minimal:10.2-1785778687@sha256:f0ed153f25c9a3df530ccf2c49ec04430efef206083cbbc16ca76a866ef096b5

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
