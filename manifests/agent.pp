# Zabbix agent main class
class zabbix::agent inherits zabbix (

  Optional[String]                         $lineEndings,

  Boolean                                  $package_manage,
  String                                   $package_ensure,
  String                                   $package_source,
  Boolean                                  $service_manage,
  Boolean                                  $service_enable,
  Enum['running', 'stopped']               $service_ensure,

  Optional[String]                         $install_options,
  Optional[String]                         $uninstall_options,

  Optional[Integer[0, 65535]]              $ListenPort,
  Optional[String]                         $SourceIP,
  Optional[Stdlib::Absolutepath]           $LogFile,
  Optional[Integer[0,1024]]                $LogFileSize,
  Optional[Integer[0,5]]                   $DebugLevel,
  Optional[Stdlib::Absolutepath]           $PidFile,
  Optional[String]                         $ListenIP,
  Optional[Integer[1,30]]                  $Timeout,
  Optional[Variant[Boolean, Integer[0,1]]] $AllowRoot,
  Optional[Array[Stdlib::Absolutepath]]    $Include,
  Optional[String]                         $LoadModulePath,
  Optional[Array[String]]                  $LoadModule,

  Optional[String]                         $Hostname,
  Optional[String]                         $HostnameItem,

  Optional[String[0,255]]                  $HostMetadata,
  Optional[String]                         $HostMetadataItem,
  Optional[Integer[60,3600]]               $RefreshActiveChecks,
  Optional[Integer[1,3600]]                $BufferSend,
  Optional[Integer[2,65535]]               $BufferSize,
  Optional[Integer[1,1000]]                $MaxLinesPerSecond,
  Optional[Array[String]]                  $Alias,
  Optional[Variant[Boolean, Integer[0,1]]] $EnableRemoteCommands,
  Optional[Variant[Boolean, Integer[0,1]]] $LogRemoteCommands,
  Optional[Array[String]]                  $Server,
  Optional[Integer[0,100]]                 $StartAgents,
  Optional[Array[String]]                  $ServerActive,
  Optional[Variant[Boolean, Integer[0,1]]] $UnsafeUserParameters,
  Optional[Array[String]]                  $UserParameter,

  Optional[Enum['unencrypted',
                'psk',
                'cert']]                   $TLSConnect,
  Optional[Enum['unencrypted',
                'psk',
                'cert']]                   $TLSAccept,
  Optional[Stdlib::Absolutepath]           $TLSCAFile,
  Optional[Stdlib::Absolutepath]           $TLSCRLFile,
  Optional[String]                         $TLSServerCertIssuer,
  Optional[String]                         $TLSServerCertSubject,
  Optional[Stdlib::Absolutepath]           $TLSCertFile,
  Optional[Stdlib::Absolutepath]           $TLSKeyFile,
  Optional[String]                         $TLSPSKIdentity,
  Optional[Stdlib::Absolutepath]           $TLSPSKFile,

) {
  $zabbix = 'zabbix::agent'

  contain ${zabbix}::install
  contain ${zabbix}::config
  contain zabbix::user
  contain ${zabbix}::service

  Class ["${zabbix}::install"] ->
  Class [ "zabbix::user"] ->
  Class [ "${zabbix}::config"] ->
  Class [ "${zabbix}::service"]

}
