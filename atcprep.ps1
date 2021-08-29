$contest_name = $null
$contest_name=Read-Host("Enter the Contest Name")
mkdir $contest_name > $null
Set-Location $contest_name
$base_url = 'http://atcoder.jp'
$endpoint = '/contests/' + $contest_name + '/tasks'
$website = $base_url + $endpoint
$user="abhishekmittal15"
$pass="Abhi964!!"
$login = "https://atcoder.jp/login"
$res1 = Invoke-WebRequest $login -SessionVariable Sess
$csrf = $res1.InputFields[0].value;
$params = @{
    "username"   = $user;
    "password"   = $pass;
    "csrf_token" = $csrf;
}
$res = Invoke-WebRequest $login -Method POST -Body $params -WebSession $Sess
$res= Invoke-WebRequest $website -WebSession $Sess

Start-Sleep -Milliseconds 200
$status = $res.StatusCode
# Write-Host $status
if ($status -ne 200) {
    Write-Host 'Unable to connect to the contest page'
    exit
}
$links=$res.Links
# Write-Host $links
$tasks=@()
foreach ($link in $links){
    if($link -like "*tasks/$contest_name*"){
        $tasks=$tasks+=$link.href
    }
}
$tasks = $tasks | Select-Object -Unique
foreach($task in $tasks){
    $website=$base_url+$task
    $res=Invoke-WebRequest $website -WebSession $Sess
    Start-Sleep -Milliseconds 100
    $res=$res.AllElements | Where-Object tagname -eq "pre"
    $start=1
    $end=$res.length/2-1
    $task_num=$task.Substring($task.length-1)
    $var=Get-Location
    $directory=$var.tostring()+"\"+$task_num
    mkdir $directory > $null
    Set-Location $directory > $null
    for ($num=$start;$num -le $end;$num++){
        $content=$res[$num].innerText
        if(($num%2) -eq 1){
            [int] $index=$num/2.1
            $index++
            $input_filename="in$index.txt"
            Set-Content $input_filename $content 
        }
        else{
            [int] $index=$num/2
            $output_filename="out$index.txt"
            Set-Content $output_filename $content
        }
    }
    Set-Location .. > $null
}