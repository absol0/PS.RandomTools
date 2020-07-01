function New-ModuleAlias {
	[CmdletBinding(SupportsShouldProcess)]
	param (
		[Parameter(Mandatory=$true)]
		[String[]]$ModulePath
	)
	begin {
		$ModuleLocations = @('C:\Program Files\WindowsPowerShell','C:\Program Files\PowerShell', '~/.local/share/powershell/Modules/')
		foreach ($ModuleLocationPath in $ModuleLocations) {
			If (!(Test-Path "$($ModuleLocationPath)\Modules")) {
				if ($PSCmdlet.ShouldProcess("$($ModuleLocationPath)\Modules", "Create Directory Item")) {
					try {
						New-Item -ItemType Directory -Path "$($ModuleLocationPath)\Modules"
					} catch {
						Write-Warning "Could not create path <$($ModuleLocationPath)\Modules>, will not create alias here"
					}
				}
			}
		}
	}
	process {
		foreach ($SourcePath in $ModulePath) {
			if (Test-Path $SourcePath) {
				$ItemObject = Get-Item $SourcePath
				if ($ItemObject.PSIsContainer) {
					foreach ($ModulePath in $ModuleLocations) {
						If (Test-Path "$($ModulePath)\Modules") {
							if ($PSCmdlet.ShouldProcess("$($ModulePath)\Modules\$($ItemObject.Name)", "Create link to $SourcePath")) {
								try {
									New-Item -ItemType SymbolicLink -Target $SourcePath -Path "$($ModulePath)\Modules\$($ItemObject.Name)"
								} catch {
									Write-Warning "Could not create link, $($ItemObject.Name), for $SourcePath in $($ModulePath)\Modules"
								}
							}
						}
					}
				}
			} else {
				Write-Warning "Could not find path $($SourcePath)"
			}
		}
	}
	end {
	}
}
