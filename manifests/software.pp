class pltw::software ($installed = []) {
  include chocolatey
  include pltw::software::smart_sync_student

  dotnet { 'dotnet452':
    ensure  => present,
    version => '4.5.2',
    before  => Class['chocolatey'],
  }

  $installed.each |$program| {
    package { $program:
      ensure   => installed,
      provider => chocolatey,
      require  => Class['chocolatey'],
    }
  }

}
