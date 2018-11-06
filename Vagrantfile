#!/usr/bin/ruby

Vagrant.configure("2") do |config|
  
  #config.vm.synced_folder ".", "/vagrant", disabled: true  

  config.vm.boot_timeout = 360
  
  # Change `true` to `false` if you load the docker from an image instead of building it!
  def is_dev_mode
    true
  end

  config.vm.define "ubuntu" do |ub|
    ub.vm.provider "docker" do |d|
      d.name = "ubuntu"
      if is_dev_mode
        d.build_dir = "./ubuntu"
      else
        d.image = "buildenv-ubuntu"
      end 
      d.force_host_vm = true
      #d.volumes = ["/usr/local/bin:/usr/local/bin"]
      d.vagrant_vagrantfile = "Vagrantfile.host"
      d.ports = ["2030:22"]
      d.has_ssh = true
    end
    ub.ssh.username = "jenkins"
  end
 
  config.vm.define "wine" do |wi|
    wi.vm.provider "docker" do |d|
      d.name = "wine"
      d.build_dir = "./wine"
      d.force_host_vm = true
      d.vagrant_vagrantfile = "Vagrantfile.host"
      d.ports = ["2040:22"]
      d.has_ssh = true
    end
    wi.ssh.username = "jenkins"
  end
  
end