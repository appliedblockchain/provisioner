module SetupDockerSwarm

  include SSHUtils

  def reportStatus(status:, joinToken:, joinResponse:)
    puts "Join response: #{joinResponse.inspect}\n"
    puts "Join token response: #{joinToken.inspect}\n"
    puts "Status: #{status}\n"
  end

  ReportStatus = -> (status, joinToken, joinResponse) {
    reportStatus status: status, joinToken: joinToken, joinResponse: joinResponse
  }

  Setup = -> {
    sshCmd = SSHUtils::SSHCmd
    status = sshCmd.(IP_A, "docker node ls", :open3)

    return unless IP_B
    puts "Swarm status: #{status}"

    status = sshCmd.(IP_A, "docker swarm init", nil)
    joinTokenCommand = sshCmd.(IP_A, "docker swarm join-token manager", :open3)
    joinResponse = sshCmd.(IP_B, joinTokenCommand, nil)

    ReportStatus.(status, joinTokenCommand, joinResponse)
  }

end
