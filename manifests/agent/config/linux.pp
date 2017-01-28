# PRIVATE CLASS: do not call directly
class zabbix::agent::config::linux inherits zabbix::agent::config {

  $_service_name = $zabbix::agent::service_name
  $_logFile      = $zabbix::agent::logFile
  $_pidFile      = $zabbix::agent::pidFile

  file { '/etc/zabbix':
    ensure => directory,
    mode   => '0755',
    owner  => 0,
    group  => 0,
  }

  file { '/etc/zabbix/zabbix_agentd.d':
    ensure  => directory,
    mode    => '0755',
    owner   => '0',
    group   => '0',
  }

  file { '/etc/zabbix/zabbix_agentd.conf':
    ensure  => file,
    mode    => '0644',
    owner   => 0,
    group   => 0,
    content => template('zabbix/linux_zabbix_agentd.erb'),
    notify  => Service[$_service_name],
  }

  if $_logFile {
    # Rip out the path to the Log file
    if $_logFile =~ /(.*\/)(.*\.log)/ {
      $_log_path = $1
    }
    file { $_log_path:
      ensure => directory,
      mode   => '0755',
      owner  => 'zabbix',
      group  => 'zabbix',
    }
    file { $_logFile:
      ensure  => 'file',
      mode    => '0644',
      owner   => 'zabbix',
      group   => 'zabbix',
      require => File[$_log_path],
    }
  }

  if $_pidFile {
    # Rip out the path to the PID file
    if $_pidFile =~ /(.*\/)(.*\.pid)/ {
      $_pid_path = $1
    }
    file { $_pid_path:
      ensure => directory,
      mode   => '0755',
      owner  => 'zabbix',
      group  => 'zabbix',
    }

    file { $_pidFile:
      ensure  => 'file',
      owner   => 'zabbix',
      group   => 'zabbix',
      require => File[$_pid_path],
    }
  }
}
