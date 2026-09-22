FROM registry.access.redhat.com/ubi10/ubi-minimal:10.2-1790075626@sha256:e3a5632d7ae8a97e06f634522d06187f12793e90ac0d7b51bc671c83a96d8eda

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
