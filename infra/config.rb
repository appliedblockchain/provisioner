AWS_PROFILE_NAME = ENV["AWS_PROFILE_NAME"] || "default"

KEY_PAIR_NAME = ENV["KEY_PAIR_NAME"] || "makevoid"

# INTERACTIVE = false # disables the "Ctrl-C"-to-continue prompt
INTERACTIVE = true

# VM_ENV = "dev" # default

STACK_NAME_DEFAULT = ENV["STACK"] || "launchpad2"

HEALTHCHECK_PATH = "/api/health"
