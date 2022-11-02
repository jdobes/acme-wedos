FROM registry.access.redhat.com/ubi8/ubi-minimal

ADD *.txt /acme_wedos/

RUN microdnf install python39 shadow-utils && microdnf clean all && \
    pip3 install -r /acme_wedos/requirements.txt && \
    rm -rf /root/.cache

RUN adduser --gid 0 -d /acme_wedos --no-create-home -c 'acme user' acme

ADD *.py /acme_wedos/
ADD *.yml /acme_wedos/

USER acme

EXPOSE 8000

ENV WAPI_USER=user
ENV WAPI_PASS=pass

CMD python3 -m acme_wedos.acme_wedos
