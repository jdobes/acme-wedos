FROM registry.access.redhat.com/ubi10/ubi-minimal:10.2-1780413072@sha256:39c5de8723ad21c6a34e15cfba75f096d6a7191de98481b870b3dba575d65302

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
