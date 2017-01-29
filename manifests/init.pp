# Default zabbix class
class zabbix (
  Boolean                                     $package_manage,
  String                                      $package_ensure,
  Optional[Stdlib::Absolutepath]              $package_source,
  Optional[String]                            $package_version,
  Optional[String]                            $install_options,
  Optional[String]                            $uninstall_options,
  Boolean                                     $service_manage,
  Boolean                                     $service_enable,
  Enum['running', 'stopped']                  $service_ensure,
  Optional[String]                            $gpgkey,
  Optional[String]                            $lineendings,

  Optional[Enum['system', 'file', 'console']] $logtype,
  Optional[Integer[0,65535]]                  $listenport,
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

  Optional[Variant[Boolean, Integer[0,1]]]    $manage_repo,

  Optional[Stdlib::Absolutepath]              $tlscafile,
  Optional[Stdlib::Absolutepath]              $tlscrlfile,
  Optional[Stdlib::Absolutepath]              $tlskeyfile,
) {
}
