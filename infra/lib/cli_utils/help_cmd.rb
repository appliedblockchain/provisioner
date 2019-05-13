module HelpCmd

  def display_help
    puts "Help:\n---\n
-------------
  Commands:
-------------

  - rake CMD=provision  - deploys a new infrastructure stack
  - rake CMD=deploy  - alias for provision
  - rake CMD=destroy  - destroys a stack (note: with great power comes great responsibility :D)
  - rake CMD=list  - lists the VMs and load balancers
  - rake CMD=help

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
-------------
  ENV:
-------------

STACK: #{ENV["STACK"]}
AWS_PROFILE_NAME: #{ENV["AWS_PROFILE_NAME"]}
KEY_PAIR_NAME: #{ENV["KEY_PAIR_NAME"]}
VM_SIZE: #{ENV["VM_SIZE"]}
AWS_REGION: #{ENV["AWS_REGION"] || "#{AWS_REGION} (default)"}
\n\n"
  end

end
