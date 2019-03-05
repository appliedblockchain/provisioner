module VMs

  def deploy_vm(name, env: (defined?(VM_ENV) ? VM_ENV : "dev"), type: "docker-node")
    begin
      resp = LS.create_instances({
        instance_names: [name], # required
        availability_zone: "eu-west-1a", # required
        blueprint_id: "debian_9_5", # ubuntu: ubuntu_16_04_2, ubuntu_18_04
        bundle_id: "micro_1_0",
        # user_data: "string", # apt-get -y update
        key_pair_name: "makevoid",
        tags: [
          {
            key: "env",
            value: env,
          },
          {
            key: "stack",
            value: "docker-swarm",
          },
          {
            key: "type",
            value: type,
          },
        ],
      })
    rescue Aws::Lightsail::Errors::InvalidInputException => err
      error_and_exit message: "VM probably already exists", error: err
    end

    puts "VM Deployment - #{name.inspect}"
    puts "Result:"
    puts "#{resp}\n"
    # puts resp.inspect
  end

  def vms
    LS.get_instances()

    # TODO: use pages
    #
    # resp = LS.get_instances({
    #   page_token: "string",
    # })
  end

  def vms_list
    resp = vms
    puts "Instances:\n---"
    for instance in resp[:instances].sort_by{ |inst| inst[:name] }
      puts "Name: #{instance[:name]}"
      # puts instance[:tags].inspect
    end
    puts
  end

  def delete_vm(name:, prompt: true)
    puts "Deleting VM - #{name.inspect}"
    puts "Are you sure? Hit Ctrl-C to terminate!"
    gets if prompt
    puts "deleting..."

    begin
      resp = LS.delete_instance({
        instance_name: name,
      })
    rescue Aws::Lightsail::Errors::NotFoundException => err
      error_and_exit message: "Cannot delete a VM that doesn't exist", error: err
    end

    puts "Status: #{resp[:operations].map{ |op| op[:status].inspect }.join ", "}"
    # puts resp.inspect
  end

end
