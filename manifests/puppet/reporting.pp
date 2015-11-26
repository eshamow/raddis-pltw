class pltw::puppet::reporting (
  $puppetdb_host,
  $puppetdb_port = '8081',
) {

  # Settings in puppet.conf
  { 'report'  => 'true',
    'reports' => 'puppetdb',
  }.each |$setting,$value| {
    ini_setting { "puppet main ${setting}":
      ensure  => present,
      path    => "${settings::confdir}/puppet.conf",
      section => 'main',
      setting => $setting,
      value   => $value,
    }
  }

  # Puppet-side puppetdb.conf
  file { "${settings::confdir}/puppetdb.conf":
    ensure  => file,
    content => epp('pltw/puppet/puppetdb.conf.epp', {
      'host' => $puppetdb_host,
      'port' => $puppetdb_port,
    }),
  }

  # Routes.yaml
  file { "${settings::confdir}/routes.yaml":
    ensure  => file,
    content => file('pltw/puppet/routes.yaml'),
  }

  # Terminus installation
  file { "${rubysitedir}/puppet":
    ensure  => directory,
    recurse => remote,
    source  => 'puppet:///modules/pltw/puppet/lib',
  }

}
