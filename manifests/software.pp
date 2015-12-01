class pltw::software ($installed = []) {
  include chocolatey

  dotnet { 'dotnet451':
    ensure  => present,
    version => '4.5.1',
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
