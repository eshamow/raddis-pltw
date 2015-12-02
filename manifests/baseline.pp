class pltw::baseline {

  schedule { 'maintenance':
    range  => "22:00 - 1:00",
    period => daily,
    repeat => 1,
  }

  reboot { 'maintenance':
    when     => pending,
    schedule => 'maintenance',
  }

}
