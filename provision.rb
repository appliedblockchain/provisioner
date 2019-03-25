require_relative 'env'
include Utils

SHOW_PREREQ = true
SETUP_ROOT_SSH  = true
INITIAL_APT_UPDATE = true
INSTALL_PACKAGES = true
INSTALL_DOCKER = true

# release type
RC_RELEASE = true

include PrereqsLib
include SetupDockerSwarm

IP_CURR = IP_A

module Provisioning

  def install_packages
    puts "1) Install Packages"
    return puts "skipping..." unless INSTALL_PACKAGES
    base_packages = "git curl wget vim"
    docker_packages = "apt-transport-https ca-certificates gnupg2 software-properties-common"
    ssh_all_exe_su "apt install -y #{base_packages} #{docker_packages}"
    puts "packages installed!"
  end

  def install_docker
    puts "2) Install Docker"
    return puts "skipping..." unless INSTALL_DOCKER
    ssh_all_exe_su "curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -"
    debian_release = "stretch" # output of: `lsb_release -cs`
    ssh_all_exe_su "add-apt-repository 'deb [arch=amd64] https://download.docker.com/linux/debian #{debian_release} stable'"
    ssh_all_exe_su "apt -y update"
    ssh_all_exe_su "apt -y install docker-ce docker-ce-cli containerd.io"
    puts "docker installed!"
  end

  def setup_docker_swarm
    puts "3) Setup docker swarm"
    return unless RC_RELEASE
    puts "you are running a release which din't landed as stable yet - see changelog (TODO create a changelog)"

    setupDockerSwarm = SetupDockerSwarm::Setup
    setupDockerSwarm.()
  end

end

include Provisioning

RunProvision = -> {
  puts "provisioning starting..."
  install_packages()
  install_docker()
  setup_docker_swarm()
  puts "provisioning ended"
}

ReportStatus = -> {
  puts "infra provisioning went ok!"
}

Provision = -> {
  # run pre-requisites
  Prereqs.()

  # run provisioning
  RunProvision.()

  # report status
  ReportStatus.()
}

# run everything - # TODO: pass arguments, eg. `MAIN(ip, ip2, ip3...)`
if __FILE__ == $0
  require_relative 'cli'
end
