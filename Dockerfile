FROM owncloud:latest
MAINTAINER Shaoqing Yu <syu702@aucklanduni.ac.nz>

RUN apt-get update && apt-get install -y git

#ENV OWNCLOUD_ROOT /var/www/html
WORKDIR /var/www/html

# add my own configuration file
COPY config.php config/config.php

# add default user data
COPY data/ data/

# add my own configuration file
# ADD https://raw.githubusercontent.com/YsqEvilmax/vonz/master/setting.sh /setting.sh
COPY setting.sh /setting.sh
RUN chmod +x /setting.sh

# enable https
COPY owncloud-ssl.conf /etc/apache2/sites-available/
EXPOSE 443

ENTRYPOINT ["/setting.sh"]
CMD ["apache2-foreground"]

