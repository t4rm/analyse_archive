for last; do true; done
count=0
test2=()
user=$1

if [ $last -eq 0 ]; then

     jour=$2
     mois=$3
     annee=$4
     dirfile="$5/$4/$3"
     file="$2_access.log"

     if [ -e "$dirfile/$file" ]; then
          while IFS= read -r line; do
               code=$(echo $line | awk '{print $(NF - 1)}')
               userx=$(echo $line | awk '{print $2}')
               userx=${userx::-1}
               userx=${userx:1}

               if [ $code != "\"GET" ] && [ $code != "+0200]" ] && [ $code != "HTTP/1.1\"" ] && [ $code != "\"POST" ]; then

                    if [ $userx = $user ]; then
                         test2+=($code)
                         count=$(($count + 1))
                    fi

               fi

          done <"$dirfile/$file"
     fi

     uniq=($(printf "%s\n" "${test2[@]}" | sort | uniq -c | sort -rnk1 | awk '{ print $2 }'))

     echo "L'utilisateur $1 a eu au total ${#uniq[@]} codes différente(s) le $jour/$mois/$annee : "
     for value in "${uniq[@]}"; do
          echo $value
     done

else
     mois=$2
     annee=$3
     dirfile="$4/$3/$2/*_access.log"

     if [ -d "$4/$3/$2" ]; then

          for FILE in $dirfile; do

               if [ -e $FILE ]; then
                    echo Fichier en cours: $FILE
                    while IFS= read -r line; do
                         code=$(echo $line | awk '{print $(NF - 1)}')
                         userx=$(echo $line | awk '{print $2}')
                         userx=${userx::-1}
                         userx=${userx:1}

                         if [ $code != "\"GET" ] && [ $code != "+0200]" ] && [ $code != "HTTP/1.1\"" ] && [ $code != "\"POST" ]; then

                              if [ $userx = $user ]; then
                                   test2+=($code)
                                   count=$(($count + 1))
                              fi

                         fi

                    done <$FILE
               fi

          done

          uniq=($(printf "%s\n" "${test2[@]}" | sort | uniq -c | sort -rnk1 | awk '{ print $2 }'))

          echo "L'utilisateur $1 a eu au total ${#uniq[@]} codes différente(s) le $mois/$annee : "
          for value in "${uniq[@]}"; do
               echo $value
          done
     else
          echo "Aucunes données pour ce mois."
     fi

fi
