module VMs

  ENV_DEFAULT = defined?(VM_ENV) ? VM_ENV : "dev"

  def deploy_vm(name, env: ENV_DEFAULT, type: "docker-node")
    avail_zone = if DB["CURRENT_AVAIL_ZONE"] == "a" ? "a" : "b"
    DB["CURRENT_AVAIL_ZONE"] = "b"

    tags = virtual_machine_tags(name: name, env: env, type: type)

    begin
      resp = LS.create_instances({
        instance_names: [name], # required
        availability_zone: "#{AWS_REGION}#{avail_zone}", # required
        blueprint_id: "debian_9_5",
        bundle_id: vm_size_bundle_id,
        key_pair_name: KEY_PAIR_NAME,
        # user_data: "string", # add a custom script like `apt -y update && apt -y install vim git curl ...`
        tags: tags,
      })
    rescue Aws::Lightsail::Errors::InvalidInputException => err
      error_and_exit message: "VM probably already exists", error: err
    end

    puts "Status: #{resp[:operations].map{ |op| op[:status].inspect }.join ", "}"
  end

  def vms
    LS.get_instances()
  end

  def vms_list
    resp = vms
    puts "Instances:\n---"
    for instance in resp[:instances].sort_by{ |inst| inst[:name] }
      puts "Name: #{instance[:name]}"
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
  end

  def vm_size_bundle_id
    # "bundle_id" - lightsail instance sizes:
    #  - micro_2_0  - 1 CPU (dev)
    #  - medium_2_0 - 2 CPU (stag/prod)
    #  - xlarge_2_0 - 4 CPU (perf)
    case VM_SIZE
    when "medium", "default", "staging" then "medium_2_0"
    when "big", "production" then "xlarge_2_0"
    when "small", "dev" then "micro_2_0"
    end
  end

  def virtual_machine_tags(name:, env:, type:)
    [
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
    ]
  end

end
