class pltw::software::smart_sync_student {
  include pltw

#  package { 'SMART Sync Student':
#    ensure => absent,
#  }
 registry_value { 'HKLM\\Software\\SMART Technologies\\SMART Sync Student':
   ensure  => present,
   require => Package['SMART Sync Student'],
 }


# If the computer has an assigned human name, set it to display with that
# name in the SMART Sync Teacher view. Otherwise, default to anonymous.
 case $pltw::hostname_mapping[$::hostname] {
   undef: {
     $identity = 'AnonymousID'
     $idmode   = 0x00000003
   }
   default: {
     $identity = $pltw::hostname_mapping[$::hostname]
     $idmode   = 0x00000001
   }
 }

 remote_file { 'smartsync2011studentwin.exe':
   ensure => present,
   path   => 'C:/Windows/Temp/smartsync2011studentwin.exe',
   source => 'http://downloads01.smarttech.com/software/synch/2011/windows/smartsync2011studentwin.exe',
 }

 package { 'SMART Sync Student':
   ensure          => installed,
   source          => 'C:/Windows/Temp/smartsync2011studentwin.exe',
   require         => Remote_file['smartsync2011studentwin.exe'],
   install_options => ['/S', '/v/qn'],
 }

 $key = 'HKLM\\Software\\SMART Technologies\\SMART Sync Student'
 $nodekey = 'HKLM\\Software\\Wow6432Node\\SMART Technologies\\SMART Sync Student'

 $values = [
   ['RedrawHooks', 'dword', 0x000003e8],
   ['LanguageID', 'dword', 0x00000000],
   ['MirrorDriver', 'dword', 0x000003e8],
   ['MulticastTTL', 'dword', 0x00000020],
   ['UnicastNoDelay', 'dword', 0x00000001],
   ['StudentIDMode', 'dword', $idmode],
#   ['StudentIDMode', 'dword', 0x00000003],
   ['PasswordHash', 'string', ''],
   ['NICListLength', 'dword', 0x00000000],
   ['UseNamingServer', 'dword', 0x00000000],
   ['NTGroupListLength', 'dword', 0x00000000],
   ['Student Path', 'string', 'C:\\Program Files\\SMART Technologies\\Sync Student\\'],
   ['ActiveDirStudentIdField', 'string', ''],
   ['CtrlAltDelSettings', 'dword', 0x00000002],
   ['EnableFileTransfer', 'dword', 0x00000001],
   ['Visible', 'dword', 0x00000000],
   ['StudentID', 'string', $identity],
#   ['StudentID', 'string', 'AnonymousID'],
   ['Build Version', 'string', '10.0.574.0'],
   ['ConnectTeacherID', 'string', 'Rose Addis'],
   ['EnableHelp', 'dword', 0x00000000],
   ['DisplayExit', 'dword', 0x00000000],
   ['StoreFilesToMyDocs', 'dword', 0x00000001],
   ['AutoStart', 'dword', 0x00000001],
   ['CustomSharedFolder', 'string', ''],
   ['SecurityUsed', 'dword', 0x00000000],
   ['ConnectIP', 'string', 'it483411.ad.ppsnet'],
   ['ConnectionUsed', 'dword', 0x00000002],
   ['EnableNICDefaultOrder', 'dword', 0x00000001],
   ['EnableQuestions', 'dword', 0x00000001],
   ['NamingServerLoc', 'string', ''],
   ['EnableChat', 'dword', 0x00000001],
   ['NamingServerPassedTest', 'dword', 0x00000000],
   ['HWGPUCapture', 'dword', 0x000003e8],
   ['GPUBoolEnableTimings', 'dword', 0x00000000],
   ['GPUBoolMergeRegions', 'dword', 0x00000001],
   ['GPUTileCount', 'dword', 0x00000001],
   ['GPUScaleFactor', 'dword', 0x00000003],
   ['GPUThresholdPixelCorrection', 'dword', 0x0000000c],
 ]

 registry_key { $key:
   ensure  => present,
   require => Package['SMART Sync Student'],
 }

 $values.each |$value| {
   registry_value { "${key}\\${value[0]}":
     ensure  => present,
     type    => $value[1],
     data    => $value[2],
     require => Registry_key[$key],
   }
 }

 $wowvalues = [
   ['LanguageID', 'dword', 0x00000000],
   ['StudentIDMode', 'dword', 0x00000003],
   ['CtrlAltDelSettings', 'dword', 0x00000002],
   ['ConnectTeacherID', 'dword', "Rose Addis"],
   ['ConnectionUsed', 'dword', 0x00000002],
 ]

 registry_key { $nodekey:
   ensure  => present,
   require => Package['SMART Sync Student'],
 }

 $values.each |$wowvalue| {
   registry_value { "${nodekey}\\${wowvalue[0]}":
     ensure  => present,
     type    => $wowvalue[1],
     data    => $wowvalue[2],
     require => Registry_key[$nodekey],
   }
 }
}
