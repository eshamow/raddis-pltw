class pltw::baseline::deploy {

  reboot { 'reboot-deploy':
    when     => pending,
    schedule => 'maintenance',
  }

}
