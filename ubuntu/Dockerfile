FROM ubuntu:18.04

RUN apt-get update && \
    apt-get -y install -y \
    build-essential libgl1-mesa-dev libassimp-dev libfontconfig1 libdbus-1-3 curl

ENV QT_VERSION_MAJOR 5.11
ENV QT_VERSION 5.11.2

ENV QT_ARCHIVE https://download.qt.io/archive/qt
ENV QT_INSTALLER_NAME qt-opensource-linux-x64-"$QT_VERSION".run
ENV QT_INSTALLER_URL "$QT_ARCHIVE"/"$QT_VERSION_MAJOR"/"$QT_VERSION"/"$QT_INSTALLER_NAME"

ENV QT_DIST /usr/local/Qt-"$QT_VERSION"
ENV PATH $QT_DIST/bin:$PATH

COPY ./qt-installer-noninteractive.qs ./

RUN curl -sSL $QT_INSTALLER_URL > ./$QT_INSTALLER_NAME \
 && ls -a \
 && chmod +x $QT_INSTALLER_NAME \
 && ./$QT_INSTALLER_NAME --script ./qt-installer-noninteractive.qs --platform minimal --verbose

