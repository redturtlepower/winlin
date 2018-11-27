if [ "$(ls -a qt-installer)" ]; then
	echo "The directory 'qt-installer' is not empty. It is assumed that Qt has been installed already."
else
	echo "The directory 'qt-installer' is empty. Cloning repo and installing Qt..."
	git clone "https://github.com/redturtlepower/qt-installer.git" && cd qt-installer && chmod +x setup.sh && bash setup.sh
fi

# docker-build --no-cache -t ubuntu-qt 
# docker run ubuntu-qt # to run startup cmd (install qt)
# docker commit -t ubuntu-qt
# docker exec -it ubuntu-qt-buildenv /bin/bash