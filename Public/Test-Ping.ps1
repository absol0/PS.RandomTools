# .Synopsis
# Pings destination server and returns true or false
function Test-Ping
{
	param(
		[Parameter(Mandatory=$true)]
		[String]$ComputerName,
		[Parameter(Mandatory=$false)]
		[Int]$TimeoutMilliseconds = 1000
	)
	$PingSender = New-Object System.Net.NetworkInformation.Ping
	try {
		$result = $PingSender.Send($ComputerName)
		if ($result.Status -eq "Success") {
			$true
		} else {
			$false
		}
	} catch {
		$false
	}
	$PingSender.Dispose()
}
