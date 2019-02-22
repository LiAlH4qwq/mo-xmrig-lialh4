#!/bin/bash
yum update -y
yum install -y cmake make git openssl-devel libmicrohttpd-devel
rpm -i https://github.com/sipcapture/captagent/raw/master/dependency/centos/6/libuv-1.8.0-1.el6.x86_64.rpm
rpm -i https://github.com/sipcapture/captagent/raw/master/dependency/centos/6/libuv-devel-1.8.0-1.el6.x86_64.rpm
wget http://linuxsoft.cern.ch/cern/scl/slc6-scl.repo -O /etc/yum.repos.d/slc6-scl.repo
yum upgrade -y
yum install -y --nogpgcheck devtoolset-6-gcc devtoolset-6-binutils devtoolset-6-gcc-c++

rm -rf build xmrig-$1-lin64.tar.gz
mkdir build &&\
cd build &&\
git clone https://github.com/MoneroOcean/xmrig.git &&\
cd xmrig &&\
git checkout $1 &&\
scl enable devtoolset-6 "cmake . -DWITH_TLS=OFF -DWITH_HTTPD=OFF" &&\
scl enable devtoolset-6 "make" &&\
cp src/config.json . &&\
mv xmrig-notls xmrig &&\
tar cfz ../../xmrig-$1-lin64.tar.gz xmrig config.json &&\
cd ../.. &&\
rm -rf build &&\
echo OK

