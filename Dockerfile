FROM registry.access.redhat.com/ubi10/ubi-minimal:10.2-1787688243@sha256:d28951a21182cbc821da281af307a4d583dbc39d464680adc6fdffbc5a935b20

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
