#!/bin/bash

mois=$1
annee=$2
type=$3

dirfile="./$2/$1/*_error.log"
count=0
test=()

for FILE in $dirfile; do
     if [ -e $FILE ]; then
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
