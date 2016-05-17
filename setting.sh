#!/bin/bash
#wget -O apps/activity/appinfo/info.xml https://raw.githubusercontent.com/YsqEvilmax/vonz/master/apps/activity/appinfo/info.xml
#wget -O apps/gallery/appinfo/info.xml https://raw.githubusercontent.com/YsqEvilmax/vonz/master/apps/gallery/appinfo/info.xml

set -e

if [ ! -e '/var/www/html/version.php' ]; then
	tar cf - --one-file-system -C /usr/src/owncloud . | tar xf -
	chown -R www-data /var/www/html
fi

VONZ_ROOT="/var/www/html"

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

if [[ "$1" = apache2* ]]; then
	: ${OWNCLOUD_TLS_CERT:=$OWNCLOUD_SSL_CERT}
	: ${OWNCLOUD_TLS_KEY:=$OWNCLOUD_SSL_KEY}
	: ${OWNCLOUD_TLS_PORT:=443}

	if [ "$OWNCLOUD_TLS_CERT" -o "$OWNCLOUD_TLS_KEY" ]; then
		if [ -z "$OWNCLOUD_TLS_CERT" -o -z "$OWNCLOUD_TLS_KEY" ]; then
			echo >&2 "ERROR: Both OWNCLOUD_TLS_CERT and OWNCLOUD_TLS_KEY must be provided to enable HTTPS"
			exit 1
		fi

		if ! [ -e "$OWNCLOUD_TLS_CERT" -o -e "/etc/apache2/ssl/$OWNCLOUD_TLS_CERT" ]; then
			echo >&2 "ERROR: TLS certificate '$OWNCLOUD_TLS_CERT' not found"
			exit 1
		elif ! [ -e "$OWNCLOUD_TLS_CERT" ]; then
			OWNCLOUD_TLS_CERT="/etc/apache2/ssl/$OWNCLOUD_TLS_CERT"
		fi

		if ! [ -e "$OWNCLOUD_TLS_KEY" -o -e "/etc/apache2/ssl/$OWNCLOUD_TLS_KEY" ]; then
			echo >&2 "ERROR: TLS key '$OWNCLOUD_TLS_KEY' not found"
			exit 1
		elif ! [ -e "$OWNCLOUD_TLS_KEY" ]; then
			OWNCLOUD_TLS_KEY="/etc/apache2/ssl/$OWNCLOUD_TLS_KEY"
		fi
		
		a2enmod ssl
		a2enmod	rewrite
		a2ensite owncloud-ssl

		export OWNCLOUD_TLS_CERT="$(readlink -f "$OWNCLOUD_TLS_CERT")"
		export OWNCLOUD_TLS_KEY="$(readlink -f "$OWNCLOUD_TLS_KEY")"
		export OWNCLOUD_TLS_PORT
	else
		echo >&2 'WARNING: Running ownCloud without HTTPS is not recommended.'
		echo >&2 '         See the documentation for information on enabling HTTPS:'
		echo >&2
		echo >&2 '         https://github.com/docker-library/docs/tree/master/owncloud'
		echo >&2
	fi
fi

exec "$@"
