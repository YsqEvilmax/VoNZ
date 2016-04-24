FROM owncloud:latest
MAINTAINER Shaoqing Yu <syu702@aucklanduni.ac.nz>

RUN apt-get update

#ENV OWNCLOUD_ROOT /var/www/html
WORKDIR /var/www/html

# add my own configuration file
ADD https://raw.githubusercontent.com/YsqEvilmax/vonz/master/config.php config/config.php

# add my own configuration file
ADD https://raw.githubusercontent.com/YsqEvilmax/vonz/master/setting.sh /setting.sh
RUN chmod +x /setting.sh

ENTRYPOINT ["/setting.sh"]
CMD ["apache2-foreground"]

