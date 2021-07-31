# See devices names by `Get-AudioDevice -List` if you want
[string]$InputDevice = 'WUP-021-0'
[string]$OutputDevice = '4- USB Audio Device'

# Get-AudioDevice -List

try {
  $env:PSModulePath += ";$(Convert-Path .)"
  Import-Module SetAudioDeviceByName -ErrorAction Stop

  Write-Output "Will: SetAudioDeviceByName Recording '$InputDevice'"
  SetAudioDeviceByName 'Recording' $InputDevice

  Write-Output "Will: SetAudioDeviceByName Playback '$OutputDevice'"
  SetAudioDeviceByName 'Playback' $OutputDevice
} catch {
  Write-Output $_
}
