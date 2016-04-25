If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")){   
    $arguments = "& '" + $myinvocation.mycommand.definition + "'"
    Start-Process powershell -Verb runAs -ArgumentList $arguments
    Break
}

$networkAdapter = Get-WmiObject -Class win32_networkadapterconfiguration | where {$_.description -eq "Dell GigabitEthernet"}
[System.Collections.Generic.List[System.Object]]$listOfDnsSuffixes = $networkAdapter.DNSDomainSuffixSearchOrder |  Get-Unique
$dnsSuffixToMoveToTheTop = "intergen.org.nz"

if($listOfDnsSuffixes -contains $dnsSuffixToMoveToTheTop) {
    $listOfDnsSuffixes.Remove($dnsSuffixToMoveToTheTop) > null
}
$listOfDnsSuffixes.Insert(0, $dnsSuffixToMoveToTheTop) > null

$link =  "https://msdn.microsoft.com/en-us/library/windows/desktop/aa393296(v=vs.85).aspx"
$class = [wmiclass]'Win32_NetworkAdapterConfiguration'
$result = $class.SetDNSSuffixSearchOrder($listOfDnsSuffixes)

if($result.ReturnValue -eq 0){
    Write-Host "Success"
}
elseif ($result.ReturnValue -eq 91)
{
    Write-Host "Need admin rights"
}
else{
    Write-Host "Refer to the link for error code: "$result.ReturnValue
    Write-Host $link
}
Read-Host