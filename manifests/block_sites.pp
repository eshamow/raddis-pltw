class pltw::block_sites ($sites = []) {

  $sites.each |$site| {
    host { $site:
      ensure  => present,
      ip      => '190.93.242.249',
      comment => 'pltw::website_block',
    }
  }

  # The hosts file is not used for anything besides blocking undesired sites.
  # To allow for automatic un-blocking, purge any unmanaged entries.
  resources { 'host':
    purge => true,
  }

}
