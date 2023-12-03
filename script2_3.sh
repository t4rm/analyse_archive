dirbase=$1
date=$2

jour="$(cut -d'/' -f1 <<<$date)"
mois="$(cut -d'/' -f2 <<<$date)"
annee="$(cut -d'/' -f3 <<<$date)"

chmois=0

[ -z "$annee" ] && chmois=1


if [ $chmois -eq 0 ]; then

printf "[SCRIPT 2] Jour sélectionné : $jour/$mois/$annee (JJ/MM/AAAA)\n\n"
printf "Liste des options :\n"
PS3="Votre choix : "
select item in "- Nombre de requete d'une ip -" "- Nombre de requête par heure -" "- Nombre de codes de requêtes différent pour un utilisateur -" "- Différentes IP pour un utilisateur à une date donnée -" "- Fin -"; do
     echo "Vous avez choisi l'option $REPLY : $item"
     case $REPLY in
     1)
          echo "Saisir addresse IP : "
          read ip
          ./scripts/requete.sh $ip $jour $mois $annee $dirbase $chmois
          ;;
     2)
          ./scripts/requeteheure.sh $jour $mois $annee $dirbase $chmois
          ;;
     3)
          echo "Entrez un nom d'utilisateur : "
          read username2
          ./scripts/diffcode.sh $username2 $jour $mois $annee $dirbase $chmois
          ;;
     4)
          echo "Entrez un nom d'utilisateur : "
          read username
          ./scripts/diffip.sh $username $jour $mois $annee $dirbase $chmois
          ;;
     5)
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

printf "[SCRIPT 3] Mois sélectionné : $mois/$annee (MM/AAAA)\n\n"
printf "Liste des options :\n"
PS3="Votre choix : "
select item in "- Nombre de requete d'une ip sur un mois -" "- Nombre de requête par heure pour un mois -" "- Nombre de codes de requêtes différent pour un utilisateur sur le mois -" "- Différentes IP pour un utilisateur à un mois donné -" "- Fin -"; do
     echo "Vous avez choisi l'exercice $REPLY : $item"
     case $REPLY in
     1)
          echo "Saisir addresse IP : "
          read ip
          ./scripts/requete.sh $ip $mois $annee $dirbase $chmois
          ;;
     2)
          ./scripts/requeteheure.sh $mois $annee $dirbase $chmois
          ;;
     3)
          echo "Entrez un nom d'utilisateur : "
          read username2
          ./scripts/diffcode.sh $username2 $mois $annee $dirbase $chmois
          ;;
     4)
          echo "Entrez un nom d'utilisateur : "
          read username
          ./scripts/diffip.sh $username $mois $annee $dirbase $chmois
          ;;
     5)
          echo "Fin du script"
          exit 0
          ;;
     *)
          echo "Choix incorrect"
          ;;
     esac
done
fi
