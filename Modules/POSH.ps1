#KEEP THIS NEXT LINE, ONLY CHANGE IP:PORT, NO SPACES#
#Broker=172.26.0.178:9010
#IPPORT=172.26.0.178:9011
#IPType=Standard

$foldername = $MyInvocation.MyCommand.Name.split(".")[0]

& $($("$path/scripts/$foldername/" + "$($Post.codeset)" + ".ps1"))
if (!$global:message){$global:message = "SubScript Invalid or Null"}		
# Get-Variable * | % {$("$($_.name)" + " = " + "$($_.value)")} > ./logs\debugAgraliSubModule.log
