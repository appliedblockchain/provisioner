

module SetupDockerSwarm

  include SSHUtils

  def reportStatus(status:, joinToken:, joinResponse:)
    puts "Join response: #{joinResponse.inspect}\n"
    puts "Join token response: #{joinToken.inspect}\n"
    puts "Status: #{status}\n"
  end

  Setup = -> {
    sshCmd = SSHUtils::SSHCmd
    status = sshCmd.(IP_A, "docker node ls")
    puts "Swarm status"

    status = sshCmd.(IP_A, "docker swarm init")
    joinTokenCommand = sshCmd.(IP_A, "docker swarm join-token  manager")
    return unless defined?(IP_B)
    joinResponse = sshCmd.(IP_B, joinTokenCommand, open3: true)

    reportStatus status: status, joinToken: joinTokenCommand, joinResponse: joinResponse
  }

end
