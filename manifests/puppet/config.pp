class pltw::puppet::config {
  include pltw

  # Work around a heinous error printing bug on Windows.
  file { 'C:/Program Files/Puppet Labs/Puppet/puppet/lib/puppet/util/monkey_patches.rb':
    ensure  => file,
    content => file('pltw/puppet/monkey_patches.rb'),
  }

  # Put a "Run Puppet Nimbus" link in the start menu
  shortcut { 'C:/ProgramData/Microsoft/Windows/Start Menu/Programs/Puppet/Run Puppet Nimbus.lnk':
    target            => 'C:/Program Files/Puppet Labs/Puppet/bin/puppet.bat',
    arguments         => "nimbus apply ${pltw::nimbus_config}",
    working_directory => 'C:/Program Files/Puppet Labs/Puppet/bin',
    description       => 'Run Puppet Nimbus on-demand',
  }

}
