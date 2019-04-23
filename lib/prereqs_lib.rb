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
    DEPLOYER_KEY = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDqP3bs2rrXNRZLdd19jXt/2i7gZA7BbkUUFhgBMca2baITdGQ2tzdbT2FOIBsAhfGVmNcITgeYa01YAOwpkbd/8bsbHGpn+0yHXsmeCDmBZQ6PG0xdy20U15uPn2a1QaMLtdkttfJquvhtwhd3HzVzLj3qZ+05T/GwRG0/TgJFoGgB9An/y0lWCMd9EfybPBhPeXXGEDaOvdniqWoqHdayE5+h8ar6+Phpei/DhKLKsHV3tTMTCLf1nbQZccbYNSFak4Yk8Ctd1mNSSUutdfVuEoUPH5MA9qe2CEQb6iPtAp/PnRaOCJrTReLPRdKjkPz6C7TPrpsZMEyiVzA+u1Nt deployer@appliedblockchain.com"
    DEAN_KEY = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC9RDQvkFiKVC4veG6kaiRf3GfbWUAyf90AHtPg1ne+N+Oe6Nvj9tViFfawXuAXWh+9He802lh6RtTeidrszmIW6toro8mMaP0YWruH2MSY80zix0qcLgd3K8jOglcq9Bf5junK2daNCJZ803F/f6obgcSGQYWG2e5eNgXz4EFC6+i832qV1jzeDaoBJ6QlJzcUCbkeRiLsUsm73w3DQJ8IN+SPKtuLNl0v+XWNUsbUP1T4QW41fsiITYz+m0QvNB7oJJcFIbyPGs3PVPersan7e/N0RHhhn3Xu6X9HOj37q4+EjkehRUiZdAgSo1Oa1dc5isuq3lnPfbYHdJwYq811 dricher@Deans-MacBook-Pro-2.local"
    ssh_all_exe_su "grep -qxF 'deployer@appliedblockchain.com' /root/.ssh/authorized_keys || echo \"#{DEPLOYER_KEY}\" >> /root/.ssh/authorized_keys"
    ssh_all_exe_su "grep -qxF 'dricher' /root/.ssh/authorized_keys || echo \"#{DEPLOYER_KEY}\" >> /root/.ssh/authorized_keys"
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
      ssh_all_exe_su_user "cp /home/#{USER}/.ssh/authorized_keys /root/.ssh/authorized_keys"
    end

    if INITIAL_APT_UPDATE
      ssh_all_exe_su "apt -y update"
    end

    CopySSHPubKeys.()
  }
end
