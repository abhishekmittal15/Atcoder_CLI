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