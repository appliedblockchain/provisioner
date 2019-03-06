require 'yaml'
require 'bundler'
Bundler.require :default

R = Redis.new

ACCESS_TOKEN = ENV["DNSIMPLE_TOKEN"]
# ACCOUNT_ID = 1447 # makevoid
ACCOUNT_ID = 54212 # appliedblockchain

class AccessTokenNotSet < StandardError; end

raise AccessTokenNotSet, "The Access Token is not currently set" unless ACCESS_TOKEN

DNS = Dnsimple::Client.new access_token: ACCESS_TOKEN

# resp = (DNS.domains.methods - Object.methods).sort
# DNS.domains.list(1447)
# puts resp

Minutes = -> { 60 }

CACHE_TIME = 6 * Minutes.()

# CACHE_OFF = true
CACHE_OFF = false

# R.flushdb

def cache(*keys, &block)
  return block.call if CACHE_OFF
  cache_key = keys.map{ |key| key.to_s }.join "_"
  if value = R.get(cache_key)
    value = YAML.load value
    # puts "got value: #{value.inspect}"
    value
  else
    result = block.call
    # puts "put value: #{value.inspect}"
    yaml = YAML.dump result
    R.setex cache_key, CACHE_TIME, yaml
    result
  end
end
