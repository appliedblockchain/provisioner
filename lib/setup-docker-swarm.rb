module SetupDockerSwarm
  include SSHUtils

  Setup = -> {
    sshCmd  = SSHCmd
    sshCmdR = SSHCmdR
    status  = sshCmd.(IP_A, "docker node ls", nil)
    return unless IP_B
    puts "Swarm status: #{status}"

    status = sshCmd.(IP_A, "docker swarm init", nil)
    joinTokenCommand = sshCmdR.(IP_A, "docker swarm join-token manager")
    joinResponse = sshCmd.(IP_B, joinTokenCommand, :open3)

    ReportStatus.(status, joinTokenCommand, joinResponse)
  }

  ReportStatus = -> (status, joinToken, joinResponse) {
    reportStatus status: status, joinToken: joinToken, joinResponse: joinResponse
  }

  def reportStatus(status:, joinToken:, joinResponse:)
    puts "Join response: #{joinResponse.inspect}\n"
    puts "Join token response: #{joinToken.inspect}\n"
    puts "Status: #{status}\n"
  end

end
