module PrereqsLib

  AddSSHKnownHost = -> (ip) {
    known_hosts = File.expand_path "~/.ssh/known_hosts"

    ip_present = system "ssh-keygen -F #{ip}";
    unless ip_present
      puts system "ssh-keyscan -H #{ip} >> #{known_hosts}"
      puts "IP added to known hosts\n"
    else
      puts "IP already present"
    end
  }

  AddSSHKnownHosts = -> {
    puts "Adding IPs to known hosts"
    AddSSHKnownHost.(IP_A)
    AddSSHKnownHost.(IP_B) if IP_B
    puts "\n\n"
  }

  CopySSHPubKeys = -> {
    pub_keys = DefinePubKeys.()
    ssh_all_exe_su "grep -qxF 'deployer@appliedblockchain.com' /root/.ssh/authorized_keys || echo \"#{pub_keys[:DEPLOYER_KEY]}\" >> /root/.ssh/authorized_keys"
  }

  Prereqs = -> {
    puts "Provisioning VMs:"
    puts "A: #{IP_A}"
    puts "B: #{IP_B}" if IP_B
    puts "\n\n"

    AddSSHKnownHosts.()

    puts "Press any key to proceed or 'Ctrl-C' to abort..."
    gets if CLI_RUN

    if SETUP_ROOT_SSH
      ssh_all_exe_su_user "mkdir -p /root/.ssh"
      ssh_all_exe_su_user "cp /home/#{USER}/.ssh/authorized_keys /root/.ssh/authorized_keys"
    end

    if INITIAL_APT_UPDATE
      ssh_all_exe_su "apt -y update"
    end

    CopySSHPubKeys.()
  }
end
