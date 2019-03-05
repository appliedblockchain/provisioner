require 'dnsimple'

ACCESS_TOKEN = ENV["ACCESS_TOKEN"]

class AccessTokenNotSet < StandardException; end

raise AccessTokenNotSet, "The Access Token is not currently set" unless ACCESS_TOKEN

client = Dnsimple::Client.new access_token: ACCESS_TOKEN

resp = client.identity.whoami

puts resp
