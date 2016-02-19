class pltw::software::lgpo {

  $zip_source = 'http://blogs.technet.com/cfs-filesystemfile.ashx/__key/telligent-evolution-components-attachments/01-4062-00-00-03-65-94-11/LGPO.zip'

  remote_file { 'C:/Windows/Temp/LGPO.zip':
    ensure => present,
    source => $zip_source,
    before => Unzip['LGPO'],
  }

  unzip { 'LGPO':
    source  => 'C:/Windows/Temp/LGPO.zip',
    creates => 'C:/Windows/Temp/LGPO',
  }
}
