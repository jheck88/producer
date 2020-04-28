FROM ubuntu

RUN apt update -y && \
    apt upgrade -y && \
    apt install git wget zlib1g-dev zlib1g net-tools build-essential libpcre3 libpcre3-dev libssl-dev autoconf automake -y

RUN cd $HOME && \
    wget https://nginx.org/download/nginx-1.18.0.tar.gz -O nginx-1.18.0.tar.gz && \
    tar -xf nginx-1.18.0.tar.gz && \
    git clone https://github.com/sergey-dryabzhinsky/nginx-rtmp-module.git && \
    cd nginx-1.18.0/ && \
    ./configure --prefix=/usr/local/nginx --with-http_ssl_module --add-module=../nginx-rtmp-module && \
    make -j 1 && \
    make install

COPY config/nginx.conf /usr/local/nginx/conf/nginx.conf
COPY stat.xsl /tmp/stat.xsl

RUN chmod ugo+rwX /tmp/stat.xsl

EXPOSE 8080
EXPOSE 1935
EXPOSE 80

CMD ["/usr/local/nginx/sbin/nginx", "-g", "daemon off;"]