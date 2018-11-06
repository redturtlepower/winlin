Overview
==========

This repository is part of a larger build env setup consisting of

- Jenkins master that is configured via configuration-as-code (casc) and an initial seed job that builds a helloworld-demo app via its Jenkinsfile that adds 3 agents as follows:
- Build agents:
  - Mac Mini host which builds Qt apps for MacOS and iOS (1)
  - A Vagrant box on the Mac with Ubuntu which builds Qt apps for Linux (snap) (2)
  - A Vagrant box on the Mac with Ubuntu and Wine which builds Qt apps for Windows with MSVC (3)

Role of this repo in the bigger context
==========

This repository takes care of setting up build agents (2) and (3).

Use `vagrant up` to build an Ubuntu Bionic 18.04 box that users the docker provider.

The ubuntu box installs Qt.
The ubuntu wine box uses a pre-zipped folder with msvc toolchain.



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