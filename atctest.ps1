g++ sol.cpp 2> err.txt
$val = [String]::IsNullOrWhiteSpace((Get-Content err.txt))
if ($val -eq $true) {
    Write-Host 'Compiled Successfully'
}
else {
    Get-Content err.txt
    exit
}
$var=Get-ChildItem in*
$n=$var.length
Write-Host $n
for($num=0;$num -lt $n;$num++){
    $infile="in$num.txt"
    $outfile="out$num.txt"
    $myout="myout$num.txt"
    cmd /C ".\a.exe<$infile>$myout"
    Compare-Object (Get-Content $outfile) (Get-Content $myout) > comparison.txt
    $val=[String]::IsNullOrWhiteSpace((Get-Content .\comparison.txt))
    if($val -eq $false){
        Write-Host "Failed on testcase:$num" -ForegroundColor Red
    }
    else{
        Write-Host "Passed on testcase:$num" -ForegroundColor Green 
    }
    Remove-Item "myout$num.txt"
}