module Prereqs
  PREREQS = -> {
    if SHOW_PREREQ
      puts "prereq: "
      puts "ssh #{IP_A}"
      puts "ssh #{IP_B}\n"

      puts "ssh config: (esshconfig)"
      puts "
    Host #{IP_A}
      User root
    Host #{IP_B}
      User root
      "
    end

    if SETUP_ROOT_SSH
      user = "ubuntu"
      ssh_all_exe_su_user "cp /home/#{user}/.ssh/authorized_keys /root/.ssh/authorized_keys"
    end

    if INITIAL_APT_UPDATE
      ssh_all_exe_su "apt -y update"
    end
  }
end
