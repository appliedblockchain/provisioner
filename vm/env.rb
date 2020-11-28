require_relative 'lib/utils'
require_relative 'lib/prereqs_lib'
require_relative 'lib/setup-docker-swarm'

USER = "azureuser"  # azure
# USER = "admin"  # debian
# USER = "ubuntu" # ubuntu

IP_A = ENV["IP_A"] || ENV["IP"]
ip_b = ENV["IP_B"]
ip_b = nil if ip_b.empty?
IP_B = ip_b

raise "IP not found, please specify the two required IP_A, IP_B env vars or at least one (IP or IP_A)" unless IP_A

IPS = if IP_B
  [ IP_A, IP_B ]
else
  [ IP_A ]
end
