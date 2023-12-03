for last; do true; done
count=0
test=()
if [ $last -eq 0 ]; then
     user=$1
     jour=$2
     mois=$3
     annee=$4

     dirfile="$5/$4/$3"
     file="$2_error.log"
     file2="$2_access.log"

     if [ -e "$dirfile/$file2" ]; then
          while IFS= read -r line; do
               ipx=$(echo $line | awk '{print $1}')
               userx=$(echo $line | awk '{print $2}')
               userx=${userx::-1}
               userx=${userx:1}
               if [ "$userx" == "$user" ]; then

                    test+=($ipx)
                    count=$(($count + 1))
               fi

          done <"$dirfile/$file2"

          uniq=($(printf "%s\n" "${test[@]}" | sort | uniq -c | sort -rnk1 | awk '{ print $2 }'))

          echo "L'utilisateur $1 a eu au total ${#uniq[@]} ip différente(s) le $jour/$mois/$annee : "
          for value in "${uniq[@]}"; do
               echo $value
          done
     else
          echo "Aucune donnée n'a été trouvée pour ce jour."
     fi

else

     user=$1
     mois=$2
     annee=$3
     dirfile="$4/$3/$2/*_access.log"
     if [ -d "$4/$3/$2" ]; then
          for FILE in $dirfile; do
               if [ -e $FILE ]; then
                    echo $FILE
                    while IFS= read -r line; do
                         ipx=$(echo $line | awk '{print $1}')
                         userx=$(echo $line | awk '{print $2}')
                         userx=${userx::-1}
                         userx=${userx:1}
                         if [ "$userx" == "$user" ]; then
                              test+=($ipx)
                              count=$(($count + 1))
                         fi

                    done <$FILE
               fi

          done

          uniq=($(printf "%s\n" "${test[@]}" | sort | uniq -c | sort -rnk1 | awk '{ print $2 }'))
          echo "L'utilisateur $1 a eu au total ${#uniq[@]} ip différente(s) le $mois/$annee : "
          for value in "${uniq[@]}"; do
               echo $value
          done
     else
     echo "Aucunes données pour ce mois."
     fi

fi
