#!/usr/bin/env pwsh

function Get-BatteryCharge {
    <#
    .SYNOPSIS
        Gets the current battery charge percentage and status information.
    
    .DESCRIPTION
        This function retrieves battery charge information from the system including
        percentage remaining, charging status, and estimated time remaining.
    
    .PARAMETER Format
        Specifies the output format. Valid values are:
        - "Detailed" (Default): Shows all battery information in a formatted table
        - "Simple": Shows only the charge percentage
        - "Object": Returns the raw battery objects
    
    .EXAMPLE
        Get-BatteryChargeComprehensive
        
        Returns detailed battery information in a formatted table.
    
    .EXAMPLE
        Get-BatteryChargeComprehensive -Format Simple
        
        Returns only the battery charge percentage.
    
    .EXAMPLE
        Get-BatteryChargeComprehensive -Format Object
        
        Returns the raw battery objects for further processing.
    #>
    
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [ValidateSet("Detailed", "Simple", "Object")]
        [string]$Format = "Detailed"
    )
    
    # Check if running on Windows
    if (-not $IsWindows -and -not ($PSVersionTable.PSEdition -eq "Desktop")) {
        Write-Error "This function is only supported on Windows systems."
        return
    }
    
    try {
        # Get battery information using WMI
        $batteries = Get-WmiObject -Class Win32_Battery -ErrorAction Stop
        
        if ($null -eq $batteries -or @($batteries).Count -eq 0) {
            Write-Warning "No battery detected. This might be a desktop computer or the battery information is unavailable."
            return
        }
        
        # Process each battery
        $batteryData = foreach ($battery in $batteries) {
            $status = switch ($battery.BatteryStatus) {
                1 { "Discharging" }
                2 { "AC Power" }
                3 { "Fully Charged" }
                4 { "Low" }
                5 { "Critical" }
                6 { "Charging" }
                7 { "Charging and High" }
                8 { "Charging and Low" }
                9 { "Charging and Critical" }
                10 { "Undefined" }
                11 { "Partially Charged" }
                default { "Unknown" }
            }
            
            # Calculate estimated time remaining in minutes
            $estimatedMinutes = $battery.EstimatedRunTime
            if ($estimatedMinutes -eq 71582788) {
                $timeRemaining = "Unknown/Plugged In"
            } else {
                $hours = [math]::Floor($estimatedMinutes / 60)
                $minutes = $estimatedMinutes % 60
                $timeRemaining = "$hours hours, $minutes minutes"
            }
            
            [PSCustomObject]@{
                'Name' = $battery.Name
                'Description' = $battery.Description
                'Percentage' = $battery.EstimatedChargeRemaining
                'Status' = $status
                'TimeRemaining' = $timeRemaining
                'DesignCapacity' = $battery.DesignCapacity
                'FullChargeCapacity' = $battery.FullChargeCapacity
                'BatteryObject' = $battery
            }
        }
        
        # Return based on format parameter
        switch ($Format) {
            "Simple" {
                # Return just the battery percentage as a number
                return $batteryData[0].Percentage
            }
            "Object" {
                # Return the raw battery data objects
                return $batteryData
            }
            default {
                # Return formatted detailed view
                $result = $batteryData | Format-Table -Property Name, Percentage, Status, TimeRemaining -AutoSize
                
                # Add a summary line
                $summaryText = "Battery Status: $($batteryData[0].Status) | Charge: $($batteryData[0].Percentage)% | $($batteryData[0].TimeRemaining) remaining"
                
                # Return both the table and summary
                return $result, "`n$summaryText"
            }
        }
    }
    catch {
        Write-Error "Error retrieving battery information: $_"
    }
}

# Execute the function with default parameters when the script is run directly
if ($MyInvocation.InvocationName -eq $MyInvocation.MyCommand.Name) {
    Get-BatteryChargeComprehensive
}
