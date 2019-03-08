require_relative 'env'

# TODO: ask 4 vm-size
puts "TODO: ask for vm size"
# gets

# conf
# ---

STACK_NAME_DEFAULT = "launchpad"
STACK_NAME_DEFAULT = "test" unless defined? STACK_NAME_DEFAULT

# VM_SIZE_DEFAULT - the size of the VM, medium is good, 2 hyperthreads

# good default: medium, 2vCPUs
VM_SIZE_DEFAULT = "medium"

# default with alternate name (stack size: dev=small=1core, staging=medium=2cores, production=big=4cores)
VM_SIZE_DEFAULT = "staging" unless defined? VM_SIZE_DEFAULT

# 4 h-threads (vcpus)
VM_SIZE_DEFAULT = "big" unless defined? VM_SIZE_DEFAULT
VM_SIZE_DEFAULT = "production" unless defined? VM_SIZE_DEFAULT

# 1 h-thread (1 cpu core/hyperthread, 1 vCPU)
VM_SIZE_DEFAULT = "small" unless defined? VM_SIZE_DEFAULT
VM_SIZE_DEFAULT = "dev" unless defined? VM_SIZE_DEFAULT


# ---

CMD_DEFAULT = "help"
CMD_DEFAULT = "provision" unless defined? CMD_DEFAULT
CMD_DEFAULT = "destroy" unless defined? CMD_DEFAULT
CMD_DEFAULT = "and-deplot" unless defined? CMD_DEFAULT

# ---

STACK_NAME = ENV["STACK"] || STACK_NAME_DEFAULT
CMD = ENV["CMD"] || CMD_DEFAULT

# LIST
# ---
vms_list if CMD == "list"

# DELETE STACK
# ---
delete_stack stack_name: STACK_NAME if CMD == "destroy"

# exit

# DEPLOY STACK
#
#   Provision a new Stack (#provisioning, #infra_deployment)
#
# ---
deploy_stack stack_name: STACK_NAME if %w(provision deploy).include? CMD

# TODO: remove this
if CMD == "destroy-and-provision"
  delete_stack stack_name: STACK_NAME

  puts "wait for deletion before recreating stack..."
  sleep 10

  deploy_stack stack_name: STACK_NAME
end

# CMD = "help"
display_help if CMD == "help"

puts "command completed"
