$directory=Get-Location 
$directory=$directory.tostring()
$dir=$directory
$directory=$directory.Split("\")
$contest_name=$directory[-2]
$problem_name=$directory[-1]
$user="abhishekmittal15"
$pass="Abhi964!!"


$login = "https://atcoder.jp/login"
$submit="https://atcoder.jp/contests/"+$contest_name+"/submit"
$res1=Invoke-WebRequest $login -SessionVariable Sess
$csrf=$res1.InputFields[0].value;
$params=@{
"username"=$user;
"password"=$pass;
"csrf_token"=$csrf;
}
$res=Invoke-WebRequest $login -Method POST -Body $params -WebSession $Sess
Write-Host "Logged in Successfully"
$params=@{
"data.TaskScreenName"=$contest_name+"_"+$problem_name;
"data.LanguageId"="4003";
"csrf_token"=$csrf;
"sourceCode"=[System.IO.File]::ReadAllText($dir+"\sol.cpp");
}
Invoke-WebRequest $submit -Method POST -WebSession $Sess -Body $params > $null
Write-Host "Submitted Successfully"

