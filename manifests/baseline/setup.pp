class pltw::baseline::setup {

  reboot { 'reboot-setup':
    when     => pending,
    schedule => 'maintenance',
  }

}
