ARG BUILD_FROM
FROM $BUILD_FROM

RUN apk update && apk upgrade
RUN apk add --no-cache python3 py3-pip git
RUN git clone https://github.com/sormy/radoneye-reader
RUN apk del git && apk cache clean

COPY run.sh /
RUN chmod a+x /run.sh

WORKDIR /radoneye-reader

RUN python3 -m venv . \
    && source ./bin/activate \
    && pip3 install -r requirements.txt

CMD ["/run.sh"]