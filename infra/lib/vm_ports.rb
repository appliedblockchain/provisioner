module VMPorts

  PORTS_DEFINITION_DEFAULT = {
    # note: 80 and 22 are open by default
    "2377": :tcp, # docker swarm - communication between the nodes
    "4789": :udp, # docker swarm - overlay network traffic (container ingress networking)
    "7946": :all, # docker swarm - container network discovery
  }

  def open_ports(instance, ports_definition: PORTS_DEFINITION_DEFAULT)
    ports_definition.each do |port, proto|
      port  = port.to_s

      sleep 8 # unpredictable if aws lags this could fail :D, FIXME - create a status check via polling with the ruby aws sdk
      sleep 4 if instance[-1] == "2" # note: hack
      puts "opening #{port} - #{proto} on #{instance}"

      if proto == :all
        open_port instance: instance, port: port, proto: :tcp
        open_port instance: instance, port: port, proto: :udp
      else
        open_port instance: instance, port: port, proto: proto
      end
    end
  end

  def open_port(instance:, port:, proto:)
    retried = false
    begin
      proto = proto.to_s
      resp = LS.open_instance_public_ports({
        instance_name: instance,
        port_info: {
          from_port:  port,
          to_port:    port,
          protocol:   proto,
        },
      })
    rescue Aws::Lightsail::Errors::InvalidInputException => err
      raise err
      unless retried
        open_ports_retry_before_hook # note: slow
        retried = true
        retry
      end
    end
  end

  def open_ports_retry_before_hook
    puts "rertying - port #{port} - #{proto} on #{instance}"
    sleep 30
  end

end
