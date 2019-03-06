require_relative 'env'

# TODO: ask 4 vm-size
puts "TODO: ask for vm size"
# gets

# conf
# ---

STACK_NAME_DEFAULT = "tim2"

CMD_DEFAULT = "delete"
CMD_DEFAULT = "deploy"

# ---

STACK_NAME = ENV["STACK"] || STACK_NAME_DEFAULT
CMD = ENV["CMD"] || CMD_DEFAULT

# LIST
# ---
vms_list if CMD == "list"

# DELETE STACK
# ---
delete_stack stack_name: STACK_NAME if CMD == "delete"

# exit

# DEPLOY STACK
# ---
deploy_stack stack_name: STACK_NAME if CMD == "deploy"
