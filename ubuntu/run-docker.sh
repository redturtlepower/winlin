# General tips:
# How to remove all docker containers:
# `docker stop $(docker ps -a -q)`
# `docker rm $(docker ps -a -q)`
# Folling list should be empty: 
# `docker ps`

# How to remove all images:
# `docker rmi $(docker images -q)`


# The Dockerfile is in the folder 'ubuntu'
#docker-compose run buildenv
# docker-compose build buildenv
# ==> Successfully built 139asf7dasf 
# ==> Successfully tagged ubuntu_buildenv:latest
# alternatively:
docker build . --rm --tag ubuntu_buildenv

# State until now:
# Thomass-Mac-mini:ubuntu jenkins$ docker images
# REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
# ubuntu_buildenv     latest              65bfb1240b93        2 minutes ago       784MB
# ubuntu              bionic              93fd78260bd1        4 days ago          86.2MB
# Thomass-Mac-mini:ubuntu jenkins$ docker ps
# CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES



# Now modify the image: Install Qt!
# docker-compose run buildenv
# alternatively:
# docker run -it -v /Users/jenkins/Desktop/installers/linux:/var/installers ubuntu_buildenv:latest /bin/bash
docker run -it -d --rm --name provision_buildenv -v /Users/jenkins/Desktop/installers/linux:/var/installers ubuntu_buildenv:latest
# You are in the shell. Type 'exit' to end it.

# Type 'docker ps' to check the container is r unning and get its name. Something like <ubuntu_builden_run_X_XXXX>.
# Log into the container: 
# docker exec -it <ubuntu_buildenv_X_XXXX> /bin/bash
# Now check that the installer dir is mounted to /var/installers
# and check that the provision.sh script is in /home/jenkins.
# bash /home/jenkins/provision.sh
# Exit the container, type 'exit'.
# alternatively:
docker exec -it provision_buildenv /bin/bash /home/jenkins/provision.sh

# Now commit the changes made:
# docker commit <ubuntu_buildenv_X_XXXX> ubuntu_buildenv
# alternatively in case you have used docker instead of docker-compose:
docker commit provision_buildenv ubuntu_buildenv

# Then in production if you need the container, spin it up with:
docker run -it -d --rm --name ubuntu_buildenv -v /Users/jenkins/Desktop/artifacts:/var/artifacts -p "2030:22" ubuntu_buildenv:latest

