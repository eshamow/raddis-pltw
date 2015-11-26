class pltw::puppet::baseline {
  $config = $pltw::params::nimbus_config

  # Work around a heinous error printing bug on Windows.
  file { 'C:/Program Files/Puppet Labs/Puppet/puppet/lib/puppet/util/monkey_patches.rb':
    ensure  => file,
    content => file('pltw/puppet/monkey_patches.rb'),
  }

  # Put a "Run Puppet Nimbus" link in the start menu
  file { 'C:/ProgramData/Microsoft/Windows/Start Menu/Programs/Puppet/Run Puppet Nimbus.lnk':
    ensure  => file,
    content => epp('pltw/puppet/shortcut.lnk.epp', { 'config' => $config }),
  }

}
