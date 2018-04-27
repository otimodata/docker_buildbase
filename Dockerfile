FROM alpine:3.7
LABEL Name="buildbase" \
    Maintainer="Otimo Data AB"

WORKDIR /build

RUN apk add --update alpine-sdk \
        linux-headers \
        bsd-compat-headers \
        automake \
        autoconf \
        bison \
        flex \
        gperf \
        libtool \
        util-linux-dev \
        libxml2-dev \
        libressl-dev \
        pcre-dev \
        gettext-dev \
        zlib-dev \
        groff \
        file \
    && cd /build \
    && wget https://github.com/LMDB/lmdb/archive/mdb.master.zip \
    && unzip mdb.master.zip \
    && cd lmdb-mdb.master/libraries/liblmdb \
    && make \
    && make install prefix=/usr \
    && strip /usr/bin/mdb* \
    && strip /usr/lib/liblmdb.so \
    && cd /build \
    && rm -rf * \
    && mkdir install \
    && printf "#include <unistd.h>\n void main() { pause(); }" | gcc -static -O2 -s -o /bin/pause -xc -
