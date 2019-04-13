# Provisioner

Docker swarm (and kubernetes) base VM provisioner

Please see the full guide in the devops guides:

#### https://app.gitbook.com/@appliedblockchain/s/devops 


Check out the section named Provisioner

(also remember that in provisioner/infra there is the infrastructure provisioner

---

more info on https://docs.google.com/presentation/d/1SFKvCiBauczMsDt8cX6AW0mRFbDoeSLGgRB-SjPIn04/edit#slide=id.g50664b0025_0_0


## How it's implemented


Provisioner details are 3, mainly 

#### 1) aws-sdk rb
#### 2) AWS Lightsail new "EC2 toolkit"
#### 3) A simple API: Exe.( system "ssh host cmd" )


The provisioner configuration file is:

