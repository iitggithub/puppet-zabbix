require 'spec_helper_acceptance'

case fact('osfamily')
when 'Windows'
  config = '%PROGRAMFILES(x86)%\zabbix\etc'
  line = '# This is a configuration file for Zabbix agent service (Windows)'
when 'Darwin'
  config = '/etc/zabbix/zabbix_agentd.conf'
  line = '# This is a configuration file for Zabbix agent service (Darwin)'
when 'Linux'
  config = '/etc/zabbix/zabbix_agentd.conf'
  line = '# This is a configuration file for Zabbix agent daemon (Unix)'
end

describe 'zabbix::agent::config class', :unless => UNSUPPORTED_PLATFORMS.include?(fact('osfamily')) do
  it 'sets up zabbix_agentd.conf' do
    apply_manifest(%{
      class { 'zabbix::agent': }
    }, :catch_failures => true)
  end

  describe file("#{config}") do
    it { should be_file }
    its(:content) { should match line }
  end
end
