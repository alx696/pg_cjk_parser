FROM postgres:12
RUN sed -i s/deb.debian.org/mirrors.aliyun.com/g /etc/apt/sources.list
RUN sed -i s/security.debian.org/mirrors.aliyun.com/g /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -y postgresql-server-dev-all
RUN apt-get install -y gcc
RUN apt-get install -y icu-devtools libicu-dev

RUN mkdir -p /root/parser
WORKDIR /root/parser
COPY pg_cjk_parser.c /root/parser/
COPY pg_cjk_parser.control /root/parser/
COPY Makefile /root/parser/
COPY pg_cjk_parser--0.0.1.sql /root/parser/
COPY zht2zhs.h /root/parser/
RUN make clean && make install
