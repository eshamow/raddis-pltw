class pltw ($nimbus_config) {

  # Foundational puppet configuration
  include pltw::puppet::config
  include pltw::puppet::scheduled_task
  include pltw::puppet::reporting

  # System-level configuration
  include stdlib::stages
  class { 'pltw::baseline': stage => 'setup' }

  # Lab computer desired state configuration
  include pltw::websites
  include pltw::software

}
