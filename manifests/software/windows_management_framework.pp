class pltw::software::windows_management_framework {

  $msu_source = $::architecture ? {
    'x86' => 'https://download.microsoft.com/download/3/D/6/3D61D262-8549-4769-A660-230B67E15B25/Windows6.1-KB2819745-x86-MultiPkg.msu',
    'x64' => 'https://download.microsoft.com/download/3/D/6/3D61D262-8549-4769-A660-230B67E15B25/Windows6.1-KB2819745-x64-MultiPkg.msu',
  }

  remote_file { 'C:/Windows/Temp/WMF40.msu':
    ensure => present,
    source => $msu_source,
    before => Exec['Microsoft Management Framework 4.0'],
  }

  exec { 'Microsoft Management Framework 4.0':
    command => "C:\\Windows\\System32\\wusa.exe C:\\Windows\\Temp\\WMF40.msu /quiet /norestart",
    creates => "C:\\todo.txt",
  }

}
