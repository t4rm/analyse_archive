dirbase=$1
date=$2

jour="$(cut -d'/' -f1 <<<$date)"
mois="$(cut -d'/' -f2 <<<$date)"
annee="$(cut -d'/' -f3 <<<$date)"

chmois=0

[ -z "$annee" ] && chmois=1


if [ $chmois -eq 0 ]; then

printf "[SCRIPT 4] Jour sélectionné : $jour/$mois/$annee (JJ/MM/AAAA)\n\n"
printf "Liste des options :\n"
PS3="Votre choix : "
select item in "- Formatage d'erreur afficher dans la console -" "- Formate d'erreur avec exportation -" "- Nombre d'erreur sur la date donnée -" "- Type d'erreur différents et leur nombre sur une journée -" "- Liste d'erreur en lien avec une IP sur la journée -" "- Liste d'erreur en lien avec un pid (process id) -" "- Liste des messages correspondant à un type d'erreur -" "- Fin -"; do
     echo "Vous avez choisi l'option $REPLY : $item"
     case $REPLY in
     1)
          ./scripts/formaterror.sh $jour $mois $annee 0 $dirbase $chmois
          ;;
     2)
          ./scripts/formaterror.sh $jour $mois $annee 1 $dirbase $chmois
          ;;
     3)
          ./scripts/nbrerror.sh $jour $mois $annee $dirbase $chmois
          ;;

     4)
          ./scripts/typeerror.sh $jour $mois $annee $dirbase $chmois
          ;;

     5)
          echo "Saisir addresse IP : "
          read ip
          ./scripts/listerrorip.sh $jour $mois $annee $ip $dirbase $chmois
          ;;

     6)
          echo "Saisir Process ID (PID) : "
          read pid
          ./scripts/listerrorpid.sh $jour $mois $annee $pid $dirbase $chmois
          ;;

     7)
          echo "Saisir Type d'erreur : "
          read typeerror
          ./scripts/printerror.sh $jour $mois $annee $typeerror $dirbase $chmois
          ;;

     8)
          echo "Fin du script"
          exit 0
          ;;

     *)
          echo "Choix incorrect"
          ;;
     esac
done

else

a=$mois
mois=$jour
annee=$a

printf "[SCRIPT 5] Mois sélectionné : $mois/$annee (MM/AAAA)\n\n"
printf "Liste des options :\n"

PS3="Votre choix : "
select item in "- Formatage d'erreur afficher dans la console -" "- Formate d'erreur avec exportation -" "- Nombre d'erreur sur la date donnée -" "- Type d'erreur différents et leur nombre sur une journée -" "- Liste d'erreur en lien avec une IP sur la journée -" "- Liste d'erreur en lien avec un pid (process id) -" "- Liste des messages correspondant à un type d'erreur -" "- Fin -"; do
     echo "Vous avez choisi l'option $REPLY : $item"
     case $REPLY in
     1)
          ./scripts/formaterror.sh $mois $annee 0 $dirbase $chmois
          ;;
     2)
          ./scripts/formaterror.sh $mois $annee 1 $dirbase $chmois
          ;;
     3)
          ./scripts/nbrerror.sh $mois $annee $dirbase $chmois
          ;;

     4)
          ./scripts/typeerror.sh $mois $annee $dirbase $chmois
          ;;

     5)
          echo "Saisir addresse IP : "
          read ip
          ./scripts/listerrorip.sh $mois $annee $ip $dirbase $chmois
          ;;

     6)
          echo "Saisir Process ID (PID) : "
          read pid
          ./scripts/listerrorpid.sh $mois $annee $pid $dirbase $chmois
          ;;

     7)
          echo "Saisir Type d'erreur : "
          read typeerror
          ./scripts/printerror.sh $mois $annee $typeerror $dirbase $chmois
          ;;

     8)
          echo "Fin du script"
          exit 0
          ;;

     *)
          echo "Choix incorrect"
          ;;
     esac
done

fi
