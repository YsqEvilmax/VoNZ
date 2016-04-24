#!/bin/bash
#wget -O apps/activity/appinfo/info.xml https://raw.githubusercontent.com/YsqEvilmax/vonz/master/apps/activity/appinfo/info.xml
#wget -O apps/gallery/appinfo/info.xml https://raw.githubusercontent.com/YsqEvilmax/vonz/master/apps/gallery/appinfo/info.xml

# disable activity app by defualt
sed -i "s/<default_enable\/>/ /g" apps/activity/appinfo/info.xml

# disable gallery app by defualt
sed -i "s/<default_enable\/>/ /g" apps/gallery/appinfo/info.xml

exec /entrypoint.sh
