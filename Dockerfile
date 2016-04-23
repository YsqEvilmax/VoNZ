FROM owncloud:latest
MAINTAINER Shaoqing Yu <syu702@aucklanduni.ac.nz>

RUN apt-get update

#ENV OWNCLOUD_ROOT /var/www/html
WORKDIR /var/www/html

# add my own configuration file
ADD https://raw.githubusercontent.com/YsqEvilmax/vonz/master/config.php config/config.php

# disable activity app by defualt
ONBUILD RUN sed -i "s/<default_enable\/>/ /g" apps/activity/appinfo/info.xml

# disable gallery app by defualt
ONBUILD RUN sed -i "s/<default_enable\/>/ /g" apps/gallery/appinfo/info.xml

