require_relative 'lib/utils'
require_relative 'lib/prereqs_lib'
require_relative 'lib/setup-docker-swarm'

USER = "admin"  # debian
# USER = "ubuntu" # ubuntu

# TODO: load config
# TODO: parse config

# note: at the moment the configs are inline

# Emsurge Pentest (AB AWS)
# IP_A = "34.245.131.197"
# IP_B = "63.33.208.125"

# Emsurge DEV (Emsurge AWS)
# IP_A = "34.240.92.1"
# IP_B = "52.215.184.197"

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
IP_A = "63.33.60.147"
IP_B = "34.253.11.126"

IPS = [ IP_A, IP_B ]

# Lightsail1 on mkv
# IP_A = "63.35.189.57"
# IPS = [ IP_A ]
