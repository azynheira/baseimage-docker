#!/bin/bash
set -e
source /bd_build/buildconfig
set -x

## Prevent initramfs updates from trying to run grub and lilo.
## https://journal.paul.querna.org/articles/2013/10/15/docker-ubuntu-on-rackspace/
## http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=594189
export INITRD=no
mkdir -p /etc/container_environment
echo -n no > /etc/container_environment/INITRD


## Enable Ubuntu Universe, Multiverse, and deb-src for main.
if grep -E '^ID=' /etc/os-release | grep -q ubuntu; then
  sed -i 's/^#\s*\(deb.*main restricted\)$/\1/g' /etc/apt/sources.list
  sed -i 's/^#\s*\(deb.*universe\)$/\1/g' /etc/apt/sources.list
  sed -i 's/^#\s*\(deb.*multiverse\)$/\1/g' /etc/apt/sources.list
fi

apt-get update

## Fix some issues with APT packages.
## See https://github.com/dotcloud/docker/issues/1024
dpkg-divert --local --rename --add /sbin/initctl
ln -sf /bin/true /sbin/initctl

# apt-utils fix for Ubuntu 16.04
$minimal_apt_get_install apt-utils

## Install HTTPS support for APT.
$minimal_apt_get_install apt-transport-https ca-certificates

## Upgrade all packages.
apt-get dist-upgrade -y --no-install-recommends -o Dpkg::Options::="--force-confold"

## Fix locale.
$minimal_apt_get_install language-pack-en

## Install TeX and Inkscape
$minimal_apt_get_install texlive-base texlive-fonts-recommended texlive-fonts-extra texlive-latex-extra texlive-latex-recommended texlive-plain-generic make inkscape

locale-gen en_GB
update-locale LANG=en_GB.UTF-8 LC_CTYPE=en_GB.UTF-8
echo -n en_GB.UTF-8 > /etc/container_environment/LANG
echo -n en_GB.UTF-8 > /etc/container_environment/LC_CTYPE
