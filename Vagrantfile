# -*- mode: ruby -*-
# vim: set ft=ruby :

MACHINES = {
  :pam => {
        :box_name => "centos/7",
        :ip_addr => '192.168.50.150',
		},
}

Vagrant.configure("2") do |config|

  MACHINES.each do |boxname, boxconfig|

      config.vm.define boxname do |box|

          box.vm.box = boxconfig[:box_name]
          box.vm.host_name = boxname.to_s

          box.vm.network "private_network", ip: boxconfig[:ip_addr]

          box.vm.provider :virtualbox do |vb|
            	  vb.customize ["modifyvm", :id, "--memory", "512"]
            	  vb.customize ["modifyvm", :id, "--cpus", "1"]
		      end
      
    
      box.vm.provision "shell", inline: <<-SHELL
      mkdir -p ~root/.ssh; cp ~vagrant/.ssh/auth* ~root/.ssh
      sed -i '65s/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
      systemctl restart sshd
    SHELL

   box.vm.provision "file", source: "./pamScript.sh", destination: "/vagrant/pamScript.sh"

   box.vm.provision "shell", path: "./provision.sh"
    end
  end
end
