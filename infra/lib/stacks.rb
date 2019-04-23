module Stacks

  def deploy_stack(stack_name:)
    puts "Deploying stack - name: #{stack_name} - AWS: #{AWS_PROFILE_NAME} - VM size: #{VM_SIZE} - KEY: #{KEY_PAIR_NAME}"

    # TODO: support a non-interactive mode
    puts "\nPress any key to continue or Ctrl-C to quit.\n"
    gets

    deploy_vms stack_name: stack_name

    deploy_load_bal stack_name

    puts "VMs created!"
  end

  def deploy_vms(stack_name:)
    tasks = []
    tasks << Thread.new do
      vm = "#{stack_name}-1"
      deploy_vm vm
      puts "your instances will be ready in ~20s, please wait ~1m for the networking rules to be applied"
      sleep 40
      open_ports vm
    end
    tasks << Thread.new do
      vm = "#{stack_name}-2"
      deploy_vm vm
      sleep 40
      open_ports vm
    end
    tasks.map &:join
  end

  def delete_stack(stack_name:)
    # new TODO new delete vms
    #
    # vms()
    # select by name
    # select by tag env

    puts "Deleting stack - #{stack_name}"
    puts "This will delete 2 VMs and 1 Load Balancer!"
    puts "Are you sure? Hit Ctrl-C to terminate!"
    gets
    puts "deleting..."
    tasks = []
    tasks << Thread.new do
      delete_vm name: "#{stack_name}-1", prompt: false
    end
    tasks << Thread.new do
      delete_vm name: "#{stack_name}-2", prompt: false
    end
    tasks.map &:join
    puts "VMs deleted!"
  end

end
