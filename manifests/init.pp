class pltw (
  $nimbus_config,
  $hostname_mapping = {},
) {

  # Foundational puppet configuration
  include pltw::puppet::config
  include pltw::puppet::scheduled_task
  include pltw::puppet::reporting

  # System-level configuration
  #include stdlib::stages
  #class { 'pltw::baseline::setup':  stage => 'setup'  }
  #class { 'pltw::baseline::deploy': stage => 'deploy' }

  # Lab computer desired state configuration
  include pltw::websites
  include pltw::software

  # Schedules used by the module
  schedule { 'maintenance':
    range  => "22:00 - 1:00",
    period => daily,
    repeat => 1,
  }
}
