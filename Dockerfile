FROM owncloud:latest
MAINTAINER Shaoqing Yu <syu702@aucklanduni.ac.nz>

RUN apt-get update && apt-get install -y git

#ENV OWNCLOUD_ROOT /var/www/html
WORKDIR /var/www/html

# add my own configuration file
COPY config.php config/config.php

# add default user data
COPY data/ data/

# add registration feature
RUN git clone https://github.com/pellaeon/registration.git apps/registration

# add my own configuration file
ADD https://raw.githubusercontent.com/YsqEvilmax/vonz/master/setting.sh /setting.sh
RUN chmod +x /setting.sh

ENTRYPOINT ["/setting.sh"]
CMD ["apache2-foreground"]

