Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.network "private_network", ip: "10.0.0.70"
  config.vm.network "forwarded_port", guest: 3000, host: 3000
  config.vm.network "forwarded_port", guest: 80, host: 8080

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "ansible/dev-playbook.yml"
  end

  config.vm.synced_folder ".", "/vagrant", type: "nfs"
  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "2048"]

    # Sync time every 5 seconds so code reloads properly
    vb.customize ["guestproperty", "set", :id, "--timesync-threshold", 5000]
  end
end
