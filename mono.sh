#!/bin/bash

TOPDIR=$(pwd)
BUILDDIR=$TOPDIR/build
DLDDIR=$TOPDIR/downloads

export PATH=/opt/mono-2.8.1/bin:$PATH


echo "updating existing system"
aptitude update
aptitude upgrade -y

echo "installing prerequisites"
aptitude install -y pbzip2 build-essential libc6-dev g++ gcc libglib2.0-dev pkg-config subversion apache2 apache2-threaded-dev bison gettext autoconf automake libtool libpango1.0-dev libatk1.0-dev libgtk2.0-dev libtiff4-dev libgif-dev libglade2-dev

# temp hack. removed later.
ln -s /opt/mono-2.8.1/lib/pkgconfig/mono-nunit.pc /usr/lib/pkgconfig/mono-nunit.pc

mkdir -p $BUILDDIR

echo
echo "downloading mono packages"
echo

cd $BUILDDIR

wget http://ftp.novell.com/pub/mono/sources/xsp/xsp-2.8.1.tar.bz2
wget http://ftp.novell.com/pub/mono/sources/mod_mono/mod_mono-2.8.tar.bz2
wget http://ftp.novell.com/pub/mono/sources/mono/mono-2.8.1.tar.bz2
wget http://ftp.novell.com/pub/mono/sources/libgdiplus/libgdiplus-2.8.1.tar.bz2
wget http://ftp.novell.com/pub/mono/sources/gtk-sharp212/gtk-sharp-2.12.10.tar.bz2

cd $BUILDDIR
pbzip2 -df xsp-2.8.1.tar.bz2
tar -xvf xsp-2.8.1.tar

pbzip2 -df mod_mono-2.8.tar.bz2
tar -xvf mod_mono-2.8.tar

pbzip2 -df mono-2.8.1.tar.bz2
tar -xvf mono-2.8.1.tar

pbzip2 -df libgdiplus-2.8.1.tar.bz2
tar -xvf libgdiplus-2.8.1.tar

pbzip2 -df gtk-sharp-2.12.10.tar.bz2
tar -xvf gtk-sharp-2.12.10.tar

echo
echo "building and installing mono packages"
echo


cd $BUILDDIR
cd libgdiplus-2.8.1
./configure --prefix=/opt/mono-2.8.1
make -j 12
make install

cd $BUILDDIR
cd mono-2.8.1
./configure --prefix=/opt/mono-2.8.1
make -j 12
make install

cd $BUILDDIR
cd gtk-sharp-2.12.10
./configure --prefix=/opt/mono-2.8.1
make -j 12
make install

cd $BUILDDIR
cd xsp-2.8.1
./configure --prefix=/opt/mono-2.8.1
make -j 12
make install

cd $BUILDDIR
cd mod_mono-2.8
./configure --prefix=/opt/mono-2.8.1
make -j 12
make install
cd $BUILDDIR

#clean up
rm /usr/lib/pkgconfig/mono-nunit.pc

echo
echo "done"
