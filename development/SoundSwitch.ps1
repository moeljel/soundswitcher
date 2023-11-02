# Script made by Mohamed El Jelali
Add-Type -AssemblyName PresentationFramework
$checkFileExist = Test-Path -Path .\choices.txt -PathType Leaf

if (!$checkFileExist){
   powershell .\setup_popup.ps1
} else {
   function Switch-Sound {
      $device1 = Get-Content choices.txt -First 1
      $device2 = Get-Content choices.txt -Tail 1
      
      $Audio = Get-AudioDevice -playback
      
      if ($Audio.Name.Contains($device1)) {
         (Get-AudioDevice -list | Where-Object Name -like ("$device2*") | Set-AudioDevice).Name
      }
      if ($Audio.Name.Contains($device2)) {
         (Get-AudioDevice -list | Where-Object Name -like ("$device1*") | Set-AudioDevice).Name
      } 
      if (!$Audio.Name.Contains($device1) -and !$Audio.Name.Contains($device2)) {
         [System.Windows.MessageBox]::Show('The playback device is not any of the set up devices.','Unknown playback device','OK','Error')
      }
     
      $currentDevice = (Get-AudioDevice -playback).Name
      
      [reflection.assembly]::loadwithpartialname("System.Windows.Forms")
      [reflection.assembly]::loadwithpartialname("System.Drawing")
      $notify = new-object system.windows.forms.notifyicon
      $notify.icon = [System.Drawing.SystemIcons]::Information
      $notify.visible = $true
      $var = "Output device switched to $currentDevice."
      
      $notify.showballoontip(10,"Ouput device switched!", $var, [system.windows.forms.tooltipicon]::None)
   }
   Switch-Sound
}