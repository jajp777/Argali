#KEEP THIS NEXT LINE, ONLY CHANGE IP:PORT, NO SPACES#
#Broker=192.168.1.245:9000
#IPPORT=192.168.1.245:9001
#IPType=Standard

$foldername = $MyInvocation.MyCommand.Name.split(".")[0]

& $($("$path/scripts/$foldername/" + "$($Post.codeset)" + ".ps1"))
if (!$global:message){$global:message = "SubScript Invalid or Null"}		
# Get-Variable * | % {$("$($_.name)" + " = " + "$($_.value)")} > ./logs\debugAgraliSubModule.log
