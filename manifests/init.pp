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
  Optional[String]                            $lineEndings,

  Optional[Enum['system', 'file', 'console']] $LogType,
  Optional[Integer[0,65535]]                  $ListenPort,
  Optional[String]                            $SourceIP,
  Optional[Stdlib::Absolutepath]              $LogFile,
  Optional[Integer[0,1024]]                   $LogFileSize,
  Optional[Integer[0,5]]                      $DebugLevel,
  Optional[Stdlib::Absolutepath]              $PidFile,
  Optional[String]                            $ListenIP,
  Optional[Integer[1,30]]                     $Timeout,
  Optional[Variant[Boolean, Integer[0,1]]]    $AllowRoot,
  Optional[String]                            $User,
  Optional[Array[Stdlib::Absolutepath]]       $Include,
  Optional[String]                            $LoadModulePath,
  Optional[Array[String]]                     $LoadModule,

  Optional[Variant[Boolean, Integer[0,1]]]    $manage_repo,

  Optional[Stdlib::Absolutepath]              $TLSCAFile,
  Optional[Stdlib::Absolutepath]              $TLSCRLFile,
  Optional[Stdlib::Absolutepath]              $TLSKeyFile,
) {
}
