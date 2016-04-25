# IntergenDnsDomain
Sets Intergen's DNS suffix first in network's settings

Features
--------
Why should I use this script?

 - If you are using malicious VPN software that constantly changes the order of DNS suffixes in your settings, this script will automatically change the order back to what it should be on Intergen’s network.


Usage
--------

Scheduled:

Copy both powershell scripts included to the root of your C:\ drive.

Copy the .bat file to "C:\Users\<user_name>\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\"

This will run powershell hidden in the background and execute the DNS change script every 60 seconds when windows starts

If you want to execute it mannually. "start /min powershell -WindowStyle Hidden -Command C:\DnsDomainWorkerInvoker.ps1"

(Optional run this to keep the powershell window open to see when last it was run successfully)

"start powershell -Command C:\DnsDomainWorkerInvoker.ps1"

Manual:

Just execute DnsDomain.ps1 from powershell.

If it was run without admin rights, it will start itself up in a PowerShell instance with admin rights.
