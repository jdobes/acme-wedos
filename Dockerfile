FROM registry.access.redhat.com/ubi10/ubi-minimal:10.2-1785332632@sha256:ceaad73890ea88685eeb1b40a502b7983f2cfac6f1aa10915d1176d51eb90124

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
