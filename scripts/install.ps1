# This script installs the windows puppet agent on the windows seteam vagrant vms
# from the master's pe_repo by downloading it to C:\tmp first and then running
# msiexec on it from there.

Function Http-Get { Param($url, $file)
  $webclient = New-Object system.net.webclient
  $webclient.DownloadFile($url,$file)
}

# Get system information and set variables
$arch = if ([System.IntPtr]::Size -eq 4) { "86" } else { "64" }
$puppet_master_server = "localhost"
$objIPProperties = [System.Net.NetworkInformation.IPGlobalProperties]::GetIPGlobalProperties()
$name_components = @($objIPProperties.HostName, $objIPProperties.DomainName) | ? {$_}
$certname = ($name_components -Join ".").ToLower()
$msi_source = "http://downloads.puppetlabs.com/windows/puppet-agent-x$($arch)-latest.msi"
$msi_dest = "C:\Windows\temp\puppet-agent-x$($arch).msi"
$msiexec_path = "C:\Windows\System32\msiexec.exe"
$msiexec_args = "/qn /i $msi_dest PUPPET_AGENT_CERTNAME=$certname PUPPET_MASTER_SERVER=localhost PUPPET_AGENT_STARTUP_MODE=Disabled"
$puppet_path = "C:\Program Files\Puppet Labs\Puppet\bin\puppet.bat"
$gem_path = "C:\Program Files\Puppet Labs\Puppet\sys\ruby\bin\gem"
$certutil_path = "C:\Windows\System32\certutil.exe"
$ca_source = "https://www.geotrust.com/resources/root_certificates/certificates/GeoTrust_Global_CA.pem"
$ca_dest = "C:\Windows\temp\geotrustglobalca.pem"

Write-Host "System name is $certname"

Write-Host "Downloading GeoTrust Global CA"
Http-Get -url $ca_source -file $ca_dest

Write-Host "Installing GeoTrust Global CA"
Start-Process -FilePath $certutil_path -ArgumentList "-v -addstore Root $ca_dest" -Wait

Write-Host "Downloading puppet agent from $msi_source"
Http-Get -url $msi_source -file $msi_dest

Write-Host "Installing puppet agent"
Start-Process -FilePath $msiexec_path -ArgumentList $msiexec_args -Wait

Write-Host "Installing hocon gem for nimbus module"
Start-Process -FilePath $gem_path -ArgumentList "install hocon --no-ri --no-rdoc" -Wait

Write-Host "Installing nimbus module"
Start-Process -FilePath $puppet_path -ArgumentList "module install tse/nimbus" -Wait

Write-Host "Configuring system with Puppet Nimbus"
Start-Process -FilePath $puppet_path -ArgumentList "nimbus apply https://git.io/vBcAp" -Wait
