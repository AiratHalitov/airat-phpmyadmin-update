#!/bin/bash

# Author: Airat Halitov
# GitHub: https://github.com/AiratHalitov/airat-phpmyadmin-update
# License: GPLv3

# don't forget update version!
VER=5.0.4
FNAME=phpMyAdmin-$VER-all-languages
PMADIR=/usr/share/phpmyadmin

rm -rf $FNAME
rm -rf $FNAME.zip

wget https://files.phpmyadmin.net/phpMyAdmin/$VER/$FNAME.zip > /dev/null 2>&1

if [ -f $FNAME.zip ]; then
    unzip $FNAME.zip > /dev/null 2>&1 && rm -rf $FNAME.zip

    if [ -d $PMADIR ]; then
        mv $PMADIR $PMADIR.backup-$RANDOM
        mv $FNAME $PMADIR

        cd $PMADIR
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
