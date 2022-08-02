#list devices attached to PC
$device = '.\adb devices'

#Update path for devices/Pushes update
$upgrade = '.\adb sideload C:\HE_DELTA_UPDATE_10-16-10.00-QG-U114-STD-HEL-04.zip'

#Change into working dir (PATH WHERE ADB IS INSTALLED)
cd C:\

#verify device is attached to PC
if ($device -eq 'List of devices attached'){
    echo "it works"
} 
else{
    echo "not working"
}

#Reboots device into recovery for Upgrade
$recovery = '.\adb reboot recovery'
Invoke-Expression $recovery



#If verified applys image to device from C:\HE_x_UPDATE_x-x-x.x-x-x-x-x-x.zip
do{
    $verify = Read-Host("Press Y to continue with Image")
if($verify.ToLower().Equals("y")){
    Invoke-Expression $upgrade
  }
elseif ($verify.ToLower().Equals("n")) {
exit(0)
}
   }while (!$verify.ToLower().Equals("y"))


#install Needed APKs(based on which device you're setting up) EHS and EB & Vel for Scangun
   do{
    $verify = Read-Host("Press 1 for Scangun and 2 for Wearable for needed APKs")
if($verify.Equals("1")){
    .\adb push 'C:\ADB\EnterpriseBrowser\EnterpriseBrowser_signed_3.0.0.1.apk' '/sdcard/download'
    .\adb push 'C:\ADB\EnterpriseHomeScreen\EHS_040005.apk' '/sdcard/download'
    .\adb push 'C:\ADB\Velocity\Velocity Client\Velocity_ARM_2.1.20.21270.2058693.apk' '/sdcard/download'
  }
elseif ($verify.Equals("2")) {
    .\adb push 'C:\ADB\EnterpriseHomeScreen\EHS_040005.apk' '/sdcard/download'
    .\adb push 'C:\ADB\Velocity\Velocity Client\Velocity_ARM_2.1.20.21270.2058693.apk' '/sdcard/download'
}
   }while (!$verify.Equals("1") -and (!$verify.Equals("2")))
  

#Verify you have went into needed apps to create dir for config, script will then apply config file for velocity,EHS,and EB (based on which device you're setting up)

do{
    $verify = Read-Host("Launch Applications in downloads on device `n this will create the config dir for the apps. `n Press Y when files are created")
if($verify.ToLower().Equals("y")){
    echo "continue"
    }

   }while (!$verify.ToLower().Equals("y"))


   do{
    $verify = Read-Host("Press 1 for Scangun and 2 for Wearable for needed config")
if($verify.Equals("1")){
    .\adb push 'C:\ADB\xml\MC9300\enterprisehomescreen.xml' '/enterprise/usr/enterprisehomescreen.xml'
    .\adb push 'C:\ADB\Velocity\config\MC9300.wldep' '/sdcard/Android/data/com.wavelink.velocity/files'
    .\adb push 'C:\ADB\EnterpriseBrowser\Config.xml' '/sdcard/Android/data/com.symbol.enterprisebrowser'
  }
elseif ($verify.Equals("2")) {
    .\adb push 'C:\ADB\xml\WT6300\enterprisehomescreen.xml' '/enterprise/usr/enterprisehomescreen.xml'
    .\adb push 'C:\ADB\Velocity\config\WT6300v5.wldep' '/sdcard/Android/data/com.wavelink.velocity/files'
}
   }while (!$verify.Equals("1") -and (!$verify.Equals("2")))





#Sets fixed rotation for device
.\adb shell settings put system user_rotation 0
.\adb shell settings put system accelerometer_rotation 0

