FROM alpine:3.8
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
	lmdb-dev \
    && cd /build \
    && mkdir install \
    && printf "#include <unistd.h>\n void main() { pause(); }" | gcc -static -O2 -s -o /bin/pause -xc -
