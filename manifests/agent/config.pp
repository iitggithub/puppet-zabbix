# PRIVATE CLASS: do not call directly
class zabbix::agent::config inherits zabbix::agent {

  $_tlsconnect     = $zabbix::agent::tlsconnect
  $_tlsaccept      = $zabbix::agent::tlsaccept
  $_tlscertfile    = $zabbix::agent::tlscertfile
  $_tlspskidentity = $zabbix::agent::tlspskidentity
  $_tlspskfile     = $zabbix::agent::tlspskfile
  $_osfamily       = downcase($::facts['osfamily'])

  if ($_tlsconnect) and (!$_tlscertfile and (!$_tlspskidentity and !$_tlspskfile)) {
    fail('TLSConnect is enabled but TLSCertFile is not defined \
         and neither is TLSPSKIdentity and TLSPSKFile.')
  }

  if ($_tlsaccept) and (!$_tlscertfile and (!$_tlspskidentity and !$_tlspskfile)) {
     fail('TLSConnect is enabled but TLSCertFile is not defined',
          ' and neither is TLSPSKIdentity and TLSPSKFile.')
  }

  include "zabbix::agent::config::${_osfamily}"
}
