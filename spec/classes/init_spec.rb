require 'spec_helper'
describe 'influxdb_reporter' do

  context 'with defaults for all parameters' do
    it { should contain_class('influxdb_reporter') }
  end
end
