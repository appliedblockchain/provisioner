module VMPorts

  PORTS_DEFINITION_DEFAULT = {
    # note: 80 and 22 are open by default
    "2377": :tcp, # docker swarm - communication between the nodes
    "3000": :tcp, # app
    "4789": :udp, # docker swarm - overlay network traffic (container ingress networking)
    "7946": :tcp, # docker swarm - container network discovery
    "7946": :udp, # "
    # "7946": :all, # docker swarm - container network discovery
    "9000": :tcp, # explorer
  }

  def open_ports(instance, ports_definition: PORTS_DEFINITION_DEFAULT)

    ports_definition.each do |port, proto|
      port  = port.to_s
      proto = proto.to_s

      sleep 3
      puts "opening #{port} - #{proto} on #{instance}"

      retried = false
      begin
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
          puts "rertying - port #{port} - #{proto} on #{instance}"
          sleep 10
          retried = true
          retry
        end
      end
    end
  end

end
