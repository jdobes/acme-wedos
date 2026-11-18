FROM registry.access.redhat.com/ubi10/ubi-minimal:10.3-1795002774@sha256:45b15b88980995a4939b33dfbdfdb2a5998198d478947ee1e1477d08425a1f25

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
