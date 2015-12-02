#KEEP THIS NEXT LINE, ONLY CHANGE IP:PORT, NO SPACES#
#Broker=192.168.1.245:443
#IPPORT=192.168.1.245:9000
#IPType=Standard

$esConfig = gc -raw ./configs/elasticConfig.json | convertfrom-json
$timerWait = 300

$foldername = $MyInvocation.MyCommand.Name.split(".")[0]
$path = $($("$path/scripts/$foldername/" + "$($Post.codeset)" + ".ps1"))

$scriptBlock = [Scriptblock]::Create($(gc -raw $path))
$jobID = (start-job -scriptBlock $scriptBlock).childjobs
$state = $jobID.JobStateInfo.state
$json = "{`"codeSet`": `"$foldername/$($Post.codeset)`",`"startTime`": `"$($jobID.PSBeginTime)`"}"

$elasticID = (invoke-restmethod "http://es.pixelrebirth.local:9200/$($esConfig.mixJobs)/" -method POST -body $json)._id
$outelasticID = "{`"elasticID`": `"$elasticID`"}"
$global:response.ContentType = 'application/json'
[byte[]] $buffer = [System.Text.Encoding]::UTF8.GetBytes($outelasticID)
$global:response.ContentLength64 = $buffer.length
$global:response.OutputStream.Write($buffer, 0, $buffer.length)
$global:response.Close()

while ($state -ne "Completed"){
    $json = $null
    $json = "{`"codeSet`": `"$foldername/$($Post.codeset)`",`"startTime`": `"$($jobID.PSBeginTime)`",`"output`": [`""
    foreach ($line in (($jobid.output | out-string) -split ("`n"))){
        $Line = $Line.substring(0,$Line.length-1).trim()
        $json += "$Line"+"Aw3s0m3"
    }
    $json = $json + "`"]}"

    invoke-restmethod "http://es.pixelrebirth.local:9200/$($esConfig.mixJobs)/$elasticID" -method POST -body $(ConvertTo-ElasticJson $json)

    $state = $jobID.JobStateInfo.state
    start-sleep -milliseconds $timerWait
}

$json = $json.substring(0,$json.length-1) + ", `"endTime`": `"$($jobID.PSEndTime)`"}"
invoke-restmethod "http://es.pixelrebirth.local:9200/$($esConfig.mixJobs)/$elasticID" -method POST -body $(ConvertTo-ElasticJson $json)
# ConvertTo-ElasticJson $json >> ./Logs/json.json