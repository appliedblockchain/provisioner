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
    TIAGOACF_KEY = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDgGST8viwhPNfn5F/WjxUxzDRlYe6k+NwO7WXYULT3BRKd9rRNGEtvKs8evbXl1kxLdbBssw+Ppj6dBEWWZBlCSX0q/buqxL48hRDy+qttuC/DPqOYOPa0gb+d/wjA061jne4nyQQ5w+lWP+Iim6UdEItS7Pjk6jLTijPD7Rs9iLIXViRYRMfwV7MpcYItIGQAsZtceBjH26wlpttaKIdirC7JBp+BO7bCgPq1phIzH2+tmioRUfU/Orzmez6oUf4Wyw5+apC0a4GByGgA6AQORLstl+recuHRiTqdBUsEVnvZf5vfG8hYpbqUtcEnUP5ZwymRzKRof//Enu6JYH2x cardno:000606516550"
    ssh_all_exe_su "grep -qxF 'deployer@appliedblockchain.com' /root/.ssh/authorized_keys || echo \"#{DEPLOYER_KEY}\" >> /root/.ssh/authorized_keys"
    ssh_all_exe_su "grep -qxF 'cardno:000606516550' /root/.ssh/authorized_keys || echo \"#{TIAGOACF_KEY}\" >> /root/.ssh/authorized_keys"
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
