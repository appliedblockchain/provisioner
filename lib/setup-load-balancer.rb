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

LOAD_BALANCER_IP=34.244.155.28
echo "    scp ~/Downloads/STAR_ab<CLIENT_NAME>_io.key $LOAD_BALANCER_IP:/etc/cert/STAR_ab<CLIENT_NAME>_io.key
"
echo "    scp ~/Downloads/STAR_ab<CLIENT_NAME>_io.pem $LOAD_BALANCER_IP:/etc/cert/STAR_ab<CLIENT_NAME>_io.pem
