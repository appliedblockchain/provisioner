require_relative 'dns-env'

Domains = -> {
  cache(:domains) {
    DNS.domains.all_domains(ACCOUNT_ID).data
  }
}

Zones = -> () {
  cache(:zones) {
    DNS.zones.all_zones(ACCOUNT_ID).data
  }
}

Records = -> (domain) {
  cache(:records, domain) {
    DNS.zones.all_zone_records(ACCOUNT_ID, domain).data
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
  resp = DNS.zones.create_zone_record(ACCOUNT_ID, domain, name: name, type: type, content: content)
  puts resp.inspect
  puts "created!"
}

ListAll.()

domain, type, name, content = "abaub.io", "A", "test", "127.0.0.1"
CreateRecord.(domain, type, name, content)
