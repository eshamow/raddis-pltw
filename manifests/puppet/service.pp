class pltw::puppet::service {
  include pltw

  service { 'puppet':
    ensure => running,
    enable => true,
  }

  file { 'C:/Program Files/Puppet Labs/Puppet/service/daemon.rb':
    ensure  => file,
    content => epp('pltw/puppet/daemon.rb.epp', { 'config' => $pltw::nimbus_config }),
    notify  => Service['puppet'],
  }

  ini_setting { 'puppet runinterval':
    ensure  => present,
    path    => 'C:/ProgramData/PuppetLabs/puppet/etc/puppet.conf',
    section => 'agent',
    setting => 'runinterval',
    value   => '300',
    notify  => Service['puppet'],
  }

}
