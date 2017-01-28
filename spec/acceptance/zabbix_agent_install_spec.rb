require 'spec_helper_acceptance'

case fact('osfamily')
when 'Windows'
  source = ''
  install_options = ['']
  uninstall_options = ['']
when 'Darwin'
  source = ''
else
  packagename = 'zabbix-agent'
  servicename = 'zabbix-agent'
end

describe 'zabbix::agent::install class', :unless => UNSUPPORTED_PLATFORMS.include?(fact('osfamily')) do
  it 'installs the package' do
    apply_manifest(%{
      class { 'zabbix::agent': }
    }, :catch_failures => true)
  end

  Array(packagename).each do |package|
    describe package(package) do
      it { should be_installed }
    end
  end
end
