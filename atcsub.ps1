$login = 'https://atcoder.jp/login'
$res=Invoke-WebRequest $login -SessionVariable 'Session'
$var=$res.Headers['Set-Cookie']
$var=$var.split(";")
$start=$var[4].IndexOf("csrf_token")+10
$csrf_token=$var[4].Substring($start)
$Body=@{
    username= 'abhishekmittal15'
    password= 'Abhi964!!'
    csrf_token= $csrf_token
}
$loginResponse=Invoke-WebRequest $login -WebSession $Session -Body $Body -Method 'POST'
Write-Host $loginResponse