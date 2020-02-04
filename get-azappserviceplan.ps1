Get-AzSubscription
$subs=(Get-AzSubscription -Tenantid "a384ed05-4d66-4ce7-937d-3dab0fb2d8d4").name
foreach($s in $subs){
Select-AzSubscription -SubscriptionName $s
$data=Get-AzAppServicePlan|select *,@{name="subscriptionname";expression={$s}} #|export-csv -path c:\temp\allappserviceplandata.csv -Append -NoTypeInformation

$obj=@()
$result=@()
foreach($d in $data)
{
$obj=new-object psobject 
$obj |Add-Member -MemberType NoteProperty -Name name -Value $d.Name
$obj|Add-Member -MemberType NoteProperty -Name skuname -Value $d.sku.name
$obj|Add-Member -MemberType NoteProperty -Name size -Value $d.sku.size
$obj|Add-Member -MemberType NoteProperty -Name subscriptionname -Value $s
$result+=$obj
}
$result |export-csv -path c:\temp\azureappserverplanwithsku.csv -Append -NoTypeInformation
}










