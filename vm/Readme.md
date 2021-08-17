# Provisioner - VM Configuration

---

#### NOTE: This VM configurator is deprecated - please look at the new one:

### https://github.com/appliedblockchain/chef_config_mgr.git

------------

### Commands:

### Configure 2 VMs for docker swarm

    IP_A=1.2.3.4 IP_B=2.3.4.5 rake

(NOTE: replace IP_A and IP_B with your VM IPs)

This will provision a docker swarm cluster onto your 2 VMs making sure docker and all primary dependencies are installed.


### Configure a single VM

To prepare a VM, installing docker and other common packages and tools run:

    IP=1.2.3.4 rake

replacing IP with your VM's IP

This will configure/prepare a single VM

### Branches

- `k3s` - configures 3 VMs for kubernetes (K3S)


Have fun!
