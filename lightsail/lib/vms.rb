module VMs

  ENV_DEFAULT = defined?(VM_ENV) ? VM_ENV : "dev"

  def deploy_vm(name, env: ENV_DEFAULT, type: "docker-node")
    avail_zone = if defined?(CURRENT_AVAIL_ZONE)
      Object.send :remove_const, "CURRENT_AVAIL_ZONE"
      "a" # AZ A
    else
      "b" # AZ B
    end

    begin
      resp = LS.create_instances({
        instance_names: [name], # required
        # TODO: change availability zone
        availability_zone: "eu-west-1#{avail_zone}", # required
        # blueprint_id "debian_9_5" (new AB stable) - for ubuntu: "ubuntu_16_04_2" (old AB stable), "ubuntu_18_04"
        blueprint_id: "debian_9_5",
        # "bundle_id" - lightsail instance sizes: micro_2_0 - 1 CPU (dev), medium_2_0 - 2 CPU (stag/prod), xlarge_2_0 - 4 CPU (perf)
        bundle_id: "medium_2_0",
        # user_data: "string", # apt-get -y update
        key_pair_name: "makevoid",
        tags: [
          {
            key: "Name",
            value: name,
          },
          {
            key: "stack",
            value: name,
          },
          {
            key: "env",
            value: env,
          },
          {
            key: "type",
            value: type,
          },
          {
            key: "stack-type",
            value: "docker-swarm",
          },
        ],
      })
    rescue Aws::Lightsail::Errors::InvalidInputException => err
      error_and_exit message: "VM probably already exists", error: err
    end

    puts "VM Deployment - #{name.inspect}"
    puts "Result:"
    puts "#{resp}\n"
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
