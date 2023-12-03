#!/bin/bash

mois=$1
annee=$2
ip=$3

dirfile="./$2/$1/*_error.log"
count=0

echo "Liste des erreurs en lien avec l'adresse $ip : "
#boucle error
for FILE in $dirfile; do
    echo $FILE

    if [ -e $FILE ]; then
        while IFS= read -r line; do

            ipx=$(echo $line | awk '{print $10}')
            ipx=${ipx::-1}

            if [ "$ipx" == "$ip" ]; then
                echo $line
            fi

        done <$FILE
    fi

done
