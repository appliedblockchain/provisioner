# ubuntu

sshCmd = SSHUtils::SSHCmd

sshCmd = (cmd) -> { sshCmd.(cmd) }

Prepare -> {
  sshCmd.("cp /home/ubuntu/.ssh/authorized_keys ~/.ssh/authorized_keys")

  sshCmd.("apt update -y")

  sshCmd.("cd /tmp/ && wget http://nginx.org/keys/nginx_signing.key
  apt-key add nginx_signing.key")

  sshCmd.("sh -c \"echo 'deb http://nginx.org/packages/mainline/ubuntu/ '$(lsb_release -cs)' nginx' > /etc/apt/sources.list.d/nginx.list")

  sshCmd.("apt install -y nginx htop curl wget git")
}

CertificateSteps = -> {
  puts "Manual step for certificate:"
  puts "TODO - instruct the dev/devops for the cert procedure"
}

Configure = -> {
  sshCmd.("service nginx restart")
}

Status = -> {
  # TODO: report status
}

Main -> {
  Prepare.()
  CertificateSteps.()
  Configure.()
  Status.()
}

Main.()
