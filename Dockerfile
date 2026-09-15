FROM registry.access.redhat.com/ubi10/ubi-minimal:10.2-1789456728@sha256:5b07a4099a1893e379a8eaf55768026337ab4ccb6affb44ea4506b7437199294

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
