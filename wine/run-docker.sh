docker build . --rm --tag wine_buildenv
docker run -it -d --rm --name provision_buildenv -v /Users/jenkins/Desktop/installers/windows:/var/installers wine_buildenv:latest
docker exec -it provision_buildenv /bin/bash /home/jenkins/provision.sh
docker commit provision_buildenv wine_buildenv
docker run -it -d --rm --name wine_buildenv -v /Users/jenkins/Desktop/artifacts:/var/artifacts -p "2040:22" wine_buildenv:latest

