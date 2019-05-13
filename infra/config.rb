AWS_PROFILE_NAME = ENV["AWS_PROFILE_NAME"] || "default"

KEY_PAIR_NAME = ENV["KEY_PAIR_NAME"] || "makevoid"

# note: this is for deletion, please use INTERACTIVE unless this is stable
# INTERACTIVE = false
INTERACTIVE = true

# VM_ENV = "dev" # default

STACK_NAME_DEFAULT = ENV["STACK"] || "launchpad2"

HEALTHCHECK_PATH = "/api/health"
