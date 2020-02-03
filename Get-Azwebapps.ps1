<#Running this script will fetch all the details for Azure Web apps #>

Import-module Az
Connect-AzAccount
Get-AzSubscription
Select-AzSubscription -Tenantid "a384ed05-4d66-4ce7-937d-3dab0fb2d8d4"
$subs=(Get-AzSubscription -Tenantid "a384ed05-4d66-4ce7-937d-3dab0fb2d8d4").name
foreach($s in $subs){
Select-AzSubscription -SubscriptionName $s
Get-AzWebApp |select *, @{name="subscriptionname"; expression={$s}} | Export-Csv -Path c:\temp\webappdetails.csv -Append -NoTypeInformation
}