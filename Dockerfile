FROM registry.access.redhat.com/ubi10/ubi-minimal:10.3-1794499233@sha256:fb2f7f857cc60d88e3fad19da505083a682ca4569d7b55a61f64aaa43641f741

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
