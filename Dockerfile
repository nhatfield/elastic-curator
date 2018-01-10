FROM alpine:latest

RUN apk --update --no-cache add py-pip bash \
 && pip install elasticsearch-curator

ADD config.yml /config.yml
ADD action.yml /action.yml
ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]
