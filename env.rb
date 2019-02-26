require_relative 'lib/ssh_utils'
require_relative 'lib/prereqs'
require_relative 'lib/setup-docker-swarm'

# TODO: load config
# TODO: parse config

# note: at the moment the configs are inline

# Emsurge Pentest (AB AWS)
# IP_A = "34.245.131.197"
# IP_B = "63.33.208.125"

# Emsurge DEV (Emsurge AWS)
IP_A = "34.240.92.1"
IP_B = "52.215.184.197"

IPS = [ IP_A, IP_B ]

# Lightsail1 on mkv
# IP_A = "63.35.189.57"
# IPS = [ IP_A ]
