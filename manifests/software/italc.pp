class pltw::software::italc {
  include pltw

  file { 'iTALC settings':
    path   => 'C:/Windows/Temp/italc_settings.xml',
    ensure => present,
    source => 'puppet:///modules/pltw/settings.xml',
  }
  file { 'iTALC public key':
    path   => 'C:/Windows/Temp/italc_public_key.key.txt',
    ensure => present,
    source => 'puppet:///modules/pltw/italc_public_key.key.txt',
  }

  exec { 'iTALC settings':
    command => 'imc -ApplySettings C:\\windows\\temp\\italc_settings.xml',
    cwd     => 'C:/Program Files/iTALC',
    path    => $::path,
    require => Package['italc'],
  }
  exec { 'iTALC public key':
    command => 'imc -ImportPublicKey C:\\windows\\temp\italc_public_key.key.txt',
    cwd     => 'C:/Program Files/iTALC',
    path    => $::path,
    require => Package['italc'],
  }

#  $key = 'HKLM\\Software\\SMART Technologies\\SMART Sync Student'
#
#  $values = [
#    ['RedrawHooks', 'dword', 0x000003e8],
#    ['Student Path', 'string', 'C:\\Program Files\\SMART Technologies\\Sync Student\\'],
#    ['GPUThresholdPixelCorrection', 'dword', 0x0000000c],
#  ]
#
#  registry_key { $key:
#    ensure  => present,
#    require => Package['SMART Sync Student'],
#  }
#
#  $values.each |$value| {
#    registry_value { "${key}\\${value[0]}":
#      ensure  => present,
#      type    => $value[1],
#      data    => $value[2],
#      require => Registry_key[$key],
#    }
#  }
}
