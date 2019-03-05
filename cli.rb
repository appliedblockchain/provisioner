arg1 = ARGV[0]
arg2 = ARGV[1]
arg3 = ARGV[1]

Help = -> {
  puts "AB Provisioner"
  puts "---"
  puts "AB Provisioner provisions an H/A Load Balancer and two docker swarm instances"
  puts "print extended help..."
  puts "..."

  exit
}

isString = -> (val) { val.is_a? String }

raiseError = -> (message, code) {
  puts "Error: #{code}"
  puts "  #{message}\n\n"
}

validateArg = -> (arg) {
  return if arg == isString.(arg1) && arg.length > 3
  raiseError.("Arg not valid: #{arg.inspect}", "ArgNotValid")
}

if arg1 == "help"
  Help.()
end

validateArg.(arg1) # load balancer
validateArg.(arg2) # vm1
validateArg.(arg3) # vm2
# validateArg.(arg4) # for an H/A load balancer you need 4 ips, 2 LBs and 2 VMs

Provision.()

exit
# TODO: finish cli

if arg4
  Provision.([arg1, arg2, arg3, arg4])
else
  Provision.([arg1, arg2, arg3])
end
