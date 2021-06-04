#!/bin/bash

# Author: Airat Halitov
# GitHub: https://github.com/AiratHalitov/airat-phpmyadmin-update
# License: GPLv3

# don't forget update version!
VER=5.1.1
FNAME=phpMyAdmin-$VER-all-languages
PMADIR=/usr/share/phpmyadmin

rm -rf $FNAME
rm -rf $FNAME.zip

wget -q https://files.phpmyadmin.net/phpMyAdmin/$VER/$FNAME.zip

if [ -f $FNAME.zip ]; then
    unzip -q $FNAME.zip && rm -rf $FNAME.zip

    if [ -d $PMADIR ]; then
        sudo mv $PMADIR $PMADIR.backup-$RANDOM
        sudo mv $FNAME $PMADIR

        cd $PMADIR
        sudo mkdir tmp && sudo chmod 777 tmp -R

        sudo cp config.sample.inc.php config.inc.php

        # edit line in file config.inc.php (generate key):
        # $cfg['blowfish_secret'] = ''; /* YOU MUST FILL IN THIS FOR COOKIE AUTH! */

        KEY=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 32)
        SRC="blowfish_secret'] = '';"
        DST="blowfish_secret'] = '$KEY';"

        sudo sed "s/$SRC/$DST/g" -i config.inc.php
        echo "Done!"
    fi
fi
