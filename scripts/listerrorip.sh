#!/bin/bash
for last; do true; done
count=0

if [ $last -eq 0 ]; then

    jour=$1
    mois=$2
    annee=$3
    ip=$4

    dirfile="$5/$3/$2"
    file="$1_error.log"

    echo "Liste des erreurs en lien avec l'adresse $ip : "
    #boucle error
    if [ -e "$dirfile/$file" ]; then
        while IFS= read -r line; do

            ipx=$(echo $line | awk '{print $10}')
            ipx=${ipx::-1}

            if [ "$ipx" == "$ip" ]; then
                echo $line
            fi

        done <"$dirfile/$file"
    fi

else

    mois=$1
    annee=$2
    ip=$3

    dirfile="$4/$2/$1/*_error.log"
    if [ -d "$4/$2/$1" ]; then

        echo "Liste des erreurs en lien avec l'adresse $ip : "
        for FILE in $dirfile; do
            if [ -e $FILE ]; then
                echo Fichier en cours: $FILE
                while IFS= read -r line; do

                    ipx=$(echo $line | awk '{print $10}')
                    ipx=${ipx::-1}

                    if [ "$ipx" == "$ip" ]; then
                        echo $line
                    fi

                done <$FILE
            fi

        done

    else

        echo "Aucunes données pour ce mois."
    fi
fi
