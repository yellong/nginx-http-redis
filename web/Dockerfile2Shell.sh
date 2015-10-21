#!/bin/sh

# Download Nginx and Nginx modules source
wget http://nginx.org/download/nginx-1.8.0.tar.gz -O nginx.tar.gz 
mkdir /tmp/nginx 
tar -xzvf nginx.tar.gz -C /tmp/nginx --strip-components=1

wget http://people.freebsd.org/~osa/ngx_http_redis-0.3.7.tar.gz -O ngx-http-redis.tar.gz 
mkdir /tmp/nginx/http-redis 
tar -xzvf ngx-http-redis.tar.gz -C /tmp/nginx/http-redis --strip-components=1

wget https://github.com/maxmind/libmaxminddb/releases/download/1.1.1/libmaxminddb-1.1.1.tar.gz -O libmaxminddb.tar.gz 
mkdir /tmp/nginx/libmaxminddb 
tar -xzvf libmaxminddb.tar.gz -C /tmp/nginx/libmaxminddb --strip-components=1
cd /tmp/nginx/libmaxminddb 
./configure 
make 
make check 
make install 
ldconfig

# https://github.com/leev/ngx_http_geoip2_module
wget https://github.com/leev/ngx_http_geoip2_module/archive/1.0.tar.gz -O ngx-http-geoip2.tar.gz 
mkdir /tmp/nginx/http-geoip2 
tar -xzvf ngx-http-geoip2.tar.gz -C /tmp/nginx/http-geoip2 --strip-components=1

# https://hub.docker.com/r/unknownhero/ubuntu-nginx-lua/~/dockerfile/
wget http://luajit.org/download/LuaJIT-2.0.3.tar.gz -O LuaJIT-2.0.3.tar.gz 
mkdir /tmp/LuaJIT-2.0.3 
tar -xzvf LuaJIT-2.0.3.tar.gz -C /tmp/LuaJIT-2.0.3 --strip-components=1 
cd /tmp/LuaJIT-2.0.3 
make 
make install

wget http://labs.frickle.com/files/ngx_cache_purge-2.3.tar.gz -O ngx_cache_purge-2.3.tar.gz 
mkdir /tmp/nginx/ngx_cache_purge 
tar -xzvf ngx_cache_purge-2.3.tar.gz -C /tmp/nginx/ngx_cache_purge --strip-components=1

wget https://github.com/openresty/lua-nginx-module/archive/v0.9.13.zip -O lua-nginx-module-0.9.13.zip 
unzip lua-nginx-module-0.9.13.zip -d /tmp/nginx 
mv /tmp/nginx/lua-nginx-module-0.9.13 /tmp/nginx/lua-nginx-module

wget https://github.com/simpl/ngx_devel_kit/archive/v0.2.19.zip -O ngx_devel_kit-0.2.19.zip 
unzip ngx_devel_kit-0.2.19.zip -d /tmp/nginx 
mv /tmp/nginx/ngx_devel_kit-0.2.19 /tmp/nginx/ngx_devel_kit

cd /tmp/nginx

export LUAJIT_LIB=/usr/local/lib 
export LUAJIT_INC=/usr/local/include/luajit-2.0 
ln -s /usr/local/lib/libluajit-5.1.so.2 /lib64/libluajit-5.1.so.2 

./configure --sbin-path=/usr/local/sbin \
--with-ld-opt=-Wl,-rpath,/usr/local/lib \
--prefix=/usr/share/nginx \
--conf-path=/etc/nginx/nginx.conf \
--pid-path=/run/nginx.pid \
--lock-path=/run/lock/subsys/nginx \
--error-log-path=/var/log/nginx/error.log \
--http-log-path=/var/log/nginx/access.log \
--with-http_gzip_static_module \
--with-http_stub_status_module \
--with-http_ssl_module \
--with-http_spdy_module \
--with-pcre \
--with-http_image_filter_module \
--with-file-aio \
--with-ipv6 \
--with-http_dav_module \
--with-http_flv_module \
--with-http_mp4_module \
--with-http_gunzip_module \
--with-http_realip_module \
--with-http_auth_request_module \
--with-http_addition_module \
--with-http_sub_module \
--add-module=http-redis \
--add-module=http-geoip2 \
--add-module=./lua-nginx-module \
--add-module=./ngx_devel_kit \
--add-module=./ngx_cache_purge 
make -j2 
make install
