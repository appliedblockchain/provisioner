module Stacks

  def deploy_stack(stack_name:)
    puts "Deploying stack - #{stack_name}"
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

    deploy_load_bal

    puts "VMs created!"
  end

  def delete_stack(stack_name:)
    # new TODO new delete vms
    #
    # vms()
    # select by name
    # select by tag env

    puts "Deleting stack - #{stack_name}"
    puts "This will delete 3 VMs!"
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
