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

```
# This is a configuration file for Zabbix agent daemon (Unix)
# To get more information about Zabbix, visit http://www.zabbix.com

############ GENERAL PARAMETERS #################

### Option: PidFile
#	Name of PID file.
#
# Mandatory: no
# Default:
# PidFile=/tmp/zabbix_agentd.pid

### Option: LogType
#	Specifies where log messages are written to:
#		system  - syslog
#		file    - file specified with LogFile parameter
#		console - standard output
#
# Mandatory: no
# Default:
# LogType=file

### Option: LogFile
#	Log file name for LogType 'file' parameter.
#
# Mandatory: no
# Default:
# LogFile=

### Option: LogFileSize
#	Maximum size of log file in MB.
#	0 - disable automatic log rotation.
#
# Mandatory: no
# Range: 0-1024
# Default:
# LogFileSize=1

### Option: DebugLevel
#	Specifies debug level:
#	0 - basic information about starting and stopping of Zabbix processes
#	1 - critical information
#	2 - error information
#	3 - warnings
#	4 - for debugging (produces lots of information)
#	5 - extended debugging (produces even more information)
#
# Mandatory: no
# Range: 0-5
# Default:
# DebugLevel=3

### Option: SourceIP
#	Source IP address for outgoing connections.
#
# Mandatory: no
# Default:
# SourceIP=

### Option: EnableRemoteCommands
#	Whether remote commands from Zabbix server are allowed.
#	0 - not allowed
#	1 - allowed
#
# Mandatory: no
# Default:
# EnableRemoteCommands=0

### Option: LogRemoteCommands
#	Enable logging of executed shell commands as warnings.
#	0 - disabled
#	1 - enabled
#
# Mandatory: no
# Default:
# LogRemoteCommands=0

##### Passive checks related

### Option: Server
#	List of comma delimited IP addresses (or hostnames) of Zabbix servers.
#	Incoming connections will be accepted only from the hosts listed here.
#	If IPv6 support is enabled then '127.0.0.1', '::127.0.0.1', '::ffff:127.0.0.1' are treated equally.
#
# Mandatory: no
# Default:
# Server=

### Option: ListenPort
#	Agent will listen on this port for connections from the server.
#
# Mandatory: no
# Range: 1024-32767
# Default:
# ListenPort=10050

### Option: ListenIP
#	List of comma delimited IP addresses that the agent should listen on.
#	First IP address is sent to Zabbix server if connecting to it to retrieve list of active checks.
#
# Mandatory: no
# Default:
# ListenIP=0.0.0.0

### Option: StartAgents
#	Number of pre-forked instances of zabbix_agentd that process passive checks.
#	If set to 0, disables passive checks and the agent will not listen on any TCP port.
#
# Mandatory: no
# Range: 0-100
# Default:
# StartAgents=3

##### Active checks related

### Option: ServerActive
#	List of comma delimited IP:port (or hostname:port) pairs of Zabbix servers for active checks.
#	If port is not specified, default port is used.
#	IPv6 addresses must be enclosed in square brackets if port for that host is specified.
#	If port is not specified, square brackets for IPv6 addresses are optional.
#	If this parameter is not specified, active checks are disabled.
#	Example: ServerActive=127.0.0.1:20051,zabbix.domain,[::1]:30051,::1,[12fc::1]
#
# Mandatory: no
# Default:
# ServerActive=

### Option: Hostname
#	Unique, case sensitive hostname.
#	Required for active checks and must match hostname as configured on the server.
#	Value is acquired from HostnameItem if undefined.
#
# Mandatory: no
# Default:
# Hostname=

### Option: HostnameItem
#	Item used for generating Hostname if it is undefined. Ignored if Hostname is defined.
#	Does not support UserParameters or aliases.
#
# Mandatory: no
# Default:
# HostnameItem=system.hostname

### Option: HostMetadata
#	Optional parameter that defines host metadata.
#	Host metadata is used at host auto-registration process.
#	An agent will issue an error and not start if the value is over limit of 255 characters.
#	If not defined, value will be acquired from HostMetadataItem.
#
# Mandatory: no
# Range: 0-255 characters
# Default:
# HostMetadata=

### Option: HostMetadataItem
#	Optional parameter that defines an item used for getting host metadata.
#	Host metadata is used at host auto-registration process.
#	During an auto-registration request an agent will log a warning message if
#	the value returned by specified item is over limit of 255 characters.
#	This option is only used when HostMetadata is not defined.
#
# Mandatory: no
# Default:
# HostMetadataItem=

### Option: RefreshActiveChecks
#	How often list of active checks is refreshed, in seconds.
#
# Mandatory: no
# Range: 60-3600
# Default:
# RefreshActiveChecks=120

### Option: BufferSend
#	Do not keep data longer than N seconds in buffer.
#
# Mandatory: no
# Range: 1-3600
# Default:
# BufferSend=5

### Option: BufferSize
#	Maximum number of values in a memory buffer. The agent will send
#	all collected data to Zabbix Server or Proxy if the buffer is full.
#
# Mandatory: no
# Range: 2-65535
# Default:
# BufferSize=100

### Option: MaxLinesPerSecond
#	Maximum number of new lines the agent will send per second to Zabbix Server
#	or Proxy processing 'log' and 'logrt' active checks.
#	The provided value will be overridden by the parameter 'maxlines',
#	provided in 'log' or 'logrt' item keys.
#
# Mandatory: no
# Range: 1-1000
# Default:
# MaxLinesPerSecond=20

############ ADVANCED PARAMETERS #################

### Option: Alias
#	Sets an alias for an item key. It can be used to substitute long and complex item key with a smaller and simpler one.
#	Multiple Alias parameters may be present. Multiple parameters with the same Alias key are not allowed.
#	Different Alias keys may reference the same item key.
#	For example, to retrieve the ID of user 'zabbix':
#	Alias=zabbix.userid:vfs.file.regexp[/etc/passwd,^zabbix:.:([0-9]+),,,,\1]
#	Now shorthand key zabbix.userid may be used to retrieve data.
#	Aliases can be used in HostMetadataItem but not in HostnameItem parameters.
#
# Mandatory: no
# Range:
# Default:

### Option: Timeout
#	Spend no more than Timeout seconds on processing
#
# Mandatory: no
# Range: 1-30
# Default:
# Timeout=3

### Option: AllowRoot
#	Allow the agent to run as 'root'. If disabled and the agent is started by 'root', the agent
#	will try to switch to the user specified by the User configuration option instead.
#	Has no effect if started under a regular user.
#	0 - do not allow
#	1 - allow
#
# Mandatory: no
# Default:
# AllowRoot=0

### Option: User
#	Drop privileges to a specific, existing user on the system.
#	Only has effect if run as 'root' and AllowRoot is disabled.
#
# Mandatory: no
# Default:
# User=zabbix

### Option: Include
#	You may include individual files or all files in a directory in the configuration file.
#	Installing Zabbix will create include directory in /usr/local/etc, unless modified during the compile time.
#
# Mandatory: no
# Default:
# Include=

# Include=/usr/local/etc/zabbix_agentd.userparams.conf
# Include=/usr/local/etc/zabbix_agentd.conf.d/
# Include=/usr/local/etc/zabbix_agentd.conf.d/*.conf

####### USER-DEFINED MONITORED PARAMETERS #######

### Option: UnsafeUserParameters
#	Allow all characters to be passed in arguments to user-defined parameters.
#	The following characters are not allowed:
#	\ ' " ` * ? [ ] { } ~ $ ! & ; ( ) < > | # @
#	Additionally, newline characters are not allowed.
#	0 - do not allow
#	1 - allow
#
# Mandatory: no
# Range: 0-1
# Default:
# UnsafeUserParameters=0

