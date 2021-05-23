$directory=Get-Location 
$directory=$directory.tostring()
$dir=$directory
$directory=$directory.Split("\")
$contest_name=$directory[-2]
$problem_name=$directory[-1]

Write-Host $contest_name
$login = "https://atcoder.jp/login"
$submit="https://atcoder.jp/contests/"+$contest_name+"/submit"
$submissions="https://atcoder.jp/contests/"+$contest_name+"/submissions/me"

$res1=Invoke-WebRequest $login -SessionVariable Please
$params=@{
    "username"="abhishekmittal15";
    "password"="Abhi964!!";
    "csrf_token"=$res1.InputFields[0].value
}
$res2=Invoke-WebRequest $login -Method POST -Body $params -WebSession $Please
$res2.RawContent
$res3=Invoke-WebRequest $submit -WebSession $Please
$params=@{
    "data.TaskScreenName"=$contest_name+"_"+$problem_name;
    "data.LanguageId"="4003";
    "csrf_token"=$res1.InputFields[0].value;
    "sourceCode"=[System.IO.File]::ReadAllText($dir+"\sol.cpp");
}
$res4=Invoke-WebRequest $submit -Method POST -WebSession $Please -Body $params
$res5=Invoke-WebRequest $submissions 
$res5