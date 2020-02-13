Import-Module ActiveDirectory

$UserList = Get-Content "D:\Scripts\userlist.txt" 
$GroupNames = "GROUP1 GROUP2"

ForEach ($GroupName in $GroupNames.split(" ")) {
  $Members = Get-ADGroupMember -Identity $GroupName -Recursive | Select -ExpandProperty SAMAccountName 
  ForEach ($user in $UserList) {
    If ($Members -contains $user) {
      Write-Host "$user is already member of $GroupName." 
    }
    Else { 
      Write-Host "Adding $user to $GroupName."
      Add-ADGroupMember -Identity $GroupName -Members $User 
    }
 }
}


