Vagrant.configure("2") do |config|
    config.vm.box = "ubuntu/jammy64"  
    config.vm.network "forwarded_port", guest: 5000, host: 5000 
    config.vm.network "forwarded_port", guest: 80, host: 8080    
    
    # Senkronize klasör
    config.vm.synced_folder ".", "/vagrant", type: "virtualbox"
    
    # VM kaynakları
    config.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
      vb.cpus = 2
    end
    # VM Provision
    config.vm.provision "shell", path: "provision.sh", run: "always"
  end
