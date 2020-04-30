# create and manage load balancers

module LoadBal

  # TODO: refactor, deduplicate
  ENV_DEFAULT = defined?(VM_ENV) ? VM_ENV : "dev"

  def deploy_load_bal(stack_name, env: ENV_DEFAULT)
    puts "LB Deployment - #{stack_name.inspect}"
    tags = load_balancer_tags stack_name: stack_name, env: env

    begin
      resp = LS.create_load_balancer({
        load_balancer_name: "#{stack_name}-lb",
        instance_port: 80,  # default port
        health_check_path: HEALTHCHECK_PATH,
        certificate_name: "ab-dev",
        certificate_domain_name: "appb.ch",
        certificate_alternative_names: ["subdomain.appb.ch"],
        tags: tags,
      })
    # TODO: rescue specific exception - in case the LB is already created, remove generic rescue
    rescue Exception => err
      raise err
    end

    puts "Status: #{resp[:operations].map{ |op| op[:status].inspect }.join ", "}"
  end

  def load_balancer_tags(stack_name:, env:)
    [
      {
        key: "Name",
        value: "#{stack_name}-lb",
      },
      {
        key: "stack",
        value: stack_name,
      },
      {
        key: "env",
        value: env,
      },
      {
        key: "type",
        value: "load-balancer",
      },
    ]
  end

end
