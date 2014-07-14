Connect-VIServer -Server <vcaddress> -User <vcuser> -Password <vcpassword>

$i=0 
$u=10000 # repeated until

$VM="11284_win7_02"
$AdopterName="ネットワーク アダプタ 3"
$CorrectPG="vDS_PG_Management"
$WrongPG="vDS_PG_Gateway01"

Do
{
   Write-Host "Connected to right PortGroup..."
   Get-VM -Name $VM | Get-NetworkAdapter -Name $AdopterName  | Set-NetworkAdapter -NetworkName $CorrectPG -Confirm:$false
   Sleep 1800
   Get-VM -Name $VM | Get-NetworkAdapter -Name $AdopterName  | Set-NetworkAdapter -NetworkName $WrongPG2 -Confirm:$false
   Write-Host "Disconnected(30sec)"
   Sleep 30
} Until ($i -eq $u) 
