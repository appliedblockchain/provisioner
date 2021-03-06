require 'bundler'
Bundler.require :default
Thread.abort_on_exception = true

# config and utils
require_relative 'config'
require_relative 'lib/utils'
require_relative 'lib/cli_utils/help_cmd'
include Utils
include HelpCmd
# libs
require_relative 'lib/vms'
require_relative 'lib/vm_ports'
require_relative 'lib/load_bal'
# stacks
require_relative 'lib/stacks'

include VMs
include VMPorts
include LoadBal
include Stacks

AWS_REGION = ENV["AWS_REGION"] || 'eu-west-1'

Aws.config.update({
  region: AWS_REGION,
  credentials: Aws::SharedCredentials.new(profile_name: AWS_PROFILE_NAME)
})

# uses the aws-cli credentials
LS = Aws::Lightsail::Client.new
