class LightsailDB # AWS RDS equivalent in lightsail

  # class << self

  def self.status
    new.status
  end

  def self.provision
    new.provision
  end

  # methods

  def provision
    # aws CLI command:
    # aws create-relational-database \
    #   --relational-database-name <value> \
    #   --relational-database-blueprint-id <value> \
    #   --relational-database-bundle-id <value> \
    #   --master-database-name <value> \
    #   --master-username <value>
    #
    # # (https://docs.aws.amazon.com/cli/latest/reference/lightsail/create-relational-database.html)
    #
    #
    # API request:
    #
    # # (CreateRelationalDatabase)
    # # LS (AWS Lightsail client library)

    project_name = "antani"
    LS.create_relational_database(
      :"relational-database-name":          "db_#{project_name}",
      :"relational-database-blueprint-id":  "mysql_8_0", # postgres_12 for postgres
      :"relational-database-bundle-id":     "micro_1_0",
      :"master-database-name":              "db_#{project_name}",
      :"master-username":                   project_name,
    )
    # # (https://docs.aws.amazon.com/lightsail/2016-11-28/api-reference/API_CreateRelationalDatabase.html)

    # notes: get blueprint
    # LS.get_relational_database_blueprints()
    # aws get_relational_database_blueprints ...

    "..."
    raise "TODO: implement"
  end

  def status
    # aws CLI command:
    # get-relational-database --relational-database-name
    # # (https://docs.aws.amazon.com/cli/latest/reference/lightsail/get-relational-database.html)
    #
    # API request:
    #
    # CreateRelationalDatabase
    # # (https://docs.aws.amazon.com/lightsail/2016-11-28/api-reference/API_CreateRelationalDatabase.html)

    "..."

    # TODO:
    # - get the status of readiness (it takes a long time, better poll)
  end

end


# Usage:
#
# LightsailDB.provision
