
# Supprime (stop and rm) tous les containers docker

echo "------- LISTE DES CONTAINERS------"
docker ps -a

echo "------- ARRET DES CONTAINERS-----"
containersList=`docker ps -a | awk '{print $1}' | sed '1d'`
docker stop $containersList


echo "------- SUPPRESSION DES CONTAINERS-----"
docker rm $containersList
