Add-Type -AssemblyName System.Windows.Forms

$Form = New-Object system.Windows.Forms.Form
$Form.Text = "Wana Decrypt0r 2.0"
$Form.TopMost = $true
$Form.Width = 1050
$Form.Height = 814
$Form.FormBorderStyle = 'Fixed3D'

$Image = [system.drawing.image]::FromFile("wannacry_05_1024x774.png")
$Form.BackgroundImage = $Image
$Form.BackgroundImageLayout = "Center"
[void]$Form.ShowDialog()
#$Form.controls.Add($PictureBox2)

$Form.Dispose()
