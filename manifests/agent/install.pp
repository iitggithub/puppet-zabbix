# PRIVATE CLASS: do not call directly
class zabbix::agent::install inherits zabbix::agent {
  if $zabbix::agent::package_manage {
    if $zabbix::agent::package_source {
      # Must be a windows/OSX package...
      if $zabbix::agent::package_source =~ /(.*\/)(.*\.(msi|dmg|exe|pkg))/ {
        $_package_name = $2
      }
    } else {
      $_package_name = $zabbix::agent::package_name
    }

    package { $_package_name:
      ensure            => $zabbix::agent::package_ensure,
      provider          => $zabbix::agent::package_provider,
      source            => $zabbix::agent::package_source,
      install_options   => $zabbix::agent::install_options,
      uninstall_options => $zabbix::agent::uninstall_options,
    }
  }
}
