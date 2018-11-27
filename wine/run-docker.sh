# If the image does not exist, build it.
# The run the provisioner that installs the dependencies which are mounted in a volume, then commit the image.
if [ ! ( docker images | grep 'wine_buildenv' ) ]
then
docker build . --rm --tag wine_buildenv
docker run -it -d --rm --name provision_buildenv -v /Users/jenkins/Desktop/installers/windows:/var/installers wine_buildenv:latest
docker exec -it provision_buildenv /bin/bash /home/jenkins/provision.sh
docker commit provision_buildenv wine_buildenv
fi
# If the container is running stop it now.
if [ docker ps | grep 'wine_buildenv' ]
then
docker stop wine_buildenv
fi
# Start the container.
docker run -it -d --rm --name wine_buildenv -v /Users/jenkins/Desktop/artifacts:/var/artifacts -p "2040:22" wine_buildenv:latest

