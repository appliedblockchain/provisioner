require 'bundler'
Bundler.require :default
Thread.abort_on_exception = true

require_relative 'config'
require_relative 'lib/utils'
require_relative 'lib/vms'
require_relative 'lib/vm_ports'
require_relative 'lib/stacks'

# note: for now just include everything in the main namespace (TODO refactor)

include Utils
include VMs
include VMPorts
include Stacks

# uses the aws-cli credentials
LS = Aws::Lightsail::Client.new
