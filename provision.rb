require_relative 'env'
include SharedUtils

SHOW_PREREQ = false
SETUP_ROOT_SSH = false
INITIAL_APT_UPDATE = false
# main
INSTALL_PACKAGES = false
INSTALL_DOCKER = false

# SHOW_PREREQ = true
# SETUP_ROOT_SSH  = true
# INITIAL_APT_UPDATE = true
# INSTALL_PACKAGES = true
# INSTALL_DOCKER = true

include Prereqs
include SetupDockerSwarm

# for session tasks:
IP_CURR = IP_A
# IP_CURR = IP_B

module SSHUtils
  SSHCmd = -> {
    # TODO: "port" ssh_all_exe_su() as pure (stateless) function
    # ported_ssh_all_exe_su.()
  }
end

module Provisioning

  def install_packages
    puts "1) Install Packages"
    return puts "skipping..." unless INSTALL_PACKAGES
    base_packages = "git curl wget vim"
    docker_packages = "apt-transport-https ca-certificates gnupg-agent software-properties-common"
    ssh_all_exe_su "apt install -y #{base_packages} #{docker_packages}"
    puts "packages installed!"
  end

  def install_docker
    puts "2) Install Docker"
    return puts "skipping..." unless INSTALL_DOCKER
    ssh_all_exe_su "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -"
    ubuntu_release = "xenial" # output of: `lsb_release -cs`
    ssh_all_exe_su "add-apt-repository 'deb [arch=amd64] https://download.docker.com/linux/ubuntu #{ubuntu_release} stable'"
    ssh_all_exe_su "apt -y update"
    ssh_all_exe_su "apt -y install docker-ce docker-ce-cli containerd.io"
    puts "docker installed!"
  end

  def setup_docker_swarm
    puts "3) Setup docker swarm"
    return unless RC_RELEASE
    puts "you are running a release which din't landed as stable yet - see changelog (TODO create a changelog)"

    include SSHUtils
    sshCmd = SSHUtils::SSHCmd

    sshCmd = -> {
      #...
    }

    setupDockerSwarm.()
  end

  def antani

  end

end

include Provisioning

MAIN = -> {
  puts "provisioning starting..."
  install_packages()
  install_docker()
  setup_docker_swarm()
  puts "provisioning ended"
}

REPORT_STATUS = -> {
  puts "infra provisioning went ok!"
}

# run pre-requisites
PREREQS.()

MAIN.()

REPORT_STATUS.()
