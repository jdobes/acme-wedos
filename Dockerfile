FROM registry.access.redhat.com/ubi10/ubi-minimal:10.2-1791444377@sha256:bcecd3e74c9d03eb1a596c6c8f366775a289d422ac5925ec1539924d762ebf23

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
