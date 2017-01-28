# PRIVATE CLASS: do not call directly
class zabbix::agent::config inherits zabbix::agent {

  if ($zabbix::agent::TLSConnect) and (!$zabbix::agent::TLSCertFile and 
     (!$zabbix::agent::TLSPSKIdentity and !$zabbix::agent::TLSPSKFile)) {
     fail('TLSConnect is enabled but TLSCertFile is not defined and neither is TLSPSKIdentity or TLSPSKFile.')
  }

  if ($zabbix::agent::TLSAccept) and (!$zabbix::agent::TLSCertFile and
     (!$zabbix::agent::TLSPSKIdentity and !$zabbix::agent::TLSPSKFile)) {
     fail('TLSConnect is enabled but TLSCertFile is not defined and neither is TLSPSKIdentity or TLSPSKFile.')
  }

  include zabbix::agent::config::${facts['osfamily']}
}
