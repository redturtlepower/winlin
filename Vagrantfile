Vagrant.configure("2") do |config|

  config.ssh.port = 2050
  config.ssh.insert_key = false
  config.ssh.username = 'docker'
  config.ssh.password = 'tcuser'
    
  config.vm.define "ubuntu" do |ub|
    ub.vm.provider "docker" do |d|
      d.name = "ubuntu"
      d.build_dir = "./ubuntu"
      d.force_host_vm = true
      d.vagrant_vagrantfile = "./ubuntu/Vagrantfile"
      d.ports = ["2033:22"]
      d.has_ssh = true
    end
  end

#  config.vm.define "wine" do |wi|
#    wi.vm.provider "docker" do |d|
#      d.name = "wine"
#      d.build_dir = "./wine"
#      d.force_host_vm = true
#      d.vagrant_vagrantfile = "./wine/Vagrantfile"
#      d.ports = ["2044:22"]
#      d.has_ssh = true
#    end
#    wi.ssh.port = 22
#  end
  
end
