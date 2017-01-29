# PRIVATE CLASS: do not call directly
class zabbix::agent::config inherits zabbix::agent {

  if ($zabbix::agent::tlsconnect) and (!$zabbix::agent::tlscertfile and 
     (!$zabbix::agent::tlspskidentity and !$zabbix::agent::tlspskfile)) {
     fail('TLSConnect is enabled but TLSCertFile is not defined and neither is TLSPSKIdentity or TLSPSKFile.')
  }

  if ($zabbix::agent::tlsaccept) and (!$zabbix::agent::tlscertfile and
     (!$zabbix::agent::tlspskidentity and !$zabbix::agent::tlspskfile)) {
     fail('TLSConnect is enabled but TLSCertFile is not defined and neither is TLSPSKIdentity or TLSPSKFile.')
  }
 
  $config = "zabbix::agent::config::$facts[osfamily]"

  include $config
}
