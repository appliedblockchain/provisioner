require_relative 'env'

# conf
# ---

STACK_NAME_DEFAULT = "launchpad" unless defined? STACK_NAME_DEFAULT

# VM_SIZE - the size of the VM, medium is good, 2 hyperthreads

# good default: medium, 2vCPUs
VM_SIZE = ENV["VM_SIZE"] if ENV["VM_SIZE"] && ENV["VM_SIZE"] != ""
VM_SIZE = "medium" unless defined? VM_SIZE

# ---

CMD_DEFAULT = "help"
CMD_DEFAULT = "provision" unless defined? CMD_DEFAULT
CMD_DEFAULT = "destroy" unless defined? CMD_DEFAULT
CMD_DEFAULT = "and-deplot" unless defined? CMD_DEFAULT

# ---

STACK_NAME = ENV["STACK"] || STACK_NAME_DEFAULT
CMD = ENV["CMD"] || CMD_DEFAULT

CURRENT_AVAIL_ZONE = "a"

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
if %w(provision deploy).include? CMD
  # TODO: support a non-interactive mode
  puts "\nPress any key to continue or Ctrl-C to quit.\n"
  gets

  deploy_stack stack_name: STACK_NAME
end

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
