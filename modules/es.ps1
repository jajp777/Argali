#KEEP THIS NEXT LINE, ONLY CHANGE IP:PORT, NO SPACES#
#Broker=192.168.1.245:443
#IPPORT=192.168.1.245:9010
#IPType=Standard

$esConfig = gc -raw ./configs/elasticConfig.json | convertfrom-json

$foldername = $MyInvocation.MyCommand.Name.split(".")[0]
& $($("$path/scripts/$foldername/" + "$($Post.codeset)" + ".ps1"))
