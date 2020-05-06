module HelpCmd

  def display_help
    puts "Help:\n---\n
-------------
  Commands:
-------------

  - rake CMD=provision  - deploys a new infrastructure stack
  - rake CMD=deploy     - alias for provision
  - rake CMD=destroy    - deletes a stack (note: with great power comes great responsibility :D)
  - rake CMD=list       - lists the VMs and load balancers
  - rake CMD=help       - displays this message

  Select the stack via STACK= (e.g. 'STACK=launchpad1' - 'STACK=launchpad1 CMD=list rake')

  Other examples:

    # change stack name
    rake STACK_NAME=launchpad-ssr CMD=provision

    # change VM size (2vcpu is the default one, big provisions a 4vcpu)
    rake VM_SIZE=big CMD=provision

    # change the aws credentials profile
    rake AWS_PROFILE_NAME=aws-credentials-name CMD=provision

    # change the key pair name
    rake KEY_PAIR_NAME=your-username CMD=provision

    # usually you want to run deploy with these options command
    rake STACK=stack-name AWS_PROFILE_NAME=aws-credentials-name KEY_PAIR_NAME=your-username CMD=provision

    # protip: create an env file to source with all your credentials and then just run `source env.sh && rake CMD=provision`
  \n\n

   Scroll to the top for a list of commands

  \n\n
-------------
  ENV:
-------------

Your environment variables:

STACK_NAME: #{STACK_NAME}
AWS_PROFILE_NAME: #{AWS_PROFILE_NAME}
KEY_PAIR_NAME: #{KEY_PAIR_NAME}
VM_SIZE: #{VM_SIZE}
AWS_REGION: #{AWS_REGION}
\n\n"
  end

end
