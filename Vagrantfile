Vagrant.configure("2") do |config|
    
  config.vm.define "ubuntu" do |ub|
    ub.vm.provider "docker" do |d|
      d.name = "ubuntu"
      d.build_dir = "./ubuntu"
      d.force_host_vm = true
      d.vagrant_vagrantfile = "./ubuntu/Vagrantfile"
      d.ports = ["2033:22"]
      d.has_ssh = true
    end
  
    ub.ssh.port = 2222
    ub.ssh.insert_key = false
    ub.ssh.username = 'docker'
    ub.ssh.password = 'tcuser'
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
