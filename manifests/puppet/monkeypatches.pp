class pltw::puppet::monkeypatches {

  # Work around a heinous error printing bug on Windows.
  file { 'C:/Program Files/Puppet Labs/Puppet/puppet/lib/puppet/util/monkey_patches.rb':
    ensure  => file,
    content => file('pltw/puppet/monkey_patches.rb'),
  }

}