### Option: UserParameter
#	User-defined parameter to monitor. There can be several user-defined parameters.
#	Format: UserParameter=<key>,<shell command>
#	See 'zabbix_agentd' directory for examples.
#
# Mandatory: no
# Default:
# UserParameter=

####### LOADABLE MODULES #######

### Option: LoadModulePath
#	Full path to location of agent modules.
#	Default depends on compilation options.
#
# Mandatory: no
# Default:
# LoadModulePath=${libdir}/modules

### Option: LoadModule
#	Module to load at agent startup. Modules are used to extend functionality of the agent.
#	Format: LoadModule=<module.so>
#	The modules must be located in directory specified by LoadModulePath.
#	It is allowed to include multiple LoadModule parameters.
#
# Mandatory: no
# Default:
# LoadModule=

####### TLS-RELATED PARAMETERS #######

### Option: TLSConnect
#	How the agent should connect to server or proxy. Used for active checks.
#	Only one value can be specified:
#		unencrypted - connect without encryption
#		psk         - connect using TLS and a pre-shared key
#		cert        - connect using TLS and a certificate
#
# Mandatory: yes, if TLS certificate or PSK parameters are defined (even for 'unencrypted' connection)
# Default:
# TLSConnect=unencrypted

### Option: TLSAccept
#	What incoming connections to accept.
#	Multiple values can be specified, separated by comma:
#		unencrypted - accept connections without encryption
#		psk         - accept connections secured with TLS and a pre-shared key
#		cert        - accept connections secured with TLS and a certificate
#
# Mandatory: yes, if TLS certificate or PSK parameters are defined (even for 'unencrypted' connection)
# Default:
# TLSAccept=unencrypted

### Option: TLSCAFile
#	Full pathname of a file containing the top-level CA(s) certificates for
#	peer certificate verification.
#
# Mandatory: no
# Default:
# TLSCAFile=

### Option: TLSCRLFile
#	Full pathname of a file containing revoked certificates.
#
# Mandatory: no
# Default:
# TLSCRLFile=

### Option: TLSServerCertIssuer
#      Allowed server certificate issuer.
#
# Mandatory: no
# Default:
# TLSServerCertIssuer=

### Option: TLSServerCertSubject
#      Allowed server certificate subject.
#
# Mandatory: no
# Default:
# TLSServerCertSubject=

### Option: TLSCertFile
#	Full pathname of a file containing the agent certificate or certificate chain.
#
# Mandatory: no
# Default:
# TLSCertFile=

### Option: TLSKeyFile
#	Full pathname of a file containing the agent private key.
#
# Mandatory: no
# Default:
# TLSKeyFile=

### Option: TLSPSKIdentity
#	Unique, case sensitive string used to identify the pre-shared key.
#
# Mandatory: no
# Default:
# TLSPSKIdentity=

### Option: TLSPSKFile
#	Full pathname of a file containing the pre-shared key.
#
# Mandatory: no
# Default:
# TLSPSKFile=

```

# Server

Coming soon...

# Proxy

Coming soon...

# Java Gateway

Coming soon...
