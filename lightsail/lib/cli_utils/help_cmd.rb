module HelpCmd

  def display_help
    puts "Help:\n---\n
-------------
  Commands:
-------------

  - CMD=provision rake - deploys a new infrastructure stack
  - CMD=deploy rake - alias for provision
  - CMD=destroy rake - destroys a stack (note: with great power comes great responsibility :D)
  - CMD=list rake - lists the VMs and load balancers
  - CMD=help rake

  Select the stack via STACK= (e.g. 'STACK=launchpad1' - 'STACK=launchpad1 CMD=list rake')
  \n\n"
  end

end
