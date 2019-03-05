module Stacks

  def deploy_stack(stack_name:)
    puts "Deploying stack - #{stack_name}"
    tasks = []
    # tasks << Thread.new do
    #   deploy_vm "#{stack_name}-lb", type: "load-balancer"
    # end
    tasks << Thread.new do
      deploy_vm "#{stack_name}1"
    end
    tasks << Thread.new do
      deploy_vm "#{stack_name}2"
    end
    tasks.map &:join
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
    # tasks << Thread.new do
    #   delete_vm name: "#{stack_name}-lb", prompt: false
    # end
    tasks << Thread.new do
      delete_vm name: "#{stack_name}1", prompt: false
    end
    tasks << Thread.new do
      delete_vm name: "#{stack_name}2", prompt: false
    end
    tasks.map &:join
    puts "VMs deleted!"
  end

end
