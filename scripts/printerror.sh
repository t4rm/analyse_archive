#!/bin/bash
for last; do true; done
count=0

if [ $last -eq 0 ]; then

    jour=$1
    mois=$2
    annee=$3
    type=$4

    dirfile="$5/$3/$2"
    file="$1_error.log"

    if [ -e "$dirfile/$file" ]; then
        echo "Liste des message d'erreur pour le type d'erreur $type : "

        while IFS= read -r line; do

            typex=$(echo $line | awk '{print $6}')
            typex=${typex::-1}
            typex=${typex:1}

            if [ "$typex" == "$type" ]; then
                echo $line | cut -d' ' -f 11-
            fi

        done <"$dirfile/$file"
    else
        echo "Aucune donnée trouvée pour ce jour."
    fi

else

    mois=$1
    annee=$2
    type=$3

    dirfile="$4/$2/$1/*_error.log"
    if [ -d "$4/$3/$2" ]; then

        echo "Liste des message d'erreur pour le type d'erreur $type : "
        for FILE in $dirfile; do
            echo $FILE
            if [ -e $FILE ]; then
            echo Fichier en cours: $FILE

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

    else
        echo "Aucunes données pour ce mois."
    fi
fi
