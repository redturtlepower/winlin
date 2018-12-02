# Parameters
# The image and container name:
NAME=ubuntu_buildenv
# The port to listen on SSH on the host (is mapped to port 22 inside docker):
PORT=2030
FORCE_IMAGE_REBUILD=false

# To use the variable docker, replace all 'docker' commands with ${DOCKER}
# DOCKER=/usr/local/bin/docker
# Alternatively, just use an environment variable:
echo "PATH before extending: " ${PATH}
export PATH=/usr/local/bin:${PATH}
echo "PATH: " $PATH

# If the container is running stop it now.
echo "Checking if the container '${NAME}' is running."
if docker ps | grep ${NAME}; then
	echo "Stopping container '${NAME}'..."
	docker stop ${NAME}
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
	docker build . --rm --tag ${NAME}

	# Stop the provisioning container.
	echo "Checking if the container 'provision_buildenv' is running."
	if docker ps | grep 'provision_buildenv'; then
		echo "Stopping container 'provision_buildenv'..."
		docker stop provision_buildenv
		echo "Stopped."
		else
		echo "The container 'provision_buildenv' is not running."
	fi

	docker run -d --rm --name provision_buildenv -v /Users/jenkins/Desktop/installers/linux:/var/installers ${NAME}:latest
	docker exec provision_buildenv /bin/bash /home/jenkins/provision.sh
	docker commit provision_buildenv ${NAME}
	# Stop the provisioning container.
	docker stop provision_buildenv
	echo "Finished building image '${NAME}'."
else
	echo "The image '${NAME}' does already exist."
fi

# Start the container.
docker run -it -d --rm --name ${NAME} -v /Users/jenkins/Desktop/artifacts:/var/artifacts -p "${PORT}:22" ${NAME}:latest

# Print the running containers
if docker ps | grep ${NAME}; then
	echo "The container '${NAME}' is up and running!"
else
	echo "The container '${NAME}' could not be started!"
fi
docker ps 

