FROM lsiobase/alpine

RUN apk add --no-cache --update \
	wget  						\
    nano 						\
    perl         \
    perl-socket  \
    perl-switch  \
    perl-sys-hostname-long   \
    perl-json \
    perl-io-socket-ssl \
    perl-crypt-openssl-rsa \
    perl-crypt-openssl-dsa \
    perl-xml-simple   \
    perl-socket 

RUN mkdir -p /usr/src/perl

ADD https://raw.githubusercontent.com/miyagawa/cpanminus/master/cpanm /usr/src/perl

RUN buildDeps='gcc build-base make' \
	&& cd /usr/src/perl \
    && apk add --no-cache --update $buildDeps \
    && chmod +x cpanm \
    && ./cpanm App::cpanminus \
    && rm -fr ./cpanm /root/.cpanm /usr/src/perl 

RUN cpanm Net::MQTT::Simple  \
	Net::MQTT::Constants \
	Net::Bonjour

COPY ./etc /etc

VOLUME /app/fhem

# CMD ["perl","/app/fhem/fhem.pl", "/app/fhem/fhem.cfg"]
