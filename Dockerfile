FROM registry.access.redhat.com/ubi10/ubi-minimal:10.2-1784581369@sha256:1de153ac8a6cb7793a57c837d5cb290c9a14296cb88d07fc3cc1a400f84d9231

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
