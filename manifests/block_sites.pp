class pltw::website_block ($sites = []) {

  $sites.each |$site| {
    host { $site:
      ensure  => present,
      ip      => '127.0.0.1',
      comment => 'pltw::website_block',
    }
  }

  # Should we purge hosts resources? Need to look at example hosts file from a
  # lab system to know whether or not that would be a good idea.
}
