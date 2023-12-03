tot=0
vals=()
for i in {0..23..1}; do
    vals[$i]=0
done

for last; do true; done

if [ $last -eq 0 ]; then
    jour=$1
    mois=$2
    annee=$3
    base=$4
    dirfile="$4/$3/$2"
    file="$1_access.log"

    if [ -e "$dirfile/$file" ]; then
        echo "Veuillez patientez..."
        while IFS= read -r line; do

            heure=$(echo $line | awk '{print $3}')
            heure="${heure:13}"
            heure=$(date -d"$heure" +%H)

            heure=$(echo $heure | expr $heure + 0)
            ((vals[$heure]++))
            tot=$((tot + 1))
            #echo ${array[*]}

        done <"$dirfile/$file"
        echo "Nombre de requete en fonction de l'heure de la journée du $jour/$mois/$annee:"
        for i in {0..23..1}; do
            printf "À $i heure : %s requêtes\n" "${vals[$i]}"
        done

        z=$((tot / 24))
        if [ $z -lt 1 ]; then
            echo "Soit, moins d'une requête par heure."
        else
            echo "Soit $z requêtes par heure."
        fi
    else
        echo "Aucune donnée n'a été trouvée pour ce jour."
    fi

else

    mois=$1
    annee=$2
    base=$3
    dirfile="$3/$2/$1/*_access.log"
    echo "Veuillez patientez..."
    if [ -d "$4/$3/$2" ]; then

        for FILE in $dirfile; do
            if [ -e $FILE ]; then
                echo Fichier en cours: $FILE=
                while IFS= read -r line; do
                    heure=$(echo $line | awk '{print $3}')
                    heure="${heure:13}"
                    heure=$(date -d"$heure" +%H)

                    heure=$(echo $heure | expr $heure + 0)
                    ((vals[$heure]++))
                    tot=$((tot + 1))
                    #echo ${array[*]}

                done <$FILE
            fi

        done

        echo "Nombre de requete en fonction de l'heure de la journée du $mois/$annee:"
        for i in {0..23..1}; do
            printf "À $i heure : %s requêtes\n" "${vals[$i]}"
        done

        z=$((tot / 24))
        if [ $z -lt 1 ]; then
            echo "Soit, moins d'une requête par heure."
        else
            echo "Soit $z requêtes par heure."
        fi
    else
        echo "Aucunes données pour ce mois."
    fi

fi
