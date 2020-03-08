#The below mentioned scripts helps to remove users from AAD using foreach loop and nested ifelse.
$data=import-csv -path "C:\Users\azureadmin\Desktop\Final Script\UserReport.csv"
 
foreach($d in $data)
{

$checker=Get-AzRoleAssignment -IncludeClassicAdministrators -SignInName $d.SignInName

if($checker.length -EQ 0)
{
$d |select -Property Scope, Displayname, SignInname, RoleDefinitionName, @{name="Status";expression={"User not found"}} | Export-CsV  -path "C:\Users\azureadmin\Desktop\Final Script\report.csv" -Append -NoTypeInformation
}
else
{
Remove-Azroleassignment -Scope $scope -Signinname $d.SignInName -RoleDefinitionName $d.RoleDefinitionName
$checkuser2 = Get-AzRoleAssignment -IncludeClassicAdministrators -SignInName $d.SignInName
if($checkuser2.SignInName -eq $d.SignInName)
{
$d|select -Property Scope, Displayname, SignInname, RoleDefinitionName, @{name="status";expression={"Failed to delete the user"}}| Export-csv  "C:\Users\azureadmin\Desktop\Final Script\report.csv" -Append -NoTypeInformation
}
else
{
$d|select -Property Scope, Displayname, SignInname, RoleDefinitionName, @{name="status";expression={"Removal success"}}| Export-csv  "C:\Users\azureadmin\Desktop\Final Script\report.csv" -Append -NoTypeInformation
}
}
}

 