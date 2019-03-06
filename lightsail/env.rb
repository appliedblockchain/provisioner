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

# note: for now just include everything in the main namespace (TODO refactor)

include VMs
include VMPorts
include LoadBal
include Stacks

# uses the aws-cli credentials
LS = Aws::Lightsail::Client.new
