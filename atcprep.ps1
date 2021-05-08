$contest_name = $null
$contest_name=Read-Host("Enter the Contest Name")
$base_url = 'http://atcoder.jp'
$endpoint = '/contests/' + $contest_name + '/tasks'
$website = $base_url + $endpoint
$res = Invoke-WebRequest  $website 
Start-Sleep -Milliseconds 200
$status = $res.StatusCode
if ($status -ne 200) {
    Write-Host 'Unable to connect to the contest page'
    exit
}
$links=$res.Links
$tasks=@()
foreach ($link in $links){
    if($link -like "*tasks/$contest_name*"){
        $tasks=$tasks+=$link.href
    }
}
$tasks = $tasks | Select-Object -Unique
foreach($task in $tasks){
    $website=$base_url+$task
    $res=Invoke-WebRequest $website
    Start-Sleep -Milliseconds 100
    $res=$res.AllElements | Where-Object tagname -eq "pre"
    $start=1
    $end=$res.length/2-1
    $task_num=$task.Substring($task.length-1)
    $var=Get-Location
}