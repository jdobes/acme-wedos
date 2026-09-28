FROM registry.access.redhat.com/ubi10/ubi-minimal:10.2-1790556942@sha256:a9f9316ec3a1419a2de6ce4d2d9f034d477e97cdf2a16d6f04b7bd632ac753c4

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
