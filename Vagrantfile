Vagrant.configure("2") do |config|

  config.vm.define "ubuntu" do |ub|
    ub.vm.provider "docker" do |d|
      d.name = "ubuntu"
      d.build_image = "./ubuntu"
      d.vagrant_vagrantfile = "./ubuntu/Vagrantfile"
      d.has_ssh = true
    end
  end

#  config.vm.define "wine" do |wi|
#    wi.vm.provider "docker" do |d|
#      d.name = "wine"
#      d.build_image = "./wine"
#      d.vagrant_vagrantfile = "./wine/Vagrantfile"
#    end
#  end
  
end
