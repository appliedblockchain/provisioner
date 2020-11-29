module SetupDockerSwarm

  include SSHUtils

  def reportStatus(status:, joinToken:, joinResponse:)
    status = sshCmd.(IP_A, "docker node ls", :open3)
    puts "Token response: #{joinToken.inspect}\n"
    puts "Join response: #{joinResponse.inspect}\n"
    puts "Status: #{status.strip}\n"
  end

  ReportStatus = -> (status, joinToken, joinResponse) {
    reportStatus status: status, joinToken: joinToken, joinResponse: joinResponse
  }

  Setup = -> {
    return unless IP_B # don't setup swarm if there's only a single VM (ip)

    sshCmd = SSHUtils::SSHCmd
    # status = sshCmd.(IP_A, "docker swarm init")
    status = nil
    joinTokenCommand = sshCmd.(IP_A, "docker swarm join-token manager | grep docker", :open3, :no_abort)
    joinTokenCommand.strip!
    joinResponse = sshCmd.(IP_B, joinTokenCommand)

    ReportStatus.(status, joinTokenCommand, joinResponse)
  }

end
