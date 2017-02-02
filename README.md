# Overview

The Zabbix module installs, configures and manages Zabbix Agents, Servers, Proxies and Java Gateways.

# Module Description

The Zabbix module handles installing, configuring, and running Zabbix components across a range of operating systems and distributions.

# Supported Versions

Git branch | Tag name
---------- |---------
master     | latest
3.2        | 3.2

# Agent

## Usage Notes

The parameter names are identical to the those found in zabbix_agentd.conf, they're just all in lower case. There is one exception though:

Alias Parameter is now zalias as seen above because 'alias' is a built in variable.

## Getting Started

include '::zabbix::agent' is enough to get you up and running on anything other than Windows or Mac. If you wish to pass in parameters specifying which servers to use, then:

```
Class { '::zabbix::agent':
  server               => ['zabbix.a.example.com', 'zabbix.b.example.com'],
  pidfile              => '/var/run/zabbix/zabbix_agentd.pid',
  logfile              => '/var/log/zabbix/zabbix_agentd.log',
  logfilesize          => 100,
  enableremotecommands => true,
  logremotecommands    => true,
  timeout              => 30,
  zalias               => ['zabbix.userid:vfs.file.regexp[/etc/passwd,^zabbix:.:([0-9]+),,,,\1]'],
}
```

## Windows Zabbix Agent

The windows package manager (windows) requires some extra parameters in order to install and manage the Zabbix agent. Most of the information pertaining to how these options work can be found here: https://docs.puppet.com/puppet/latest/type.html#package-provider-windows

We suggest using the latest installer from http://www.suiviperf.com/zabbix/index.php. The package_source value must be a path to the installer found locally on the target host, a mapped drives on the target, or a UNC path.

You'll need to set (at a minimum) package_source and install_options like so:

```
Class { '::zabbix::agent':
  server               => ['zabbix.a.example.com', 'zabbix.b.example.com'],
  pidfile              => '/var/run/zabbix/zabbix_agentd.pid',
  logfile              => '/var/log/zabbix/zabbix_agentd.log',
  logfilesize          => 100,
  enableremotecommands => true,
  logremotecommands    => true,
  timeout              => 30,
  zalias               => ['zabbix.userid:vfs.file.regexp[/etc/passwd,^zabbix:.:([0-9]+),,,,\1]'],
  package_source       => '\\zabbix.a.example.com\installer\zabbix-agentd.msi',
  install_options      => '/server=zabbix.a.example.com /lport=10050 /rmtcmd=1 /serveractive=zabbix.a.example.com:10051 /S /D=C:\Program Files\Zabbix',
}
```

## Mac Zabbix Agent

The mac package manager (pkgdmg) requires some extra parameters in order to install and manage the Zabbix agent. Most of the information pertaining to how these options work can be found here: https://docs.puppet.com/puppet/latest/type.html#package-provider-appdmg

As per the package provider appdmg documentation, the package_source value must be set to either a local disk path or an HTTP, HTTPS, or FTP URL to the package.

You MUST set package_source or it'll probably break.

```
Class { '::zabbix::agent':
  server               => ['zabbix.a.example.com', 'zabbix.b.example.com'],
  pidfile              => '/var/run/zabbix/zabbix_agentd.pid',
  logfile              => '/var/log/zabbix/zabbix_agentd.log',
  logfilesize          => 100,
  enableremotecommands => true,
  logremotecommands    => true,
  timeout              => 30,
  zalias               => ['zabbix.userid:vfs.file.regexp[/etc/passwd,^zabbix:.:([0-9]+),,,,\1]'],
  package_source       => 'ftp://zabbix.a.example.com/zabbix-agentd.pkg',
}
```

## Zabbix Agent Configure Options

Since the configuration file has been stripped completely, You'll find a breakdown of all of the parameters here:


# Server

Coming soon...

# Proxy

Coming soon...

# Java Gateway

Coming soon...
