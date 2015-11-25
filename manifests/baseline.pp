class pltw::baseline {

  scheduled_task { 'puppet':
    ensure    => present,
    enabled   => true,
    command   => 'C:\Program Files\Puppet Labs\Puppet\bin\puppet.bat',
    arguments => 'nimbus apply https://git.io/vBnP6',
    trigger   => {
      schedule         => daily,
      start_date       => '2015-01-01',
      start_time       => '06:00', # Start running this task at 6:00 AM
      minutes_interval => '10',    # Repeat this task every 10 minutes
      minutes_duration => '720',   # The task will run for a total of 12 hours
    }
  }

}
