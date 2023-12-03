#!/bin/bash
for last; do true; done
count=0

if [ $last -eq 0 ]; then

    jour=$1
    mois=$2
    annee=$3
    pid=$4

    dirfile="$5/$3/$2"
    file="$1_error.log"

    if [ -e "$dirfile/$file" ]; then
        echo "Liste des erreurs en lien avec le PID $pid : "
        while IFS= read -r line; do

            pidx=$(echo $line | awk '{print $8}')
            pidx=${pidx::-1}

            if [ "$pidx" == "$pid" ]; then
                echo $line
            fi

        done <"$dirfile/$file"
    fi

else

    mois=$1
    annee=$2
    pid=$3

    dirfile="$4/$2/$1/*_error.log"
    if [ -d "$4/$2/$1" ]; then

        echo "Liste des erreurs en lien avec le PID $pid : "

        for FILE in $dirfile; do
            if [ -e $FILE ]; then
                echo Fichier en cours: $FILE
                while IFS= read -r line; do

                    pidx=$(echo $line | awk '{print $8}')
                    pidx=${pidx::-1}

                    if [ "$pidx" == "$pid" ]; then
                        echo $line
                    fi

                done <$FILE
            fi

        done

    else

        echo "Aucunes données trouvées pour ce mois."

    fi
fi
