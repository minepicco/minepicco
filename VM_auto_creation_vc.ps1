#Add-PSSnapin VMWare.VimAutomation.Core
Connect-VIServer -Server <vcaddress> -User <vcuser> -Password <vcpassword>

$sourceVM = Get-VM "pg2_template" | Get-View
$i=1
$u=201
$cloneFolder = $sourceVM.parent
$cloneSpec = new-object Vmware.Vim.VirtualMachineCloneSpec
$cloneSpec.Location = new-object Vmware.Vim.VirtualMachineRelocateSpec
#$cloneSpec.Location.DiskMoveType = [Vmware.Vim.VirtualMachineRelocateDiskMoveOptions]::createNewChildDiskBacking

Do
{
  $cloneName="clonetest_"+$i
  $sourceVM.CloneVM_Task( $cloneFolder, $cloneName, $cloneSpec )
  $i ++
} Until ($i -eq $u)