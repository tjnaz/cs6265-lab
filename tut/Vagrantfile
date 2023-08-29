Vagrant.configure('2') do |config|

  config.vm.box = 'ubuntu/bionic64'

  config.vm.provision "file", source: "./kflag", destination: "/home/vagrant/kflag"
  config.vm.provision "file", source: "./tuts", destination: "/home/vagrant/tuts"
  config.vm.provision "file", source: "./seclab", destination: "/home/vagrant/seclab"
  config.vm.provision "file", source: "./setup.sh", destination: "/home/vagrant/setup.sh"
  config.vm.provision "shell", path: "./setup.sh"

  # no shared folder
  config.vm.synced_folder ".", "/vagrant", disabled: true

  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.memory = 8192
    vb.cpus = 4
  end

end
