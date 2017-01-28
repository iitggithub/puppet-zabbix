# PRIVATE CLASS: do not call directly
class zabbix::agent::service inherits zabbix::agent {
  if $zabbix::agent::_service_manage {
    service { $zabbix::agent::_service_name:
      ensure     => $zabbix::agent::_service_ensure,
      enable     => $zabbix::agent::_service_enable,
      hasstatus  => $zabbix::agent::_service_hasstatus,
      hasrestart => $zabbix::agent::_service_hasrestart,
    }
  }
}
