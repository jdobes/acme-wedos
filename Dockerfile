FROM registry.access.redhat.com/ubi10/ubi-minimal:10.2-1782191645@sha256:3948fdfe71007909b37faf48c52eda28bfab7c4e440d6f4d4619422d06ceeb4c

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
