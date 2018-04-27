FROM ubuntu

MAINTAINER James Martinez <jamescmartinez@gmail.com>

# Install prerequisites for Nginx compile
RUN apt-get update && \
    apt-get install -y wget tar gcc libpcre3-dev zlib1g-dev make libssl-dev libluajit-5.1-dev

# Download Nginx
WORKDIR /tmp
RUN wget http://nginx.org/download/nginx-1.14.0.tar.gz -O nginx.tar.gz && \
    mkdir nginx && \
    tar xf nginx.tar.gz -C nginx --strip-components=1

# Download Nginx modules
RUN wget https://github.com/simpl/ngx_devel_kit/archive/v0.3.0.tar.gz -O ngx_devel_kit.tar.gz && \
    mkdir ngx_devel_kit && \
    tar xf ngx_devel_kit.tar.gz -C ngx_devel_kit --strip-components=1
RUN wget https://github.com/openresty/set-misc-nginx-module/archive/v0.32.tar.gz -O set-misc-nginx-module.tar.gz && \
    mkdir set-misc-nginx-module && \
    tar xf set-misc-nginx-module.tar.gz -C set-misc-nginx-module --strip-components=1
RUN wget https://github.com/openresty/lua-nginx-module/archive/v0.10.13.tar.gz -O lua-nginx-module.tar.gz && \
    mkdir lua-nginx-module && \
    tar xf lua-nginx-module.tar.gz -C lua-nginx-module --strip-components=1

# Build Nginx
WORKDIR nginx
RUN ./configure --sbin-path=/usr/local/sbin \
                --conf-path=/etc/nginx/nginx.conf \
                --pid-path=/var/run/nginx.pid \
                --error-log-path=/var/log/nginx/error.log \
                --http-log-path=/var/log/nginx/access.log \
                --with-http_ssl_module \
                --add-module=/tmp/ngx_devel_kit \
                --add-module=/tmp/set-misc-nginx-module \
                --add-module=/tmp/lua-nginx-module && \
    make && \
    make install

# Apply Nginx config
ADD config/nginx.conf /etc/nginx/nginx.conf

# Expose ports
EXPOSE 80

# Set default command
CMD ["nginx", "-g", "daemon off;"]
