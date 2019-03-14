require_relative 'lib/utils'
require_relative 'lib/prereqs_lib'
require_relative 'lib/setup-docker-swarm'

USER = "admin"  # debian
# USER = "ubuntu" # ubuntu

# TODO: load config
# TODO: parse config

# note: at the moment the configs are inline

# Aubit DEV (Aubit AWS)
# IP_A = "34.251.219.20"
# IP_B = "18.203.186.24"

# TIM DEV (AB AWS)
# IP_A = "34.253.184.70"
# IP_B = "34.241.254.136"

# TIM DEV2 (AB AWS)
# IP_A = "34.255.207.124"
# IP_B = "34.241.117.208"

# TOYOTA DEV (AB AWS)
# IP_A = "54.194.211.150"
# IP_B = "176.34.158.169"

# Launchpad (AB AWS)
# IP_A = "63.33.60.147"
# IP_B = "34.253.11.126"

# Temporary VMs
# IP_A = "134.209.80.168"
# IP_B = "134.209.95.216"

# Emsurge DEV (Emsurge AWS)
# IP_A = "34.242.248.101"
# IP_B = "34.242.8.238"

# Emsurge PROD (Emsurge AWS)
IP_A = "63.35.235.243"
IP_B = "34.242.38.215"


IPS = [ IP_A, IP_B ]

# Lightsail1 on mkv
# IP_A = "63.35.189.57"
# IPS = [ IP_A ]
