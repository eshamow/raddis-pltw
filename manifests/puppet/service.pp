class pltw::puppet::service ($config) {

  service { 'puppet':
    ensure => running,
    enable => true,
  }

  file { 'C:/Program Files/Puppet Labs/Puppet/service/daemon.rb':
    ensure  => file,
    content => epp('pltw/puppet/daemon.rb.epp', { 'config' => $config }),
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
