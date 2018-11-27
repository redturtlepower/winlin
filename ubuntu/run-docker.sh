# If the image does not exist, build it.
# The run the provisioner that installs the dependencies which are mounted in a volume, then commit the image.
if [ ! ( docker images | grep 'ubuntu_buildenv' ) ]
then
docker build . --rm --tag ubuntu_buildenv
docker run -it -d --rm --name provision_buildenv -v /Users/jenkins/Desktop/installers/windows:/var/installers ubuntu_buildenv:latest
docker exec -it provision_buildenv /bin/bash /home/jenkins/provision.sh
docker commit provision_buildenv ubuntu_buildenv
fi
# If the container is running stop it now.
if [ docker ps | grep 'ubuntu_buildenv' ]
then
docker stop ubuntu_buildenv
fi
# Start the container.
docker run -it -d --rm --name ubuntu_buildenv -v /Users/jenkins/Desktop/artifacts:/var/artifacts -p "2030:22" ubuntu_buildenv:latest

