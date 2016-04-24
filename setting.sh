#!/bin/bash
#wget -O apps/activity/appinfo/info.xml https://raw.githubusercontent.com/YsqEvilmax/vonz/master/apps/activity/appinfo/info.xml
#wget -O apps/gallery/appinfo/info.xml https://raw.githubusercontent.com/YsqEvilmax/vonz/master/apps/gallery/appinfo/info.xml

VONZ_ROOT="/var/www/html"

# disable activity app by defualt
#sed -i "s/<default_enable\/>/ /g" $VONZ_ROOT/apps/activity/appinfo/info.xml

# disable gallery app by defualt
#sed -i "s/<default_enable\/>/ /g" $VONZ_ROOT/apps/gallery/appinfo/info.xml

exec "/entrypoint.sh"
exec "$@"
