for last; do true; done

if [ $last -eq 0 ]; then

    ip=$1
    jour=$2
    mois=$3
    annee=$4
    base=$5

    dirfile="$5/$4/$3"
    file="$2_access.log"
    count=0

    #boucle access
    if [ -e "$dirfile/$file" ]; then
        echo "Veuillez patientez..."
        while IFS= read -r line; do
            ipx=$(echo $line | awk '{print $1}')
            if [ $ipx == $ip ]; then
                count=$(($count + 1))
            fi
        done <"$dirfile/$file"
        echo "L'adresse $1 a effectué $count requetes le $jour/$mois/$annee."
    else
        echo "Aucune donnée n'a été trouvée pour ce jour."
    fi

else
    ip=$1
    mois=$2
    annee=$3
    base=$4
    dirfile="$4/$3/$2/*_access.log"
    count=0

     if [ -d "$4/$3/$2" ]; then

    for FILE in $dirfile; do
        if [ -e $FILE ]; then
            echo Fichier en cours: $FILE
            while IFS= read -r line; do
                ipx=$(echo $line | awk '{print $1}')
                if [ $ipx == $ip ]; then
                    count=$(($count + 1))
                fi
            done <$FILE
        fi
    done

    echo "L'adresse $1 a effectué $count requetes le $mois/$annee"
    else
         echo "Aucunes données pour ce mois."
    fi
fi
