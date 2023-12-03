#!/bin/bash

direrr="$1/*error*.log"
diracc="$1/*access*.log"

for FILE in $direrr; do
    if [ -e $FILE ]; then
        while IFS= read -r line; do

            printf '%s\n' "$line"
            date=$(echo $line | awk '{print $1, $2, $3, $5}')
            date="${date:1}"
            date="${date::-1}" 

            jour=$(date -d"$date" +%d)
            mois=$(date -d"$date" +%m)
            annee=$(date -d"$date" +%Y)

            [ ! -d "$1/$annee" ] && mkdir "$1/$annee"

            [ ! -d "$1/$annee/$mois" ] && mkdir "$1/$annee/$mois"

            echo "$line" >> $1/$annee/$mois/$jour"_error.log"

        done <$FILE
        truncate -s 0 $FILE
    fi
done

for FILE in $diracc; do
    if [ -e $FILE ]; then
        while IFS= read -r line; do

            printf '%s\n' "$line"
            date=$(echo $line | awk '{print $3}')
            date="${date:1}"
            date="${date::-9}"

            jour="$(cut -d'/' -f1 <<<$date)"
            mois="$(cut -d'/' -f2 <<<$date)"
            annee="$(cut -d'/' -f3 <<<$date)"
            mix="$mois $annee"
            mois=$(date -d"01 $mix" +%m)

            [ ! -d "$1/$annee" ] && mkdir "$1/$annee"

            [ ! -d "$1/$annee/$mois" ] && mkdir "$1/$annee/$mois"

            echo "$line" >>$1/$annee/$mois/$jour"_access.log"

        done <$FILE
        truncate -s 0 $FILE
    fi
done
