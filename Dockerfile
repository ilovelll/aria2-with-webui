FROM alpine:edge

LABEL maintainer="gradle@qq.com"
LABEL description="Docker of aria2 & webui"

RUN apk --no-cache add bash \
	&& mkdir -p /conf \
	&& mkdir -p /conf-copy \
	&& mkdir -p /data \
	&& apk --no-cache add aria2 \
	&& apk --no-cache add git \
	&& git clone https://github.com/ziahamza/webui-aria2 /aria2-webui \
  && rm /aria2-webui/.git* -rf \
  && apk del git \
	&& apk --no-cache add darkhttpd

COPY files/start.sh /conf-copy/start.sh
COPY files/aria2.conf /conf-copy/aria2.conf
COPY files/on-complete.sh /conf-copy/on-complete.sh

RUN chmod +x /conf-copy/start.sh

WORKDIR /
VOLUME ["/data"]
VOLUME ["/conf"]
EXPOSE 6800
EXPOSE 80
EXPOSE 8080

CMD ["/conf-copy/start.sh"]
