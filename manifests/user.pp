# Creates a zabbix user/group
class zabbix::user inherits zabbix {

  user { 'zabbix':
    ensure     => present,
    comment    => 'Zabbix Monitoring System',
    managehome => true,
    gid        => 'zabbix',
    shell      => '/bin/bash',
    require    => Group['zabbix'],
  }

  group { 'zabbix':
    ensure => present,
    name   => 'zabbix',
  }
}
