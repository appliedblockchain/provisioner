# Provisioner

Docker swarm (and kubernetes) base VM provisioner

## Install prerequisites

Clone the repo, then:

For the Infrastructure Provisioner:

```
cd infra
bundle
```

For the Docker Swarm Provisioner, in the main directory (`cd ..`):

```
bundle
```

You'll have ruby installed. 


## Usage - Infrastructure provisioner

```
rake
```

Will print a help usage, with command hits like this one:

```
rake STACK=stack-name AWS_PROFILE_NAME=aws-credentials-name KEY_PAIR_NAME=your-username CMD=provision
```

Which will use few defaults and provision 2x Lightsail VMs, with some standard network rules and a Lightsail Load Balancer in front.


## Usage - Docker Swarm setup provisioning

```
rake IP_A=123.456.789.0 IP_A=234.567.89.0
```

Will set up the VMs, install docker so you will be able to run your `docker stack deploy` command and have a live docker swarm env.


Happy Deployments,

The Applied Blockchain Dev Team.

