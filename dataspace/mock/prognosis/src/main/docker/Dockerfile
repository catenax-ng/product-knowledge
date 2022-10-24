FROM python:3.8.13-buster

WORKDIR /RUL
COPY . .
RUN mkdir -p /tmp/files
RUN chown 1001:root /tmp/files

RUN pip3 install --upgrade pip
RUN pip3 install -r requirements.txt

EXPOSE 5005
ENTRYPOINT ["gunicorn"]
CMD ["run:app", "--bind", "0.0.0.0:5005", "--workers", "4" ,"--worker-class", "uvicorn.workers.UvicornWorker"]
