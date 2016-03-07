# PLTW Computer Lab Puppet Module #

## Set Up A Lab Computer

To install and manage a lab computer:

### Option 1: When logged in as an Administrator

1. On the lab computer
    * click Start
    * in the search bar type "PowerShell"
    * right-click the top search result, "Windows PowerShell", and select Run As Administrator
2. Run the following command

        powershell -nop -c "iex(New-Object Net.WebClient).DownloadString('http://git.io/vBcA7')"

3. When the "Firewall has blocked ..." prompt comes up, press "Allow Access"

### Option 2: When logged in as a regular user

It is possible to set up a lab computer logged in as a normal user account provided that the built-in administrator account is enabled, and that you know the administrator password. Note that this probably doesn't work with domain accounts, only the local admin account.

1. On the lab computer
    * click Start
    * in the search bar type "cmd" and press enter
2. In the command prompt, run the following command

        runas /user:administrator "powershell -nop -c \"iex(New-Object Net.WebClient).DownloadString('http://git.io/vBcA7')\""

3. When prompted, enter the password for the built-in Administrator account

## Testing URLs

When testing, replace the above commands with the following:

        powershell -nop -c "iex(New-Object Net.WebClient).DownloadString('https://git.io/v2jHW')"

        runas /user:administrator "powershell -nop -c \"iex(New-Object Net.WebClient).DownloadString('https://git.io/v2jHW')\""

