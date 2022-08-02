Add-Type -AssemblyName System.Windows.Forms

$FObject = [System.Windows.Forms.Form]
$LObject = [System.Windows.Forms.Label]
$BObject = [System.Windows.Forms.Button]

ForEach ($color in $colors)
{

}



$MainForm = New-Object $FObject
$MainForm.ClientSize= '500,300'
$MainForm.text = "Clipper Scripts"
$MainForm.BackColor = 'lightgray'

$LabelTitle = New-Object $LObject
$LabelTitle.text = "Image Device"
$LabelTitle.font = 'Verdana,10,style=bold'
$LabelTitle.AutoSize = $true
$LabelTitle.BackColor = '#ffffff'
$LabelTitle.location = New-Object System.Drawing.Point(20,20)

$ButtonOne = New-Object $BObject
$ButtonOne.text = '1'
$ButtonOne.Height = '25'
$ButtonOne.Width = '25'
$ButtonOne.font = 'Verdana,10,style=bold'
$ButtonOne.ForeColor = 'black'
$ButtonOne.BackColor = 'white'
$ButtonOne.location = New-Object System.Drawing.Point(415,20)




$MainForm.Controls.AddRange(@($LabelTitle,$ButtonOne))



function RunScript{
#list devices attached to PC
$device = '.\adb devices'

#Update path for devices/Pushes update
$upgrade = '.\adb sideload C:\HE_DELTA_UPDATE_10-16-10.00-QG-U114-STD-HEL-04.zip'

#Change into working dir (PATH WHERE ADB IS INSTALLED)
cd C:\
./adb shell settings put system screen_off_timeout 360000
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
}



$ButtonOne.Add_Click({RunScript})






$MainForm.ShowDialog((New-Object System.Windows.Forms.Form -Property @{TopMost = $true }))


$MainForm.Dispose()
