class pltw::websites (
  $blocked = [],
  $block_start_time = 0,
  $block_end_time   = 0,
) {

  $current_time = strftime("%H%M") + 0
  if ($current_time >= $block_start_time and $current_time < $block_end_time) {
    $blocked.each |$site| {
      host { $site:
        ensure  => present,
        ip      => '127.0.0.1', # point to localhost instead of web address ip
        comment => 'pltw::website_block',
      }
    }
  }

  # The hosts file is not used for anything besides blocking undesired sites.
  # To allow for automatic un-blocking, purge any unmanaged entries.
  resources { 'host':
    purge => true,
  }

}
