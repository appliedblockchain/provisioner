module LoadBalancerConfig
  Replace = -> (string, varName, value) {
    string.gsub(/<#{varName}>/, value)
  }

  CompileTpl = -> (template, serverName, ips) {
    ips.each_with_index do |ip, idx|
      template = Replace.(template, "IP_#{idx}", ip)
    end

    Replace.(template, "SERVER_NAME", serverName)
  }

  LoadLBConfig = -> (path) {
    serverName = "antani.com"
    ip1 = "127.0.0.1"
    ip2 = "127.0.1.1"
    ips = [ ip1, ip2 ]
    # TODO: load config
    # config = File.read config

    template = File.read path
    contents = CompileTpl.(template, serverName, ips)

    File.open("#{path}.conf", "w"){ |f| f.write contents }
    puts "'#{path}.conf' written"
  }
end

if __FILE__ == $0
  include LoadBalancerConfig
  puts LoadLBConfig.("templates/01-default-lb")
end
