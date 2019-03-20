# ### ruby constants used for configs

# AWS_PROFILE_NAME
# ---
#
AWS_PROFILE_NAME = "default"
# AWS_PROFILE_NAME = "emsurge"

# KEY_PAIR_NAME
# ---
# gives root access to the VMs to this username
#
# KEY_PAIR_NAME = "youruser"

#current
KEY_PAIR_NAME = "makevoid"

# ---

# note: this is for deletion, please use INTERACTIVE unless this is stable
#
# INTERACTIVE = false
INTERACTIVE = true

# ---

# note: VM_ENV is "dev" by default
#
# VM_ENV = "dev"
# VM_ENV = "staging"
# VM_ENV = "prod"

# development
# ---

STACK_NAME_DEFAULT = "launchpad2"


# production
# ---
#
# VM_ENV = "prod"
#
# STACK_NAME_DEFAULT = "emsurge-prod"
#
# VM_SIZE_DEFAULT = "big"


# ---

# HEALTHCHECK_PATH

# "/api/health"

HEALTHCHECK_PATH = "/api/health"

# ---
