#!/bin/bash
mois=$1
annee=$2
type=$3

dirfile="./$2/$1/*_error.log"
count=0

for FILE in $dirfile; do
    if [ -e $FILE ]; then
        while IFS= read -r line; do

            count=$(($count + 1))

        done <$FILE
    fi

done

echo "Il y a eu $count erreurs le $mois/$annee"
