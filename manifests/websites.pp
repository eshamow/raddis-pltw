class pltw::websites ($blocked = []) {

  $sites.each |$site| {
    host { $site:
      ensure  => present,
      ip      => '127.0.0.1', # point to localhost instead of web address ip
      comment => 'pltw::website_block',
    }
  }

  # The hosts file is not used for anything besides blocking undesired sites.
  # To allow for automatic un-blocking, purge any unmanaged entries.
  resources { 'host':
    purge => true,
  }

}
