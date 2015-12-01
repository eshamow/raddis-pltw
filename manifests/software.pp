class pltw::software ($installed = []) {
  require chocolatey

  Package { provider => chocolatey }

  $installed.each |$program| {
    package { $program:
      ensure => installed,
    }
  }

}
