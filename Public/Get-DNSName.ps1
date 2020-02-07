function Get-DNSName
{
	Param(
		[Parameter(Mandatory=$true)]
		[String]$IPAddress
	)
	try {
		([System.Net.Dns]::gethostentry($IPAddress)).HostName
	} catch {
		$null
	}  
}
