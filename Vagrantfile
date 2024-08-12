# Vagrantfile
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/bionic64"
  
  (1..3).each do |i|
    config.vm.define "server#{i}" do |server|
      server.vm.hostname = "server#{i}"
      server.vm.network "private_network", ip: "192.168.50.#{10 + i}"
      server.vm.network "forwarded_port", guest: 80, host: 8080 + i
      server.vm.provider "virtualbox" do |vb|
        vb.memory = "256"
        vb.cpus = 1
      end

      # Ejecutar script de provisioning
      server.vm.provision "shell", path: "provision.sh"
    end
  end
end
