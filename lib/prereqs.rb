module Prereqs
  PREREQS = -> {
    if SHOW_PREREQ
      puts "prereq: "
      puts "ssh #{IP_A}"
      puts "ssh #{IP_B}\n" if defined?(IP_B)

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
      user = "ubuntu"
      ssh_all_exe_su_user "cp /home/#{user}/.ssh/authorized_keys /root/.ssh/authorized_keys"
    end

    if INITIAL_APT_UPDATE
      ssh_all_exe_su "apt -y update"
    end
  }
end
