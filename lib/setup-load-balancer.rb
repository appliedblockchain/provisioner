# ubuntu

sshCmd = SSHUtils::SSHCmd

sshCmdR = (cmd) -> { sshCmd.(cmd, :open3) }
sshCmd = (cmd) -> { sshCmd.(cmd) }

sshCmd.("cp /home/ubuntu/.ssh/authorized_keys ~/.ssh/authorized_keys")

# ---
# root

Prepare -> {
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
  # sshCmd.("customize lb template with ips, write lb-config nginx conf sites default (vhost)")
  sshCmd.("service nginx restart")
}

Status = -> {

}

Main -> {
  Prepare.()
  CertificateSteps.()
  Configure.()
  Status.()
}

Main.()

# ----

# as ubuntu

cp /home/ubuntu/.ssh/authorized_keys ~/.ssh/authorized_keys


# as root

apt update -y

cd /tmp/ && wget http://nginx.org/keys/nginx_signing.key
apt-key add nginx_signing.key

sh -c "echo 'deb http://nginx.org/packages/mainline/ubuntu/ '$(lsb_release -cs)' nginx' > /etc/apt/sources.list.d/nginx.list"

apt install -y nginx htop curl wget git

# TODO:
# copy load balancer configs

echo "ok now you can install the SSL certificates manually"

echo "step 1) download the certificate from dnsimple"

echo "step 2) scp the certificate to the server"

echo "  example:"

LOAD_BALANCER_IP=52.208.199.89
echo "    scp ~/Downloads/STAR_ab<CLIENT_NAME>_io.key $LOAD_BALANCER_IP:/etc/cert/STAR_ab<CLIENT_NAME>_io.key"
echo "    scp ~/Downloads/STAR_ab<CLIENT_NAME>_io.pem $LOAD_BALANCER_IP:/etc/cert/STAR_ab<CLIENT_NAME>_io.pem"

ssh root@52.208.199.89 mkdir -p /etc/cert
scp ~/Downloads/STAR_abaub_io.key root@52.208.199.89:/etc/cert/STAR_abaub_io.key
scp ~/Downloads/STAR_abaub_io.pem root@52.208.199.89:/etc/cert/STAR_abaub_io.pem


# TODO: copy load balancer

service nginx restart
