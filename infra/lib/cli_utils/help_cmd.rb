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

  Other examples:

    # change stack name
    STACK_NAME=launchpad-ssr CMD=provision rake

    # change VM size (2vcpu is the default one, big provisions a 4vcpu)
    VM_SIZE=big CMD=provision rake

    # change the aws credentials profile
    AWS_PROFILE_NAME=aws-credentials-name CMD=provision rake

    # change the key pair name
    KEY_PAIR_NAME=your-username CMD=provision rake

    # usually you want to run deploy with these options command
    STACK=stack-name AWS_PROFILE_NAME=aws-credentials-name KEY_PAIR_NAME=your-username CMD=provision rake

    # protip: create an env file to source with all your credentials and then just run `source env.sh && CMD=provision rake`
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
