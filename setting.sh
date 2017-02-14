#!/bin/bash
#wget -O apps/activity/appinfo/info.xml https://raw.githubusercontent.com/YsqEvilmax/vonz/master/apps/activity/appinfo/info.xml
#wget -O apps/gallery/appinfo/info.xml https://raw.githubusercontent.com/YsqEvilmax/vonz/master/apps/gallery/appinfo/info.xml

set -e

VONZ_ROOT="/var/www/html"

if [ ! -e "$VONZ_ROOT/version.php" ]; then
	tar cf - --one-file-system -C /usr/src/owncloud . | tar xf -
	chown -R www-data $VONZ_ROOT
fi

# disable activity app by defualt
sed -i "s/<default_enable\/>/ /g" $VONZ_ROOT/apps/activity/appinfo/info.xml

# disable gallery app by defualt
sed -i "s/<default_enable\/>/ /g" $VONZ_ROOT/apps/gallery/appinfo/info.xml

# add registration feature
git clone https://github.com/pellaeon/registration.git apps/registration

# add recorder feature
git clone https://github.com/YsqEvilmax/recorder.git apps/recorder

#add background feature
git clone https://github.com/YsqEvilmax/background.git apps/background

exec "$@"
