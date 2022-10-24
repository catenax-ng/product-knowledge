FROM python:3.8.13-buster

ARG HTTP_PROXY=""
RUN if [[ -n "${HTTP_PROXY}"  ]]; then \
        echo "Acquire::http::Proxy \"${HTTP_PROXY}\"" >> /etc/apt/apt.conf.d/proxy.conf; \
        echo "Acquire::https::Proxy \"${HTTP_PROXY}\"" >> /etc/apt/apt.conf.d/proxy.conf; \
    fi && \
    apt-get -y upgrade && \
    apt-get -y update && \
    addgroup --system --gid 30000 app && \
    adduser --ingroup app --uid 10000 app && \
    mkdir -p /tmp/files && \
    chown app:app /tmp/files && \
    mkdir -p /RUL && \
    chown app:app /RUL && \
    if [[ -n "${HTTP_PROXY}"  ]]; then rm -f /etc/apt/apt.conf.d/proxy.conf; fi

WORKDIR /RUL
COPY . .
RUN pip3 install --upgrade pip
RUN pip3 install -r requirements.txt

USER app

# TODO Should have a healthcheck
HEALTHCHECK NONE

EXPOSE 5005
ENTRYPOINT ["gunicorn"]
CMD ["run:app", "--bind", "0.0.0.0:5005", "--workers", "4" ,"--worker-class", "uvicorn.workers.UvicornWorker"]
