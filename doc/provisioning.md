# how to provision an environment

### Steps

##### 1 - Create VMs in Lightsail


---

### 1)  Create VMs in Lightsail

#### Create 1 load balancer VMs and 2 docker swarm VMs on AWS Lightsail or equivalent for Azure

Create the 3 VMs from the UI, use these details:

#### Region

Always use *eu-west-1* by default (Ireland)

#### OS

use Ubuntu 16.04 (or debian 9.5) - default settings

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


### 2) Update provisioner config