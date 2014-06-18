# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  file_to_disk = File.realpath( "." ).to_s + "/oracle_disk.vdi"

  config.vm.box = "centos6.4"
  config.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/centos-64-x64-vbox4210-nocm.box"

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "1024"]
    vb.customize ["modifyvm", :id, "--memory", 2048, "--ioapic", "on"]
      if ARGV[0] == "up" && !File.exist?(file_to_disk)
        puts "Creating 5GB disk #{file_to_disk}."
        vb.customize [
            'createhd',
            '--filename', file_to_disk,
            '--format', 'VDI',
            '--size', 5000 * 1024 # 5 GB
        ]
      end
      vb.customize ['storageattach', :id,
            '--storagectl', 'SATA Controller',
            '--port', 1, '--device', 0,
            '--type', 'hdd', '--medium',
            file_to_disk
            ]
  end

  config.vbguest.auto_update = false

  config.vm.provision "shell", path: "provisioning/add_new_disk.sh"
  config.vm.provision "shell", path: "provisioning/oracle_provision.sh"

  config.vm.network "forwarded_port", guest: 8080, host: 8080, auto_correct: true
  config.vm.network "forwarded_port", guest: 1521, host: 1521, auto_correct: true
end
