FROM ubuntu:18.04

RUN apt-get update && \
    apt-get -y install -y \
    build-essential libgl1-mesa-dev libassimp-dev libfontconfig1 libdbus-1-3

ENV QT_VERSION_MAJOR 5.11
ENV QT_VERSION 5.11.2

ENV QT_DIST /usr/local/Qt-"$QT_VERSION"
ENV QT_INSTALLER_URL https://download.qt.io/official_releases/qt/"$QT_VERSION_MAJOR"/"$QT_VERSION"/qt-opensource-linux-x64-"$QT_VERSION".run
ENV QT_INSTALLER_NAME /qtbase-opensource-src-"$QT_VERSION"

COPY ./vagrant/qt-installer-noninteractive.qs ./

RUN curl -sSL $QT_INSTALLER \
    && chmod +x $QT_INSTALLER_NAME \
    && $QT_INSTALLER_NAME --script ./qt-installer-noninteractive.qs --platform minimal --verbose  ~/Qt

ENV PATH $QT_DIST/bin:$PATH
