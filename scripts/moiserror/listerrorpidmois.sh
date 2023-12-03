#!/bin/bash

mois=$1
annee=$2
pid=$3

dirfile="./$2/$1/*_error.log"
count=0

echo "Liste des erreurs en lien avec le PID $ip : "

for FILE in $dirfile; do
    echo $FILE
    if [ -e $FILE ]; then
        while IFS= read -r line; do

            pidx=$(echo $line | awk '{print $8}')
            pidx=${pidx::-1}

            if [ "$pidx" == "$pid" ]; then
                echo $line
            fi

        done <$FILE
    fi

done
