# This script installs the windows puppet agent on the windows seteam vagrant vms
# from the master's pe_repo by downloading it to C:\tmp first and then running
# msiexec on it from there.

$puppet_master_server = "localhost"
#$msi_source = "http://downloads.puppetlabs.com/windows/puppet-agent-x64-latest.msi"
#$msi_dest = "C:\Windows\temp\puppet-agent-x64.msi"
$msi_source = "http://downloads.puppetlabs.com/windows/puppet-agent-x86-latest.msi"
$msi_dest = "C:\Windows\temp\puppet-agent-x86.msi"


# Determine system hostname and primary DNS suffix to determine certname
Write-Host "Determining system name"
$objIPProperties = [System.Net.NetworkInformation.IPGlobalProperties]::GetIPGlobalProperties()
$name_components = @($objIPProperties.HostName, $objIPProperties.DomainName) | ? {$_}
$certname = ($name_components -Join ".").ToLower()
Write-Host "System name is $certname"

Function Http-Get { Param($url, $file)
  $webclient = New-Object system.net.webclient
  $webclient.DownloadFile($url,$file)
}

Write-Host "Downloading puppet agent from $msi_source"
#Http-Get -url $msi_source -file $msi_dest

Write-Host "Installing puppet agent"
$msiexec_path = "C:\Windows\System32\msiexec.exe"
$msiexec_args = "/qn /i $msi_dest PUPPET_AGENT_CERTNAME=$certname PUPPET_MASTER_SERVER=localhost PUPPET_AGENT_STARTUP_MODE=Disabled"
$process = Start-Process -FilePath $msiexec_path -ArgumentList $msiexec_args -Wait -PassThru


