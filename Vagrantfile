Vagrant.configure("2") do |config|
    
  config.vm.define "ubuntu" do |ub|
    ub.vm.provider "docker" do |d|
      d.name = "ubuntu"
      d.build_dir = "./ubuntu"
      d.force_host_vm = true
      d.vagrant_vagrantfile = "./ubuntu/Vagrantfile.host"
      d.ports = ["2030:22"]
      d.has_ssh = true
    end
    ub.ssh.username = "jenkins"
  end
 
#  config.vm.define" wine" do |wi|
#    wi.vm.provider "docker" do |d|
#      d.name = "wine"
#      d.build_dir = "./wine"
#      d.force_host_vm = true
#      d.vagrant_vagrantfile = "./wine/Vagrantfile.host"
#      d.ports = ["2040:22"]
#      d.has_ssh = true
#    end
#    wi.ssh.username = "jenkins"
#  end
  
end
