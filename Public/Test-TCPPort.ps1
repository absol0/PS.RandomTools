function Test-TCPPort
{
	param(
		[Parameter(Mandatory=$true)]
		[String]$ComputerName,
		[Parameter(Mandatory=$true)]
		[Int]$Port,
		[Parameter(Mandatory=$false)]
		[Int]$TimeoutMilliseconds = 1000
	)
	begin {
		$PortOpen = $false
	}
	process {
		# Try and establish a connection to port async
		$TCPObject = New-Object System.Net.Sockets.TcpClient
		$Connect = $TCPObject.BeginConnect($Computername,$Port,$null,$null)
		# Wait for the connection no longer than $timeoutMilliseconds
		$Wait = $Connect.AsyncWaitHandle.WaitOne($TimeoutMilliseconds,$false)
		if (!$Wait) { # Timeout
			$TCPObject.Close()
		} else {
			# Try and complete the connection
			try {
				$null = $TCPObject.EndConnect($Connect)
				$PortOpen = $true
			} catch {
				$PortOpen = $false
			}
			$TCPObject.Close()
		}
		$TCPObject.Dispose()
		$PortOpen
	}
	end { }
	
}
