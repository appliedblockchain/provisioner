require 'yaml'
require 'bundler'
Bundler.require :default

R = Redis.new

ACCESS_TOKEN = ENV["DNSIMPLE_TOKEN"]
# ACCOUNT_ID = 1447 # makevoid
ACCOUNT_ID = 54212 # appliedblockchain

class AccessTokenNotSet < StandardError; end

raise AccessTokenNotSet, "The Access Token is not currently set" unless ACCESS_TOKEN

client = Dnsimple::Client.new access_token: ACCESS_TOKEN

# resp = (client.domains.methods - Object.methods).sort
# client.domains.list(1447)
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

Domains = -> {
  cache(:domains) {
    client.domains.all_domains(ACCOUNT_ID).data
  }
}

Zones = -> () {
  cache(:zones) {
    client.zones.all_zones(ACCOUNT_ID).data
  }
}

Records = -> (domain) {
  cache(:records, domain) {
    client.zones.all_zone_records(ACCOUNT_ID, domain).data
  }
}

ListAll = -> {
  zones_list = Zones.()
  domains = zones_list.map &:name
  zones = {}
  domains.map do |domain|
    zones[domain] = zones_list.find{ |zone| zone.name == domain }
  end

  for domain in domains
    puts "Domain: #{domain}"
    zone = zones.fetch domain
    puts "  #{zone.inspect}\n"
    records = Records.(domain)
    for record in records
      # puts "  #{record.inspect}\n"
      name = record.name
      name = "." if record.name == ""
      type = record.type.ljust 3, ' '
      puts "  #{type} - #{name} ⇒ #{record.content}\n"
    end
    puts "\n"
  end
  puts "---\n"
}

CreateRecord = -> (domain, type, name, content) {
  puts "Create Record: domain: #{domain.inspect}, type: #{type.inspect}, name: #{name.inspect}, content: #{content.inspect}"
  resp = client.zones.create_zone_record(ACCOUNT_ID, domain, name: name, type: type, content: content)
  puts resp.inspect
  puts "created!"
}

ListAll.()

domain, type, name, content = "abaub.io", "A", "test", "127.0.0.1"
CreateRecord.(domain, type, name, content)
