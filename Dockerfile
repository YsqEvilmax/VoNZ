FROM owncloud:latest
MAINTAINER Shaoqing Yu <syu702@aucklanduni.ac.nz>

RUN apt-get update

ENV OWNCLOUD_ROOT /var/www/html/owncloud

# add my own configuration file
ADD config.php $OWNCLOUD_ROOT/config/config.php

Add 

# disable activity app by defualt
RUN sed -i "s/<default_enable\/>/ /g" $OWNCLOUD_ROOT/apps/activity/appinfo/info.xml

# disable gallery app by defualt
RUN sed -i "s/<default_enable\/>/ /g" $OWNCLOUD_ROOT/apps/gallery/appinfo/info.xml
