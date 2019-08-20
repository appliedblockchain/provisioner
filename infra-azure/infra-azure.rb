# brew install jq // apt-get install -y jq

require 'json'
require 'open3'
require 'pp'

def exe(cmd, open3: true)
  puts "executing: #{cmd}"
  unless open3
    out = system cmd
  else
    out, err, st = Open3.capture3 cmd
  end
  puts out
  puts "#{err}\n"
  out
end


def az(cmd)
  JSON.parse exe "az #{cmd}"
end

def open_ports(group_name)
  az "network nsg rule create -g #{group_name} --nsg-name #{group_name}-nsg -n http --priority 100 --destination-port-range 80 --protocol Tcp --access Allow"
  az "network nsg rule create -g #{group_name} --nsg-name #{group_name}-nsg -n http --priority 110 --destination-port-range 2377 --protocol Tcp --access Allow"
  az "network nsg rule create -g #{group_name} --nsg-name #{group_name}-nsg -n http --priority 120 --destination-port-range 4789 --protocol Udp --access Allow"
  az "network nsg rule create -g #{group_name} --nsg-name #{group_name}-nsg -n http --priority 130 --destination-port-range 7946 --protocol Tcp --access Allow"
  az "network nsg rule create -g #{group_name} --nsg-name #{group_name}-nsg -n http --priority 140 --destination-port-range 7946 --protocol Tcp --access Allow"
end

group_name = "swarm1"

# az login

# accounts = az "account list"
# pp accounts

# groups = az "group list  --query \"[?name == 'swarm1']\""
# pp groups

# create_group = az "group create --name swarm1 --location northeurope"
# pp create_group

# create_nsg = az "network nsg create --resource-group swarm1 -n swarm1-node-nsg"
# pp create_nsg

vms = az "vm list --query \"[?name == 'swarm1-1']\""
pp vms

unless vms == [] 
  az "vm delete -y --name swarm1-1 --resource-group swarm1"
  puts "VMs deleted"
  exit
end

az "vm create --resource-group swarm1 --name swarm1-1 --size Standard_DS2_v2 --image Debian:debian-10:10:latest --admin-username abadmin --nsg swarm1-node-nsg --ssh-key-value ~/.ssh/id_rsa.pub"

az "vm create --resource-group swarm1 --name swarm1-2 --size Standard_DS2_v2 --image Debian:debian-10:10:latest --admin-username abadmin --nsg swarm1-node-nsg --ssh-key-value ~/.ssh/id_rsa.pub"

open_ports group_name

puts "Done!"
exit

# # Create VM
#
# # Delete resource group
# az group delete -n swarm1
#
# az network nsg list --output table
#
# az network nsg rule list -g swarm1 --nsg-name swarm1-node-nsg --output table
#
#
#
#
#
# # -------------------
#

# # Standard_DS2_v2 DS2_v2 northeurope


## # List SKUs (stock keeping units(?), ie allowances/restrictions)
# # az vm list-skus --output table | less
#
# # nsg delete
# az network nsg rule delete -g swarm1 --nsg-name swarm1-node-nsg -n https
#
# # Reset SSH key on VM
# az vm user update --resource-group SWAPS --name swaps --username ab --ssh-key-value ~/.ssh/id_rsa.pub
