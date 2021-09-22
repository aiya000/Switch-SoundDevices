# See devices names by `Get-AudioDevice -List` if you want
[string]$InputDevice = 'VB-Audio Virtual Cable'
[string]$OutputDevice = 'Oculus Virtual Audio Device'

# Get-AudioDevice -List

try {
  $env:PSModulePath += ";$(Convert-Path .)"
  Import-Module SetAudioDeviceByName -ErrorAction Stop

  SetAudioDeviceByName 'Recording' $InputDevice
  Write-Output "A recording (mic) device set: $InputDevice"
  Write-Output '- - - - -'
  Write-Output ''

  SetAudioDeviceByName 'Playback' $OutputDevice
  Write-Output "A Playback (speaker) device set: $OutputDevice"
  Write-Output '- - - - -'
  Write-Output ''
} catch {
  Write-Output $_
}

Read-Host 'Press enter to close'
