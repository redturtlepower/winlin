# Parameters
# The image and container name:
NAME=buildenv_base
FORCE_IMAGE_REBUILD=false

# To use the variable docker, replace all 'docker' commands with ${DOCKER}
# DOCKER=/usr/local/bin/docker
# Alternatively, just use an environment variable:
echo "PATH before extending: " ${PATH}
export PATH=/usr/local/bin:${PATH}
echo "PATH: " $PATH

# If the container is running stop it now.
echo "Checking if the container '${NAME}' is running. This base image container should never be run directly!!"
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
	echo "Finished building image '${NAME}'."
else
	echo "The image '${NAME}' does already exist."
fi

