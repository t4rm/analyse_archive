#!/bin/bash
for last; do true; done
count=0
test=()

if [ $last -eq 0 ]; then

     jour=$1
     mois=$2
     annee=$3

     dirfile="$4/$3/$2"
     file="$1_error.log"

     if [ -e "$dirfile/$file" ]; then
          while IFS= read -r line; do

               erreur=$(echo $line | awk '{print $6}')
               erreur=${erreur::-1}
               erreur=${erreur:1}
               test+=($erreur)

          done <"$dirfile/$file"
          uniq=($(printf "%s\n" "${test[@]}" | sort | uniq -c | sort -rnk1 | awk '{ print $2 }'))

          echo "Il y a eu au total ${#uniq[@]} type d'erreurs différentes le $jour/$mois/$annee : "
          for value in "${uniq[@]}"; do
               echo $value
          done
     else
          echo "Aucunes données pour ce mois."
     fi

else

     mois=$1
     annee=$2

     dirfile="$3/$2/$1/*_error.log"

     if [ -d "$3/$2/$1" ]; then

          for FILE in $dirfile; do
               if [ -e $FILE ]; then
            echo Fichier en cours: $FILE
                    while IFS= read -r line; do

                         erreur=$(echo $line | awk '{print $6}')
                         erreur=${erreur::-1}
                         erreur=${erreur:1}
                         test+=($erreur)

                    done <$FILE
               fi
          done

          uniq=($(printf "%s\n" "${test[@]}" | sort | uniq -c | sort -rnk1 | awk '{ print $2 }'))

          echo "Il y a eu au total ${#uniq[@]} type d'erreurs différentes le $mois/$annee : "
          for value in "${uniq[@]}"; do
               echo $value
          done

     else
          echo "Aucunes données pour ce mois."
     fi
fi
