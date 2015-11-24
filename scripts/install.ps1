# This script installs the windows puppet agent on the windows seteam vagrant vms
# from the master's pe_repo by downloading it to C:\tmp first and then running
# msiexec on it from there.

$puppet_master_server = "localhost"
$msi_source = "http://downloads.puppetlabs.com/windows/puppet-agent-x64-latest.msi"
$msi_dest = "C:\Windows\temp\puppet-agent-x64.msi"

Write-Host "Installing puppet agent from $msi_source"

# Determine system hostname and primary DNS suffix to determine certname
$objIPProperties = [System.Net.NetworkInformation.IPGlobalProperties]::GetIPGlobalProperties()
$name_components = @($objIPProperties.HostName, $objIPProperties.DomainName) | ? {$_}
$certname = $name_components -Join "."

Function Http-Get { Param($url, $file)
  $webclient = New-Object system.net.webclient
  $webclient.DownloadFile($url,$file)
}

Http-Get -url $msi_source -file $msi_dest
$msiexec_path = "C:\Windows\System32\msiexec.exe"
$msiexec_args = "/qn /i $msi_dest PUPPET_AGENT_CERTNAME=$certname PUPPET_MASTER_SERVER=localhost PUPPET_AGENT_STARTUP_MODE=Disabled"
$msiexec_proc = [System.Diagnostics.Process]::Start($msiexec_path, $msiexec_args)
$msiexec_proc.WaitForExit()
