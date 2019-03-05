module PrereqsLib
  Prereqs = -> {
    if SHOW_PREREQ
      puts "prereq: "
      puts "ssh #{USER}@#{IP_A}"
      puts "ssh #{USER}@#{IP_B}\n" if defined?(IP_B)

      puts "ssh config: (esshconfig)"
      puts "
    Host #{IP_A}
      User root
    Host #{IP_B if defined?(IP_B)}
      User root
      "
    end

    puts "Press any key to proceed or 'Ctrl-C' to abort..."
    gets unless RC_RELEASE

    if SETUP_ROOT_SSH
      ssh_all_exe_su_user "cp /home/#{USER}/.ssh/authorized_keys /root/.ssh/authorized_keys"
    end

    if INITIAL_APT_UPDATE
      ssh_all_exe_su "apt -y update"
    end

    # TODO: create better key setup section

    DEPLOYER_KEY = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDqP3bs2rrXNRZLdd19jXt/2i7gZA7BbkUUFhgBMca2baITdGQ2tzdbT2FOIBsAhfGVmNcITgeYa01YAOwpkbd/8bsbHGpn+0yHXsmeCDmBZQ6PG0xdy20U15uPn2a1QaMLtdkttfJquvhtwhd3HzVzLj3qZ+05T/GwRG0/TgJFoGgB9An/y0lWCMd9EfybPBhPeXXGEDaOvdniqWoqHdayE5+h8ar6+Phpei/DhKLKsHV3tTMTCLf1nbQZccbYNSFak4Yk8Ctd1mNSSUutdfVuEoUPH5MA9qe2CEQb6iPtAp/PnRaOCJrTReLPRdKjkPz6C7TPrpsZMEyiVzA+u1Nt deployer@appliedblockchain.com"
    ssh_all_exe_su "grep -qxF 'deployer@appliedblockchain.com' /root/.ssh/authorized_keys || echo \"#{DEPLOYER_KEY}\" >> /root/.ssh/authorized_keys"
  }
end
