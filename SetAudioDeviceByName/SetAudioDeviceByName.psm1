using namespace System.IO

try {
  Import-Module AudioDeviceCmdlets -ErrorAction Stop
} catch [FileNotFoundException] {
  Write-Output 'AudioDeviceCmdlets.dll not found.'
  Write-Output 'Did you execute Setup.ps1?'
  Write-Output ''
  Write-Output 'Please README.md.'
  Return
}

# Get-AudioDevice -List
# Get-Help Set-AudioDevice
# return

function SetAudioDeviceByName([string]$ioType, [string]$device) {
  if (@('Playback', 'Recording') -notcontains $ioType) {
    throw "ioType must be 'Playback' or 'Recording': '$ioType'"
  }

  $info =
    try {
      Get-AudioDevice -List | Where-Object {
        $_.Type -eq $ioType -and
        $_.Name -match "[^\s]+ \($device\)"
      } | Select-Object -Index 0
    } catch [ParameterArgumentValidationError] {
      ThrowDeviceNotFoundMessage $ioType $device
    }

  if ($null -eq $info) {
    ThrowDeviceNotFoundMessage $ioType $device
  }

  Set-AudioDevice -Index $info.Index
}

Export-ModuleMember SetAudioDeviceByName

function ThrowDeviceNotFoundMessage(
  [Parameter(Mandatory)][string]$ioType,
  [Parameter(Mandatory)][string]$device
) {
  throw "The device not found:'$device' of the type '$ioType'"
}
