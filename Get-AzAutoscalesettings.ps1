<#This script will fetch all web app details and auto scaling settings for azure web apps#>
Connect-AzAccount
Get-AzSubscription
Select-AzSubscription -Tenantid "a384ed05-4d66-4ce7-937d-3dab0fb2d8d4"
$subs=(Get-AzSubscription -Tenantid "a384ed05-4d66-4ce7-937d-3dab0fb2d8d4").name
foreach($s in $subs){
Select-AzSubscription -SubscriptionName $s
Get-AzWebApp |select *, @{name="subscriptionname"; expression={$s}} | Export-Csv -Path c:\temp\webappdetailslatest.csv -Append -NoTypeInformation
$data= import-csv -path c:\temp\webappdetailslatest.csv
foreach($d in $data){
Select-AzSubscription -SubscriptionName $d.subscriptionname
Get-AzAutoscaleSetting -ResourceGroupName $d.ResourceGroup|select *, @{name="subscriptionname";expression={$d.subscriptionname}} | export-csv c:\temp\autoscalingstatus.csv -Append 
}
}