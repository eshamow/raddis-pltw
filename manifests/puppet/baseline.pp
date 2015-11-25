class pltw::puppet::baseline {

  $geotrust_ca_path = 'C:/Program Files/Puppet Labs/Puppet/misc/GeoTrust_Global_CA.pem'

  file { 'GeoTrust CA':
    ensure  => file,
    path    => $geotrust_ca_path,
    content => file('pltw/GeoTrust_Global_CA.pem'),
  }

  exec { 'install GeoTrust cert':
    provider => powershell,
    command  => "certutil -addstore Root \"${geotrust_ca_path}\"",
    unless   => 'certutil -store | FindStr GeoTrust',
    require  => File['GeoTrust CA'],
  }

}
