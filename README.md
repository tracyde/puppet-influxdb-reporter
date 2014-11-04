influxdb_reporter
==============

[![Puppet Forge](http://img.shields.io/puppetforge/v/tracyde/influxdb_reporter.svg)](https://forge.puppetlabs.com/tracyde/influxdb_reporter)

Description
-----------

A Puppet report processor for sending metrics to an [InfluxDB](http://influxdb.com/) server.

Requirements
------------

* `influxdb` gem
* `Puppet`
* An [InfluxDB](http://influxdb.com/) server

Installation & Usage
--------------------

1.  Install the `influxdb` gem on your Puppet master

        $ sudo gem install influxdb

2.  Install tracyde-influxdb_reporter as a module in your Puppet master's module
    path.

3.  Update the `influxdb_server`, `influxdb_port`, `influxdb_username`, `influxdb_password`, 
    and `influxdb_database` variables in the `influxdb.yaml` file with your InfluxDB server 
    IP and port and copy the file to `/etc/puppet/`. An example file is included.

4.  Enable pluginsync and reports on your master and clients in `puppet.conf`

        [master]
        report = true
        reports = influxdb
        pluginsync = true
        [agent]
        report = true
        pluginsync = true

5.  Run the Puppet client and sync the report as a plugin

Author
------

Derek Tracy <tracyde@gmail.com>

License
-------

    Author:: Derek Tracy (<tracyde@gmail.com>)
    Copyright:: Copyright (c) 2014 Derek Tracy
    License:: Apache License, Version 2.0

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
