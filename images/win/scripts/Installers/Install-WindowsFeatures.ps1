# Install .NET Framework 3.5 (required by Chocolatey)
# Explicitly install all 4.7 sub features to include ASP.Net.
# As of  1/16/2019, WinServer 19 lists .Net 4.7 as NET-Framework-45-Features
Write-Host "Enabling Windows Feature 'NET-Framework-Features'"
Install-WindowsFeature -Name NET-Framework-Features -IncludeAllSubFeature
Write-Host "Enabling Windows Feature 'NET-Framework-45-Features'"
Install-WindowsFeature -Name NET-Framework-45-Features -IncludeAllSubFeature

if (Test-IsWin16) {
    Install-WindowsFeature -Name BITS -IncludeAllSubFeature
    Install-WindowsFeature -Name DSC-Service
}

if (Test-IsWin16 -or Test-IsWin19) {
    # Install FS-iSCSITarget-Server
    $fsResult = Install-WindowsFeature -Name FS-iSCSITarget-Server -IncludeAllSubFeature -IncludeManagementTools
    if ( $fsResult.Success ) {
        Write-Host "FS-iSCSITarget-Server has been successfully installed"
    } else {
        Write-Host "Failed to install FS-iSCSITarget-Server"
        exit 1
    }
}

Write-Host "Enabling Windows Feature 'Containers'"
Install-WindowsFeature -Name Containers