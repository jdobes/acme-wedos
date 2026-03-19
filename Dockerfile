FROM registry.access.redhat.com/ubi10/ubi-minimal:10.1-1773895769@sha256:fa956af586b367c3366ac4376c3ee42a1141792b482e77d57aefb813f740f04d

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
