#!/bin/bash

# help: https://www.dmosk.ru/miniinstruktions.php?mini=phpmyadmin-update

# don't forget update version!
VER=5.0.4
FNAME=phpMyAdmin-$VER-all-languages

rm -rf $FNAME
rm -rf $FNAME.zip

wget https://files.phpmyadmin.net/phpMyAdmin/$VER/$FNAME.zip

if [ -f $FNAME.zip ]; then
    unzip $FNAME.zip && rm -rf $FNAME.zip

    if [ -d /usr/share/phpmyadmin ]; then
        mv /usr/share/phpmyadmin /usr/share/phpmyadmin.backup-$RANDOM
        mv $FNAME /usr/share/phpmyadmin

        cd /usr/share/phpmyadmin
        mkdir tmp && chmod 777 tmp -R

        cp config.sample.inc.php config.inc.php

        # edit line in file config.inc.php (generate key):
        # $cfg['blowfish_secret'] = ''; /* YOU MUST FILL IN THIS FOR COOKIE AUTH! */

        KEY=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 32)
        SRC="blowfish_secret'] = '';"
        DST="blowfish_secret'] = '$KEY';"

        sed "s/$SRC/$DST/g" -i config.inc.php
        echo "Done!"
    fi
fi
