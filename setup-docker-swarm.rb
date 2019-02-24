module SetupDockerSwarm

  Setup = -> {
    status = sshCmd.(IP_A, "docker node ls")
    puts "Swarm status"

    status = sshCmd.(IP_A, "docker swarm init")
    joinTokenCommand = sshCmd.(IP_A, "docker swarm join-token  manager")
    joinResponse = sshCmd.(IP_B, joinTokenCommand)

    reportStatus status: status, joinToken: joinToken, joinResponse: joinResponse
  }

end
