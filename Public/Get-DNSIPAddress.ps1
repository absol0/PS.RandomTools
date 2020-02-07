function Get-DNSIPAddress
{
	Param(
		[Parameter(Mandatory=$true)]
		[String]$Hostname
	)
	try {
		([System.Net.Dns]::gethostentry($Hostname)).Addresslist | ForEach-Object { $_.IpAddressToString }
	} catch {
		$null
	}  
}
