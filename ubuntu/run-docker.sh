# Parameters
# The image and container name:
NAME=ubuntu_buildenv
# The port to listen on SSH on the host (is mapped to port 22 inside docker):
PORT=2030
DOCKER=/usr/local/bin/docker

# If the container is running stop it now.
echo "Checking if the container '${NAME}' is running."
if ${DOCKER} ps | grep ${NAME}; then
	echo "Stopping container '${NAME}'..."
	${DOCKER} stop ${NAME}
	echo "Stopped."
else
	echo "The container '${NAME}' is not running."
fi

# If the image does not exist, build it.
# The run the provisioner that installs the dependencies which are mounted in a volume, then commit the image.
echo "Checking if the image '${NAME}' needs to be build."
if ! ( ${DOCKER} images | grep ${NAME} )
then
	echo "The image '${NAME}' does not exist yet. Building..."
	${DOCKER} build . --rm --tag ${NAME}

	# Stop the provisioning container.
	echo "Checking if the container 'provision_buildenv' is running."
	if ${DOCKER} ps | grep 'provision_buildenv'; then
		echo "Stopping container 'provision_buildenv'..."
		${DOCKER} stop provision_buildenv
		echo "Stopped."
		else
		echo "The container 'provision_buildenv' is not running."
	fi

	${DOCKER} run -it -d --rm --name provision_buildenv -v /Users/jenkins/Desktop/installers/windows:/var/installers ${NAME}:latest
	${DOCKER} exec -it provision_buildenv /bin/bash /home/jenkins/provision.sh
	${DOCKER} commit provision_buildenv ${NAME}
	# Stop the provisioning container.
	${DOCKER} stop provision_buildenv
	echo "Finished building image '${NAME}'."
else
	echo "The image '${NAME}' does already exist."
fi

# Start the container.
${DOCKER} run -it -d --rm --name ${NAME} -v /Users/jenkins/Desktop/artifacts:/var/artifacts -p "${PORT}:22" ${NAME}:latest

# Print the running containers
if ${DOCKER} ps | grep ${NAME}; then
	echo "The container '${NAME}' is up and running!"
else
	echo "The container '${NAME}' could not be started!"
fi
${DOCKER} ps 

