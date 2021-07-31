# See devices names by `Get-AudioDevice -List` if you want
[string]$InputDevice = 'VB-Audio Virtual Cable'
[string]$OutputDevice = 'Oculus Virtual Audio Device'

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
