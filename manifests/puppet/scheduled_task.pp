class pltw::puppet::scheduled_task {
  include pltw

  scheduled_task { 'puppet':
    ensure    => present,
    enabled   => true,
    command   => 'C:\Program Files\Puppet Labs\Puppet\bin\puppet.bat',
    arguments => "nimbus apply ${pltw::nimbus_config}",
    trigger   => {
      schedule         => daily,
      start_date       => '2015-01-01',
      start_time       => '06:00', # Start running this task at 6:00 AM
      minutes_interval => '10',    # Repeat this task every 10 minutes
      minutes_duration => '1440',  # The task will run for 24 hours (all day)
    }
  }

}
