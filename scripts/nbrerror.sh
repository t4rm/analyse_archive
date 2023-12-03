#!/bin/bash
for last; do true; done
count=0

if [ $last -eq 0 ]; then

    jour=$1
    mois=$2
    annee=$3

    dirfile="$4/$3/$2"
    file="$1_error.log"

    if [ -e "$dirfile/$file" ]; then
        while IFS= read -r line; do

            count=$(($count + 1))

        done <"$dirfile/$file"
        echo "Il y a eu $count erreurs le $jour/$mois/$annee."
    else
        echo "Aucune donnée pour ce jour."
    fi

else

    #!/bin/bash
    mois=$1
    annee=$2

    dirfile="$3/$2/$1/*_error.log"
    if [ -d "$3/$2/$1" ]; then

        for FILE in $dirfile; do
            if [ -e $FILE ]; then
            echo Fichier en cours: $FILE
                while IFS= read -r line; do

                    count=$(($count + 1))

                done <$FILE
            fi

        done
        echo "Il y a eu $count erreurs le $mois/$annee"

    else
        echo "Aucunes données pour ce mois."
    fi

fi
