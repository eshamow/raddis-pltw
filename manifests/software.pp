class pltw::software ($installed = [], $removed = []) {
  include chocolatey
  include pltw::software::smart_sync_student
  include pltw::software::lgpo

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

  $removed.each |$program| {
    package { $program:
      ensure => absent,
    }
  }
}
