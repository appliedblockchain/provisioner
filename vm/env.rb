require_relative 'lib/utils'
require_relative 'lib/prereqs_lib'
require_relative 'lib/setup-docker-swarm'


USER = ENV["USER"] || "admin"  # debian, "ubuntu" for ubuntu

IP_A = ENV["IP_A"] || ENV["IP"]
IP_B = ENV["IP_B"]

raise "IP not found, please specify the two required IP_A, IP_B env vars or at least one (IP or IP_A)" unless IP_A

IPS = if IP_B
  [ IP_A, IP_B ]
else
  [ IP_A ]
end

require_relative 'config/pubkeys'
