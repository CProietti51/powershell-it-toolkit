Write-Output ""
Write-Output "Starting program..."
Write-Output ""

function mainMenu{
	Write-Output ""
	Write-Host @"
	Main Menu:
	1. Windows Update Fix
	2. Internet Issues Fix
	3. System Files Fix
	4. Low Disk Space/Slow Performance Fix
	5. Taskbar/Start Menu Fix
	6. Update Applications
	7. Disk Errors Fix
	8. Program Exit
"@
	Write-Output ""
	$validInteger = $false
		do {
			$getOption = Read-Host "Please choose an option[1-8]"
			if($getOption -ge 1 -and $getOption -le 8) {
				switch ($getOption)
					{
						1 {windowsUpdate}
						2 {networkIssue}
						3 {systemFiles}
						4 {slowDisk}
						5 {taskStart}
						6 {newApp}
						7 {diskError}
						8 {programExit}
					}
			}
			else {
				$validInteger = $false
			}
		} while (-not $validInteger)
}

<# Fixes:
-Updates stuck at a certain percentage
-Endless "Checking for updates"
-Update install failures
#>
function windowsUpdate{
	do {
		Write-Output ""
		$updateFix = Read-Host "1. Do you want to fix Windows Update[Y/N]?"
		if ($updateFix -eq "Y") {
			Write-Output ""
			Write-Output "Fixing Windows Update."
			Stop-Service wuauserv -Force
			Stop-Service bits -Force
			Remove-Item -Path "C:\Windows\SoftwareDistribution" -Recurse -Force
			Start-Service wuauserv
			Start-Service bits
			mainMenu
		} 
		elseif ($updateFix -eq "N") {
			Write-Output "Returning to Main Menu..."
			mainMenu
		}
		else {
			Write-Output "Invalid input. Please enter Y or N."
			$validInput = $false
		}
	} while (-not $validInput)
	$validInput = $false
}

<# Fixes:
-No internet
-DNS errors
-Slow or unstable connection
#>

function networkIssue{
	do {
		Write-Output ""
		$networkFix = Read-Host "2. Do you want to fix network issues[Y/N]?"
		if ($networkFix -eq "Y") {
			Write-Output "Beginning network fixes..."
			netsh winsock reset #Fixes Winsock API using NetDhell utility
			netsh int ip reset #Resets TCP/IP using NetShell utility
			ipconfig /flushdns #Flushes cached DNS addresses
			mainMenu
		} 
		elseif ($networkFix -eq "N") {
			Write-Output ""
			Write-Output "Returning to Main Menu..."
			mainMenu
		}
		else {
			Write-Output "Invalid input. Please enter Y or N."
			$validInput = $false
		}
	} while (-not $validInput)
	$validInput = $false
}

<# Fixes:
-Random crashes
-Missing .dll errors
-Windows features not working
#>

function systemFiles{
	do {
		Write-Output ""
		$systemFix = Read-Host "3. Do you want to fix system files[Y/N]?"
		if ($systemFix -eq "Y") {
			Write-Output ""
			Write-Output "Running sfc/ scannow..."
			sfc /scannow
			mainMenu
		} 
		elseif ($systemFix -eq "N") {
			Write-Output "Returning to Main Menu..."
			mainMenu
		}
		else {
			Write-Output "Invalid input. Please enter Y or N."
			$validInput = $false
		}
	} while (-not $validInput)
	$validInput = $false
}

<# Fixes:
-Low disk space
-Slow performance
#>

function slowDisk{
	do {
		Write-Output ""
		$tempFix = Read-Host "4. Do you want to free space by deleting temp files[Y/N]?"
		if ($tempFix -eq "Y") {
			Write-Output ""
			Write-Output "Deleting temporary files..."
			Remove-Item "$env:TEMP\*" -Recurse -Force #Deletes all temp files even in subdirectories
			$validInput = $true
			mainMenu
		} 
		elseif ($tempFix -eq "N") {
			Write-Output "Returning to Main Menu..."
			mainMenu
		}
		else {
			Write-Output "Invalid input. Please enter Y or N."
			$validInput = $false
		}
	} while (-not $validInput)
	$validInput = $false
}

<# Fixes:
-Taskbar freezes
-Start menu won't open
#>

function taskStart{
	do {
		Write-Output ""
		$taskbarFix = Read-Host "5. Do you want to fix taskbar and start menu[Y/N]?"
		if ($taskbarFix -eq "Y") {
			Write-Output ""
			Write-Output "Restarting taskbar..."
			Stop-Process -Name explorer -Force
			mainMenu
		} 
		elseif ($taskbarFix -eq "N") {
			Write-Output "Returning to Main Menu..."
			mainMenu
		}
		else {
			Write-Output "Invalid input. Please enter Y or N."
			$validInput = $false
		}
	} while (-not $validInput)
	$validInput = $false
}

<#
-Updates any applications installed to their latest version
#>

function newApp{
	do {
		Write-Output ""
		$appUpdate = Read-Host "6. Do you want to update all Applications[Y/N]?"
		if ($appUpdate -eq "Y") {
			Write-Output ""
			Write-Output "Updating applications."
			winget upgrade --all
			mainMenu
		} 
		elseif ($appUpdate -eq "N") {
			Write-Output "Returning to Main Menu..."
			mainMenu
		}
		else {
			Write-Output "Invalid input. Please enter Y or N."
			$validInput = $false
		}
	} while (-not $validInput)
	$validInput = $false
}

<# Fixes:
-Fixes slow drive
-File issues
#>

function diskError{
	do {
		Write-Output ""
		$diskFix = Read-Host "7. Do you want to fix disk errors[Y/N]?"
		if ($diskFix -eq "Y") {
			Write-Output ""
			Write-Output "Checking disk for errors."
			chkdsk C: /f /r
			mainMenu
		} 
		elseif ($diskFix -eq "N") {
			Write-Output "Returning to Main Menu..."
			mainMenu
		}
		else {
			Write-Output "Invalid input. Please enter Y or N."
			$validInput = $false
		}
	} while (-not $validInput)
	$validInput = $false
}

function programExit {
Write-Output ""
Write-Output "Program terminated..."
Write-Output ""
exit
}

mainMenu




