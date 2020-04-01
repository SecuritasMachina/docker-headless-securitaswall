export current_timestamp=$(date +%Y-%m-%d_%H.%M.%S)
./build-base.1.sh
./build-base.2.sh
./build-base.3.sh
./build.sh
# docker run -it --entrypoint bash ackdev/secure_proxy_securitas-wall:2020-03-30_14.50.33
#apt install g++
#wget http://www.squid-cache.org/Versions/v4/squid-4.10.tar.gz
#./configure --with-openssl --enable-ssl-crtd --enable-icap-client