# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  config.vm.box = "ntrepid8/trusty64-salty"

  config.vm.provider "virtualbox" do |v|
    v.memory = 2048
    v.cpus = 2
  end

  # Misc Vars
  vagrant_path = File.dirname(__FILE__)
  config.vm.network "public_network", bridge: "en5: Thunderbolt Ethernet"

  # ports

  # use rsync synced folder for speed
  # NOTE: this is one way sync, files to not transfer from the guest back to the host.
  config.vm.synced_folder ".", "/vagrant", type: "rsync",
    rsync__exclude: [
      ".git/",
      ".DS_Store",
      "_build/",
      "Mnesia.nonode@nohost/",
      "deps/",
      "rel/",
      "mix.lock",
      "*.so",
      ".hosts.erlang",
    ],
    rsync__args: ["--recursive", "--archive", "--delete", "--verbose"],
    rsync__verbose: true

  # synced folder for sharing back to the host
  FileUtils.mkdir_p("/tmp/config_vm_share")
  config.vm.synced_folder "/tmp/config_vm_share", "/tmp/share"
  config.vm.synced_folder "~/.aws", "/home/vagrant/.aws"

  # synced folder for SaltStack
  config.vm.synced_folder "salt/", "/srv/salt/"
  config.vm.provision :salt do |salt|
    salt.pillar({
        "workspace" => {
          "path" => "/vagrant",
          "user" => "vagrant"
        }
      })

    salt.minion_config = "salt/minion"
    salt.run_highstate = true
    salt.bootstrap_options = "-F -c /tmp -P"

    # Salt takes a really long time to run the very first time.
    # Uncomment the line below if you want to see all the output.
    #salt.verbose = true
  end

  # provisioners
  config.vm.provision "shell", inline: <<-SHELL
    # hold esl-erlang to the correct version (1:18.2)
    sudo apt-mark hold esl-erlang
    echo "\n\ncd /vagrant" >> /home/vagrant/.bashrc

  SHELL

end
