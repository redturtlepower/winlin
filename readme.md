Develop Ubuntu build env ON THE MAC
Flag `-r` to start the container
`cd ubuntu
bash run-docker.sh -r`

`The container 'ubuntu_buildenv' is up and running.
CONTAINER ID        IMAGE               COMMAND               CREATED              STATUS                  PORTS                  NAMES
06578959d1c3        ubuntu_buildenv     "/usr/sbin/sshd -D"   About a minute ago   Up Less than a second   0.0.0.0:2030->22/tcp   ubuntu_buildenv`

Check installation of qt via qt-installer

`docker exec -it ubuntu_buildenv bash`

`Thomass-Mac-mini:ubuntu jenkins$ docker exec -it ubuntu_buildenv bash
root@06578959d1c3:/# ls
bin  boot  dev  etc  home  lib  lib64  media  mnt  opt  proc  qt-installer  root  run  sbin  srv  sys  tmp  usr  var`

qt-installer is already there. Download the latest version. But first check if /var/installers is mounted correctly from the MAC's folder /Users/jenkins/Desktop/installers
ls /var/installers
root@06578959d1c3:/# ls /var/installers
qt-opensource-linux-x64-5.11.2.run  qt-opensource-linux-x64-5.12.8.run
yes! Ok. Now install the latest version:

rm -rf qt-installer
git clone https://github.com/redturtlepower/qt-installer.git
cd qt-installer
bash qt-installer.sh --list-packages --filedir="/var/installers/" --filename="qt-opensource-linux-x64-5.12.8.run"
bash qt-installer.sh --filedir="/var/installers/" --filename="qt-opensource-linux-x64-5.12.8.run" --version=5.12.8 --packages="qt.qt5.qt5128.gcc_64 qt.qt5.5128.qtwebengine qt.qt5.5128.qtnetworkauth" --installdir="/home/jenkins/Qt" --cleanup

Error from installer:
libxkbcommon-x11 cannot open shared object file: No such file or directory
apt-get install libxkbcommon-x11-0 -y



Overview
==========

This repository is part of a larger build env setup consisting of

- Jenkins master that is configured via configuration-as-code (casc) and an initial seed job that builds a helloworld-demo app via its Jenkinsfile that adds 3 agents as follows:
- Build agents:
  - Mac Mini host which builds Qt apps for MacOS and iOS (1)
  - Docker for Mac with Ubuntu which builds Qt apps for Linux (snap) (2)
  - Docker for Mac with Ubuntu and Wine which builds Qt apps for Windows with MSVC (3)

Role of this repo in the bigger context
==========

run-mac-slave-setup.sh, run from the jenkins master via repo demos_jenkins_casc_docker
1. ONCE: Build docker images and save them (ubuntu_buildenv, wine_buildenv, android_buildenv)

create-and-deploy-ssh-keys-win-lin-android.sh, run from jenkins master via repo demos_jenkins_casc_docker
1. ONCE: Add keys to the images

Then for production ONCE call this to start the containers:
call 'docker-compose up'
this starts the services from the compose file 'docker-compose.yml' from the images from above.
When the mac booted and the docker daemon runs, it should restart the services according to the 'docker-compose.yml' file.


Development/Production usage
==========

Development:
Update the Dockerfiles of the ubuntu / windows slaves

Backup
===================

Role of this repo in the bigger context
---

This repository takes care of setting up build agents (2) and (3).

Use `vagrant up` to build an Ubuntu Bionic 18.04 box that users the docker provider.

The ubuntu box installs Qt.
The ubuntu wine box uses a pre-zipped folder with msvc toolchain.


Development/Production usage
----

To develop and test the vagrantfiles, use `vagrant up ubuntu-build`. This builds the docker images each time.
If that works, build a docker image and push it to the local registry. Then use vagrantfile.prod which uses those pre-created images to speed things up.


Some useful commands:

Destroy a vagrant box via global status to get its id and then use destroy:
vagrant global-status
vagrant global-status --prune
vagrant destroy <id> -f

Stop vagrant:
vagrant halt

vagrant up
vagrant up ubuntu
vagrant reload 
vagrant reload ubuntu


log in to boot2docker host vm:
ssh -p 2222 docker@localhost

log in to ubuntu/wine on docker:
ssh -p 2030 jenkins@192.168.2.221
ssh -p 2040 jenkins@192.168.2.221
