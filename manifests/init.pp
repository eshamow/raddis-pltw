class pltw ($nimbus_config) {

  # Foundational puppet configuration
  include pltw::puppet::config
  include pltw::puppet::scheduled_task
  include pltw::puppet::reporting

  # Lab computer desired state configuration
  include pltw::websites

  # Temporarily, only include Chocolatey and software on one system
  if $::clientcert == 'it483397.ad.ppsnet' {
    include pltw::software
  }

}
