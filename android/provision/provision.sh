# Install Qt
if [ "$(ls -a qt-installer)" ]; then
	echo "The directory 'qt-installer' is not empty. It is assumed that Qt has been installed already."
else
	echo "The directory 'qt-installer' is empty. Cloning repo and installing Qt..."
	git clone "https://github.com/redturtlepower/qt-installer.git" && cd qt-installer && chmod +x setup.sh && bash setup.sh
	# Remove compiler gcc_64
	rm -rf ~/Qt5.11.2/5.11.2/gcc_64
fi

# Install Android NDK + SDK

# docker-build --no-cache -t ubuntu-qt 
# docker run ubuntu-qt # to run startup cmd (install qt)
# docker commit -t ubuntu-qt
# docker exec -it ubuntu-qt-buildenv /bin/bash


# Install Qt development dependencies
# RUN git clone "https://github.com/redturtlepower/qt-installer.git" && cd qt-installer && chmod +x setup.sh && bash setup.sh

# Install Android development dependencies (Android SKD + NDK, Java JDK)
# https://dl.google.com/android/repository/android-ndk-r18b-linux-x86_64.zip 
# RUN curl -sL https://dl.google.com/android/repository/android-ndk-r18b-linux-x86_64.zip | tar -xJC  ~/.ndk
