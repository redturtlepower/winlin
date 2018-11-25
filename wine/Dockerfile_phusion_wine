FROM phusion/baseimage:0.11

# enable ssh
RUN rm -f /etc/service/sshd/down

# Regenerate SSH host keys. baseimage-docker does not contain any, so you
# have to do that yourself. You may also comment out this instruction; the
# init system will auto-generate one during boot.
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

RUN apt-get update && \
    apt-get -y install -y \
    build-essential mesa-common-dev libglu1-mesa-dev libfontconfig1 openssh-server git curl openjdk-8-jdk wine-stable

RUN mkdir -p /var/run/sshd
RUN chmod 0755 /var/run/sshd
#RUN echo -n 'root:root' | chpasswd

# Create and configure jenkins user
RUN useradd --create-home -s /bin/bash jenkins

# Configure SSH access 
ENV SSH_PUB_KEY_URL https://raw.githubusercontent.com/redturtlepower/winlin/master/jenkins_slave.pub
RUN mkdir -p /home/jenkins/.ssh \
  && curl $SSH_PUB_KEY_URL > /home/jenkins/jenkins_slave.pub \ 
  && cat /home/jenkins/jenkins_slave.pub > /home/jenkins/.ssh/authorized_keys \
  && rm /home/jenkins/jenkins_slave.pub \
  && chown -R jenkins: /home/jenkins/.ssh

# Set password to jenkins for user jenkins (like user:password).
# Use parameter -n to not pass the quotation marks.
RUN echo -n 'jenkins:jenkins' | chpasswd

# Enable passwordless sudo for the "jenkins" user
RUN mkdir -p /etc/sudoers.d  \
  && install -b -m 0440 /dev/null /etc/sudoers.d/jenkins \
  && echo 'jenkins ALL=NOPASSWD: ALL' >> /etc/sudoers.d/jenkins

# Install Qt development dependencies
#RUN git clone "https://github.com/redturtlepower/qt-installer.git" && cd qt-installer && chmod +x setup.sh && bash setup.sh

#ENV QT_VERSION_MAJOR 5.11
#ENV QT_VERSION 5.11.2
#ENV QT_ARCHIVE https://download.qt.io/archive/qt
#ENV QT_INSTALLER_NAME qt-opensource-linux-x64-"$QT_VERSION".run
#ENV QT_INSTALLER_URL "$QT_ARCHIVE"/"$QT_VERSION_MAJOR"/"$QT_VERSION"/"$QT_INSTALLER_NAME"
#ENV QT_DIST /usr/local/Qt-"$QT_VERSION"
#ENV PATH $QT_DIST/bin:$PATH
# ENV QT_INSTALL_PACKAGES gcc_64,qtquickcontrols,qtlocation,qtquick1,qtwebengine 
#ENV QT_PROVISIONER_SCRIPT_URL https://raw.githubusercontent.com/redturtlepower/winlin/master/ubuntu/qt-installer-noninteractive.qs

#RUN curl $QT_PROVISIONER_SCRIPT_URL > /home/jenkins/qt-installer-noninteractive.qs \
# && curl $QT_INSTALLER_URL > /home/jenkins/$QT_INSTALLER_NAME \
# && ls -a \
# && chmod +x /home/jenkins/$QT_INSTALLER_NAME \
# && /home/jenkins/$QT_INSTALLER_NAME --script /home/jenkins/qt-installer-noninteractive.qs#--platform minimal --verbose /
# && ls -a $QT_DIST 
#RUN rm /home/jenkins/$QT_INSTALLER_NAME && rm /home/jenkins/qt-installer-noninteractive.qs