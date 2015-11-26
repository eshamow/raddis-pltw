# PLTW Computer Lab Puppet Module #

## Set Up A Lab Computer

To install and manage a lab computer:

1. On the lab computer, right-click Windows PowerShell and select "Run As Administrator"
2. Run the following command

        powershell -nop -c "iex(New-Object Net.WebClient).DownloadString('http://git.io/vBcA7')"

3. When the "Firewall has blocked ..." prompt comes up, press "Allow Access"

## Set Up An Optional PuppetDB Server

Run the following commands:

    yum localinstall http://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
    yum install puppet-agent
    /opt/puppetlabs/bin/puppet module install tse/nimbus
    /opt/puppetlabs/bin/puppet nimbus apply https://raw.githubusercontent.com/raddis/raddis-pltw/master/puppetdb.conf
