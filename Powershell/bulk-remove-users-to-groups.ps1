Import-Module ActiveDirectory

$UserList = Get-Content "D:\Scripts\userlist.txt" 
$GroupNames = "GROUP1 GROUP2"

ForEach ($GroupName in $GroupNames.split(" ")) {
  $Members = Get-ADGroupMember -Identity $GroupName -Recursive | Select -ExpandProperty SAMAccountName 
  ForEach ($user in $UserList) {
    If ($Members -contains $user) {
      Write-Host "$user is member of $GroupName." 
      Remove-ADGroupMember -Identity $GroupName -Members $User 
    }
    Else { 
      Write-Host "$user is not member of to $GroupName."
    }
 }
}


