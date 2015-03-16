require 'puppet'
require 'yaml'
require 'socket'

begin
  require 'influxdb'
rescue LoadError => e
  Puppet.info "You need the `influxdb` gem to use the InfluxDB report"
end

Puppet::Reports.register_report(:influxdb) do

  configfile = File.join([File.dirname(Puppet.settings[:config]), "influxdb.yaml"])
  raise(Puppet::ParseError, "InfluxDB report config file #{configfile} not readable") unless File.exist?(configfile)
  config = YAML.load_file(configfile)
  INFLUXDB_SERVER = config[:influxdb_server]
  INFLUXDB_PORT = config[:influxdb_port]
  INFLUXDB_USER = config[:influxdb_username]
  INFLUXDB_PASS = config[:influxdb_password]
  INFLUXDB_DB = config[:influxdb_database]

  desc <<-DESC
  Send notification of failed reports to an InfluxDB server.
  DESC

  def process
    # InfluxDB needs the IP Address of the system
    addr_info = Socket.getaddrinfo("#{self.host}", nil)
    Puppet.debug "Sending status for #{self.host} to InfluxDB server at #{INFLUXDB_SERVER}"
    influxdb = InfluxDB::Client.new("#{INFLUXDB_DB}", {
      :host => INFLUXDB_SERVER,
      :username => INFLUXDB_USER,
      :password => INFLUXDB_PASS,
      :port => INFLUXDB_PORT,
      :server => INFLUXDB_SERVER,
      :retry => 4
    })
    self.metrics.each { |metric,data|
      data.values.each { |val| 
        key = "puppet #{metric} #{val[1]}".downcase.tr(" ", "_")
        value = val[2].to_f

        data = {
          :host => "#{self.host}",
          :value => value,
          :ip => addr_info[0][3] # array of array's Really!
        }
        influxdb.write_point(key, data)
      }
    }
  end
end
