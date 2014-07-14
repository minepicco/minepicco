Connect-VIServer -Server <vcaddress> -User <vcuser> -Password <vcpassword>

$i=0 
$u=10000 # repeated until

$hosts=@("<Host_name_1>","<Host_name_2>","<Host_name_3>","<Host_name_4>")
$VMs=@("<VM_name_1>","<VM_name_2>","<VM_name_3>","<VM_name_4>")

Do
{
  $v=0
  Do
  {
    $n=0
    Do
    {
      Write-Host "Iteration: "$i
      Write-Host "Target host: "$hosts[$v]
      Write-Host "Target VM: "$VMs[$n]
      Get-VM -Name $VMs[$n] | Move-VM -Destination $hosts[$v]
      $n ++
    } Until ($n -eq 4)
    $v ++
  } Until ($v -eq 4)
  $i ++
} Until ($i -eq $u)