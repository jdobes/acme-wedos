FROM registry.access.redhat.com/ubi10/ubi-minimal:10.1-1778058333@sha256:9f12217d6c94d0527c8e97d2a2a0d8de77f08276073b0c4226c07a973dc48eba

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
