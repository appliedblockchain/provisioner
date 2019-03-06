# how to provision an environment

### Steps

##### 1 - Create VMs and Load balancer via provisioner/lightsail  (AWS Lightsail)

AUTOMATED GUIDE - NEW!

1) Prepare:

    cd lightsail && bundle  

Configure env.rb or pass the required parameters (`stack_name`)

2) Create VMs and load balancer - RUN!:

    rake

3) Access lightsail gui and double check


TODO: run infra checker

---

OLD manual guide

### 1)  Create VMs in Lightsail

#### Create 1 load balancer VMs and 2 docker swarm VMs on AWS Lightsail or equivalent for Azure

Create the 2 VMs from the UI, use these details:

#### Region

Always use *eu-west-1* by default (Ireland)

#### OS

use Debian 9.5 - default settings

Ubuntu 16.04 optional

### Sizes

Swarm VMs: 4 GB RAM, 2 vCPU, 80 GB SSD (20$ / mo)
LB VM: 1 GB RAM, 1 vCPU, 40 GB SSD (5$ / mo)

Size `DEV` envs:

    Swarm VMs: 16 GB RAM, 4 vCPUs, 320 GB SSD (80$ / mo)
    LB VM: 1 GB RAM, 1 vCPU, 40 GB SSD (5$ / mo)

Size `PROD/staging` envs (`staging`, `prod`, `beta`, `pentest`, `perftest`):

(TODO: we need equivalents for Azure)

    Swarm VMs: 16 GB RAM, 4 vCPUs, 320 GB SSD (80$ / mo)
    LB VM: 1 GB RAM, 1 vCPU, 40 GB SSD (5$ / mo) [or higher]


### 1B) Allow traffic on HTTPS for the load balancer

Select your load balancer VM

Go to the Networking section / tab

Add a new firewall security rule to allow HTTPS traffic in.

```
Application: | Protocol: | Port range:
HTTPS        | TCP       | 443
```

### 2) Update provisioner config

run `./publish.sh` from  `deployer`

```
cd ~/tmp && git clone git@github.com:appliedblockchain/deployer && cd deployer && git pull origin master && ./publish.sh
```


TODO: complete documentation
