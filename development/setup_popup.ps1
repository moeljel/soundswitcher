Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
Add-Type -AssemblyName PresentationFramework

$form = New-Object System.Windows.Forms.Form
$form.Text = 'Select the output devices'
$form.Size = New-Object System.Drawing.Size(600,250)
$form.StartPosition = 'CenterScreen'

$okButton = New-Object System.Windows.Forms.Button
$okButton.Location = New-Object System.Drawing.Point(220,120)
$okButton.Size = New-Object System.Drawing.Size(75,23)
$okButton.Text = 'OK'
$okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $okButton  
$form.Controls.Add($okButton)

$cancelButton = New-Object System.Windows.Forms.Button
$cancelButton.Location = New-Object System.Drawing.Point(300,120)
$cancelButton.Size = New-Object System.Drawing.Size(75,23)
$cancelButton.Text = 'Cancel'
$cancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form.CancelButton = $cancelButton
$form.Controls.Add($cancelButton)

$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10,20)
$label.Size = New-Object System.Drawing.Size(280,20)
$label.Text = 'Output 1:'
$form.Controls.Add($label)

$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(290,20)
$label.Size = New-Object System.Drawing.Size(280,20)
$label.Text = 'Output 2:'
$form.Controls.Add($label)

$listBox = New-Object System.Windows.Forms.ListBox
$listBox.Location = New-Object System.Drawing.Point(10,40)
$listBox.Size = New-Object System.Drawing.Size(260,20)
$listBox.Height = 80
$items = Get-AudioDevice -list | Select-Object -ExpandProperty Name

foreach ($item in $items){
    $listBox.Items.Add($item)
}

$form.Controls.Add($listBox)

$form.Topmost = $true

$listBox2 = New-Object System.Windows.Forms.ListBox
$listBox2.Location = New-Object System.Drawing.Point(290,40)
$listBox2.Size = New-Object System.Drawing.Size(260,20)
$listBox2.Height = 80

foreach ($item in $items){
    $listBox2.Items.Add($item)
}

$form.Controls.Add($listBox2)

$form.Topmost = $true
$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(240, 155)
$label.Size = New-Object System.Drawing.Size(280,20)
$label.Text = 'Execute Switch after set up'
$form.Controls.Add($label)

$checkBox1 = New-Object System.Windows.Forms.CheckBox
$checkBox1.Location = New-Object System.Drawing.Point(220,150)
$form.Controls.Add($checkBox1)


$label_version = New-Object System.Windows.Forms.Label
$label_version.Location = New-Object System.Drawing.Point(250, 180)
$label_version.Size = New-Object System.Drawing.Size(100,20)
$label_version.Text = 'Version 0.0.1'
$form.Controls.Add($label_version)

function Show-Dialog {
    $result = $form.ShowDialog()
    
    if ($result -eq [System.Windows.Forms.DialogResult]::Cancel)
    {
        exit
    }
    
    if ($result -eq [System.Windows.Forms.DialogResult]::OK)
    {
        $device1 = $listBox.SelectedItem
        $device2 = $listBox2.SelectedItem
    }

    if ($device1 -eq $device2)
    {
        $errorMessage = [System.Windows.MessageBox]::Show('Devices can not be the same!','Same output selected','OK','Error')
        switch ($errorMessage){
            'OK' {
                Show-Dialog
            }
        }
    } else {
        $device1 > choices.txt
        $device2 >> choices.txt
        if ($checkBox1.Checked) {
            Write-Output "checked"
            powershell .\SoundSwitch.ps1
        }
    }
}
Show-Dialog