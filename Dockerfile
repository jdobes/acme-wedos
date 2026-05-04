FROM registry.access.redhat.com/ubi10/ubi-minimal:10.1-1777858393@sha256:10af9ad52c3b501a795d3737225dd096945cfd27b7ff0387d74102f6dfcd30f6

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
