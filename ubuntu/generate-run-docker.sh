# Parameters

# The image and container name:
NAME=ubuntu_buildenv

# The port to listen on SSH on the host (is mapped to port 22 inside docker):
PORT=2030

FORCE_IMAGE_REBUILD=false

cp ../run-docker.template.sh run-docker-generated.sh
sed -i "s||g" run-docker-generated.sh