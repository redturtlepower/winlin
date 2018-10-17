FROM phusion/baseimage:0.11

# enable ssh
RUN rm -f /etc/service/sshd/down

# Regenerate SSH host keys. baseimage-docker does not contain any, so you
# have to do that yourself. You may also comment out this instruction; the
# init system will auto-generate one during boot.
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

#RUN apt-get update && \
#    apt-get -y install -y \
#    build-essential libgl1-mesa-dev libassimp-dev libfontconfig1 libdbus-1-3 curl

RUN mkdir -p /var/run/sshd
RUN chmod 0755 /var/run/sshd
#RUN echo -n 'root:root' | chpasswd

# Create and configure jenkins user
RUN useradd --create-home -s /bin/bash jenkins
#WORKDIR /home/jenkins

# Configure SSH access 
#RUN echo "/usr/share:" && ls -a /usr/share
#COPY ./jenkins_slave.pub /home/jenkins/
#COPY /usr/share/jenkins_slave.pub /home/jenkins/
#RUN echo "/usr/share:" && ls -a /usr/share
RUN mkdir -p /home/jenkins/.ssh
#RUN cat ./jenkins_slave.pub > /home/jenkins/.ssh/authorized_key
ENV SSH_PUB_KEY_URL https://raw.githubusercontent.com/redturtlepower/winlin/master/ubuntu/jenkins_slave.pub
RUN curl $SSH_PUB_KEY_URL > /home/jenkins/.ssh/jenkins_slave.pub
RUN cat /home/jenkins/.ssh/jenkins_slave.pub > /home/jenkins/.ssh/authorized_key
#RUN echo -n "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDf/KEqXv7oCsl4xoOIbdJLP5NbNX18Xuq+qn5sb2FYYc1DfIocz0xPlSI+XuU3ckEOR6PnXj4f7oYCTutXD9iWuR6Vxy3y4hgXthW4z7aWrb9rVO8tB1m7q27/dUQoSb+ikPJpItJdBgOCIF5uY23mq5BlTBXTKaBCGGuebgnWusf1/7bujV5lNaABPY88RDJQIMP5oe8yNQ26Vf8EiPBufx7YaV7tS1xfL0EDM6qpydqKzhxJj46foS1XNkXE12Ia2VneDGCKSD597k1gSuORNyg9toC0KAwgVTixpTBgTqXXDYfX/2vt1QEgdJOYimWTKAYwHyBzDrnMl6QY1ym7 thomas.rusche@gmail.com" > /home/jenkins/.ssh/authorized_keyss


RUN chown -R jenkins: /home/jenkins/.ssh

# Set password to jenkins for user jenkins (like user:password).
# Use parameter -n to not pass the quotation marks.
RUN echo -n 'jenkins:jenkins' | chpasswd

# Enable passwordless sudo for the "jenkins" user
RUN mkdir -p /etc/sudoers.d
RUN install -b -m 0440 /dev/null /etc/sudoers.d/jenkins
RUN echo 'jenkins ALL=NOPASSWD: ALL' >> /etc/sudoers.d/jenkins

# Install Qt development dependencies
ENV QT_VERSION_MAJOR 5.11
ENV QT_VERSION 5.11.2
ENV QT_ARCHIVE https://download.qt.io/archive/qt
ENV QT_INSTALLER_NAME qt-opensource-linux-x64-"$QT_VERSION".run
ENV QT_INSTALLER_URL "$QT_ARCHIVE"/"$QT_VERSION_MAJOR"/"$QT_VERSION"/"$QT_INSTALLER_NAME"
ENV QT_DIST /usr/local/Qt-"$QT_VERSION"
ENV PATH $QT_DIST/bin:$PATH
# ENV QT_INSTALL_PACKAGES gcc_64,qtquickcontrols,qtlocation,qtquick1,qtwebengine 
ENV QT_PROVISIONER_SCRIPT_URL https://raw.githubusercontent.com/redturtlepower/winlin/master/ubuntu/qt-installer-noninteractive.qs

#COPY ./qt-installer-noninteractive.qs ./
#COPY ./$QT_INSTALLER_NAME ./

RUN curl $QT_PROVISIONER_SCRIPT_URL > ./qt-installer-noninteractive.qs
#RUN curl $QT_INSTALLER_URL > ./$QT_INSTALLER_NAME \
#RUN ls -a \
#    && chmod +x $QT_INSTALLER_NAME \
#    && ./$QT_INSTALLER_NAME --script ./qt-installer-noninteractive.qs --platform minimal --verbose /
#    && ls -a $QT_DIST
#RUN rm ./$QT_INSTALLER_NAME

