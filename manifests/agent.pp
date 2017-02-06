# Zabbix agent main class
class zabbix::agent (

  Optional[String]                            $lineendings,

  Boolean                                     $package_manage,
  String                                      $package_ensure,
  String                                      $package_source,
  Boolean                                     $service_manage,
  Boolean                                     $service_enable,
  Enum['running', 'stopped']                  $service_ensure,

  Optional[String]                            $install_options,
  Optional[String]                            $uninstall_options,

  Optional[Enum['system', 'file', 'console']] $logtype,
  Optional[Integer[0, 65535]]                 $listenport,
  Optional[String]                            $sourceip,
  Optional[Stdlib::Absolutepath]              $logfile,
  Optional[Integer[0,1024]]                   $logfilesize,
  Optional[Integer[0,5]]                      $debuglevel,
  Optional[Stdlib::Absolutepath]              $pidfile,
  Optional[String]                            $listenip,
  Optional[Integer[1,30]]                     $timeout,
  Optional[Variant[Boolean, Integer[0,1]]]    $allowroot,
  Optional[String]                            $user,
  Optional[Array[Stdlib::Absolutepath]]       $include,
  Optional[String]                            $loadmodulepath,
  Optional[Array[String]]                     $loadmodule,

  Optional[String]                            $hostname,
  Optional[String]                            $hostnameitem,

  Optional[String[0,255]]                     $hostmetadata,
  Optional[String]                            $hostmetadataitem,
  Optional[Integer[60,3600]]                  $refreshactivechecks,
  Optional[Integer[1,3600]]                   $buffersend,
  Optional[Integer[2,65535]]                  $buffersize,
  Optional[Integer[1,1000]]                   $maxlinespersecond,
  Optional[Array[String]]                     $zalias,
  Optional[Variant[Boolean, Integer[0,1]]]    $enableremotecommands,
  Optional[Variant[Boolean, Integer[0,1]]]    $logremotecommands,
  Optional[Array[String]]                     $server,
  Optional[Integer[0,100]]                    $startagents,
  Optional[Array[String]]                     $serveractive,
  Optional[Variant[Boolean, Integer[0,1]]]    $unsafeuserparameters,
  Optional[Array[String]]                     $userparameter,
  Optional[Array[String]]                     $perfcounter,

  Optional[Enum['unencrypted',
                'psk',
                'cert']]                      $tlsconnect,
  Optional[Enum['unencrypted',
                'psk',
                'cert']]                      $tlsaccept,
  Optional[Stdlib::Absolutepath]              $tlscafile,
  Optional[Stdlib::Absolutepath]              $tlscrlfile,
  Optional[String]                            $tlsservercertissuer,
  Optional[String]                            $tlsservercertsubject,
  Optional[Stdlib::Absolutepath]              $tlscertfile,
  Optional[Stdlib::Absolutepath]              $tlskeyfile,
  Optional[String]                            $tlspskidentity,
  Optional[Stdlib::Absolutepath]              $tlspskfile,

) {
  $zabbix = 'zabbix::agent'

  contain "${zabbix}::install"
  contain "${zabbix}::config"
  contain 'zabbix::user'
  contain "${zabbix}::service"

  Class["${zabbix}::install"] ->
  Class['zabbix::user'] ->
  Class["${zabbix}::config"] ->
  Class["${zabbix}::service"]

}
