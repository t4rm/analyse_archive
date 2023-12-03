#!/bin/bash

mois=$1
annee=$2
type=$3

dirfile="./$2/$1/*_error.log"
count=0

echo "Liste des message d'erreur pour le type d'erreur $type : "
for FILE in $dirfile; do
    echo $FILE
    if [ -e $FILE ]; then
        while IFS= read -r line; do
            typex=$(echo $line | awk '{print $6}')
            typex=${typex::-1}
            typex=${typex:1}

            if [ "$typex" == "$type" ]; then
                echo $line | cut -d' ' -f 11-
            fi
            
        done <$FILE
    fi

done
