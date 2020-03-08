Connect-AzAccount
$sub = (get-AzSubscription -Tenantid "confidential").Name
foreach ($s in $sub){
Select-AzSubscription $s
$apiservice=Get-AzResource | ? {$_.ResourceType -match "Microsoft.ApiManagement/service"} |select *
$obj=@()
$results=@()
foreach($a in $apiservice){
$obj =New-object psobject
$obj | Add-Member -MemberType noteproperty -name "Sku" -Value $a.Sku.Name
$obj | Add-Member -MemberType noteproperty -name "name" -Value $a.name
$obj | Add-Member -MemberType noteproperty -name "RG" -Value $a.ResourceGroupName
$obj | Add-Member -MemberType noteproperty -name "subscription" -Value $s
$results+=$obj
}
$results | Export-Csv c:\temp\withoplus.csv -Append
}