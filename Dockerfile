FROM alpine:3.9.5

ARG VERSION=1.14.0-1
ENV DESTDIR /opt/unit/

RUN apk add --update --no-cache build-base \
    && wget https://github.com/nginx/unit/archive/${VERSION}.tar.gz \
    && tar -xzf ${VERSION}.tar.gz \
    && cd /unit-${VERSION} \
    && ./configure --log=/var/log/unitd.log \
    && make \
    && make install \
    && rm -rf ${VERSION}.tar.gz unit-${VERSION}

CMD ["/opt/unit/sbin/unitd", "--no-daemon", "--control", "unix:/var/run/control.unit.sock"]

