#!/bin/bash
for last; do true; done

if [ $last -eq 0 ]; then

    jour=$1
    mois=$2
    annee=$3
    type=$4

    dirfile="$5/$3/$2"
    file="$1_error.log"
    count=0

    if [ -e "$dirfile/$file" ]; then
        while IFS= read -r line; do
            clean=$(echo $line | tr -dc '[:alnum:][:blank:][:digit:]^.^:^/^\\n\r')
            jouren=$(echo $clean | awk '{print $1}')

            journb=$(echo $clean | awk '{print $3}')
            moisen=$(echo $clean | awk '{print $2}')
            anneenb=$(echo $clean | awk '{print $5}')

            mix="$moisen $anneenb"
            moisnb=$(date -d"01 $mix" +%m)

            datefr=$(date -d"$moisnb/$journb/$anneenb" +%a\ %b)

            jourfr=$(echo $datefr | awk '{print $1}' | sed -e 's/\.//g')
            moisfr=$(echo $datefr | awk '{print $2}' | sed -e 's/\.//g')

            jourfr=${jourfr^}
            moisfr=${moisfr^}

            test=$clean
            test=${test/$jouren/"$jourfr"}
            test=${test/$moisen/"$moisfr"}

            if [ $type -eq 0 ]; then
                awk '{printf "%-5s %-5s %-5s %-5s %-5s %-20s %-5s %-10s %-5s %-20s", $1, $2, $3, $4, $5, $6, $7, $8, $9, $10}' <<<"$test"
                echo $clean | awk '{$1=$2=$3=$4=$5=$6=$7=$8=$9=$10=""; print $0}'
            else

                [ ! -d "sortie" ] && mkdir "sortie"

                echo $test | awk '{printf "%-5s %-5s %-5s %-5s %-5s %-20s %-5s %-10s %-5s %-20s", $1, $2, $3, $4, $5, $6, $7, $8, $9, $10}' | tee -a ./sortie/"$annee-$mois-$jour-export.imp"
                echo $test | cut -d' ' -f 11- | tee -a ./sortie/"$annee-$mois-$jour-export.imp"
            fi

        done <"$dirfile/$file"
    fi

else

    mois=$1
    annee=$2
    type=$3

    dirfile="$4/$2/$1/*_error.log"
    count=0

    if [ -d "$4/$2/$1" ]; then

    for FILE in $dirfile; do
        if [ -e $FILE ]; then
            echo Fichier en cours: $FILE
            while IFS= read -r line; do
                clean=$(echo $line | tr -dc '[:alnum:][:blank:][:digit:]^.^:^/^\\n\r')
                jouren=$(echo $clean | awk '{print $1}')

                journb=$(echo $clean | awk '{print $3}')
                moisen=$(echo $clean | awk '{print $2}')
                anneenb=$(echo $clean | awk '{print $5}')

                mix="$moisen $anneenb"
                moisnb=$(date -d"01 $mix" +%m)

                datefr=$(date -d"$moisnb/$journb/$anneenb" +%a\ %b)

                jourfr=$(echo $datefr | awk '{print $1}' | sed -e 's/\.//g')
                moisfr=$(echo $datefr | awk '{print $2}' | sed -e 's/\.//g')

                jourfr=${jourfr^}
                moisfr=${moisfr^}

                test=$clean
                test=${test/$jouren/"$jourfr"}
                test=${test/$moisen/"$moisfr"}

                if [ $type -eq 0 ]; then
                    awk '{printf "%-5s %-5s %-5s %-5s %-5s %-20s %-5s %-10s %-5s %-20s", $1, $2, $3, $4, $5, $6, $7, $8, $9, $10}' <<<"$test"
                    echo $clean | awk '{$1=$2=$3=$4=$5=$6=$7=$8=$9=$10=""; print $0}'
                else

                    [ ! -d "sortie" ] && mkdir "sortie"

                    echo $test | awk '{printf "%-5s %-5s %-5s %-5s %-5s %-20s %-5s %-10s %-5s %-20s", $1, $2, $3, $4, $5, $6, $7, $8, $9, $10}' | tee -a ./sortie/"$annee-$mois-export.imp"
                    echo $test | cut -d' ' -f 11- | tee -a ./sortie/"$annee-$mois-export.imp"
                fi

            done <$FILE
        fi
    done

    else
    echo "Aucunes données trouvées pour ce mois."
    fi
fi
