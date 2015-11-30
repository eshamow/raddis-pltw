class pltw::baseline {
  # Foundational puppet configuration
  include pltw::puppet::config
  include pltw::puppet::scheduled_task
  include pltw::puppet::reporting

  # Lab computer desired state configuration
  include pltw::block_sites
}
