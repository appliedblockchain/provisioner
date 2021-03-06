require 'yaml'
require 'bundler'
Bundler.require :default

R = Redis.new

ACCESS_TOKEN = ENV["DNSIMPLE_TOKEN"]
ACCOUNT_ID = 54212 # ab

class AccessTokenNotSet < StandardError; end

raise AccessTokenNotSet, "The Access Token is not currently set" unless ACCESS_TOKEN

DNS = Dnsimple::Client.new access_token: ACCESS_TOKEN

Minutes = -> { 60 }
CACHE_TIME = 6 * Minutes.()

# CACHE_OFF = true
CACHE_OFF = false

def cache(*keys, &block)
  return block.call if CACHE_OFF
  cache_key = keys.map{ |key| key.to_s }.join "_"
  if value = R.get(cache_key)
    value = YAML.load value
    value
  else
    result = block.call
    yaml = YAML.dump result
    R.setex cache_key, CACHE_TIME, yaml
    result
  end
end
