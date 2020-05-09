# Parameters
# The image and container name:
BASENAME=buildenv_base
NAME=ubuntu_buildenv
# The port to listen on SSH on the host (is mapped to port 22 inside docker):
PORT=2030
FORCE_IMAGE_REBUILD=false

# PARAMETERS
START_CONTAINER=false # Option -r     Example: 'bash run-docker.sh -r'
while getopts r option # handle more options by : separator. Example: 'getopts r:x:s: option'
do
case "${option}"
in
r) START_CONTAINER=true;; #get value (if any) with '${OPTARG}'
esac
done


# To use the variable docker, replace all 'docker' commands with ${DOCKER}
# DOCKER=/usr/local/bin/docker
# Alternatively, just use an environment variable:
echo "PATH before extending: " ${PATH}
export PATH=/usr/local/bin:${PATH}
echo "PATH: " $PATH

# If the container is running stop it now.
echo "Checking if the container '${NAME}' is running."
if docker container ls | grep ${NAME}; then
	echo "Stopping container '${NAME}'..."
	docker stop ${NAME}
	docker rm ${NAME}
	echo "Stopped."
else
	echo "The container '${NAME}' is not running."
fi

# If the image does not exist, build it.
# The run the provisioner that installs the dependencies which are mounted in a volume, then commit the image.
echo "Checking if the image '${NAME}' needs to be build."
if ( !  ( docker images ) | grep ${NAME} )  || ( $FORCE_IMAGE_REBUILD = true )
then
	echo "The image '${NAME}' does not exist yet or has been forced to rebuild. Building..."
	
	# The base image 'buildenv_base' must have been build already!
	# To build this image 'android_buildenv', only the provision script needs to be run!
	# docker build . --rm --tag ${NAME}

	# Stop the provisioning container.
	echo "Checking if the container 'provision_buildenv' is running."
	if docker ps | grep 'provision_buildenv'; then
		echo "Stopping container 'provision_buildenv'..."
		docker stop provision_buildenv
		echo "Stopped."
		else
		echo "The container 'provision_buildenv' is not running."
	fi

	docker run -d --rm --name provision_buildenv -v /Users/jenkins/winlin/ubuntu/provision:/var/provision -v /Users/jenkins/Desktop/installers/linux:/var/installers ${BASENAME}:latest
	# docker exec provision_buildenv /bin/bash /home/jenkins/provision.sh
	docker exec provision_buildenv /bin/bash /var/provision/provision.sh
	docker commit provision_buildenv ${NAME}
	# Stop the provisioning container.
	docker stop provision_buildenv
	echo "Finished building image '${NAME}'."
else
	echo "The image '${NAME}' does already exist."
fi
docker stop ${NAME}


if ($START_CONTAINER)
# Run the container.
# Fails if there is a stopped container with the same NAME.
# Check stopped containers with 'docker ps a' or 'docker container list -a'
# Error message:
#Thomass-Mac-mini:ubuntu jenkins$ docker run -it -d --rm --name ubuntu_buildenv -v /Users/jenkins/Desktop/artifacts:/var/artifacts -p "2030:22" ubuntu_buildenv:latest
#docker: Error response from daemon: Conflict. The container name "/ubuntu_buildenv" is already in use by container "59541e117e80b5e3bf1c331592ff79970b92e4a1774441f3c0245adea9ae4d93". You have to remove (or rename) that container to be able to reuse that name.
#docker start --name ubuntu_buildenv
then
  if ( docker container ls -a | grep ${NAME} ) # search for NAME in ALL containers (running and stopped ones)
  then
    echo "Starting existing container."
    docker start ${NAME}
  else
    echo "Running a new container."
    docker run -it -d --rm --name ${NAME} -v /Users/jenkins/Desktop/artifacts:/var/artifacts -p "${PORT}:22" ${NAME}:latest
  fi
else
echo "Not starting the container at the end."
fi


# Print the running containers
if docker container ls | grep ${NAME}; then
	echo "The container '${NAME}' is up and running."
else
	echo "The container '${NAME}' is not running."
fi
docker container ls

