FROM ubuntu:bionic
RUN dpkg --add-architecture i386
RUN apt-get update && \
    apt-get -y install -y \
    build-essential mesa-common-dev libglu1-mesa-dev libfontconfig1 openssh-server git curl openjdk-8-jdk

# Create and configure jenkins user
RUN useradd --create-home -s /bin/bash jenkins

# Set password to jenkins for user jenkins (like user:password).
# Use parameter -n to not pass the quotation marks.
RUN echo -n 'jenkins:jenkins' | chpasswd
RUN echo -n 'root:root' | chpasswd

# Enable passwordless sudo for the "jenkins" user
RUN mkdir -p /etc/sudoers.d  \
  && install -b -m 0440 /dev/null /etc/sudoers.d/jenkins \
  && echo 'jenkins ALL=NOPASSWD: ALL' >> /etc/sudoers.d/jenkins

RUN mkdir /var/run/sshd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
# Allow accessing user env to let ssh commands detect 'docker' without specifing full path:
RUN sed -i 's/#PermitUserEnvironment no/PermitUserEnvironment yes/' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]