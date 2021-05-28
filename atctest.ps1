g++ sol.cpp 2> err.txt
$val=[String]::IsNullOrWhiteSpace((Get-Content err.txt))
if($val -eq $true){
    Write-Host 'Compiled Successfully'
}
else{
    Get-Content err.txt
    exit
}
$var=(Get-ChildItem in* | Measure-Object).Count
Write-Host "There are $var testcase(s)"
for($num=1;$num -le $var;$num++){
    $infile="in$num.txt"
    $outfile="out$num.txt"
    $myout="myout$num.txt"
    cmd /C ".\a.exe<$infile>$myout"
    $val=[String]::IsNullOrWhiteSpace((Get-Content $myout))
    Write-Host "Testcase$num" -ForegroundColor Blue
    $flag=-1;
    if($val -eq $true){
        $flag=1
    }
    else{
        Compare-Object (Get-Content $outfile) (Get-Content $myout) > comparison.txt
        $val=[String]::IsNullOrWhiteSpace((Get-Content .\comparison.txt))
        if($val -eq $false){
            $flag=2  
        }
        else{
            $flag=3
        }
        Remove-Item comparison.txt
    }
    if($flag -eq 1){
        Write-Host "Your code didnt produce any output" -ForegroundColor Yellow
    }
    elseif ($flag -eq 2) {
        Write-Host "Failed" -ForegroundColor Red
    }
    elseif ($flag -eq 3) {
        Write-Host "Passed" -ForegroundColor Green 
    }
    else{
        Write-Host "Unknown Error occured" -ForegroundColor Brown
    }
   Remove-Item "myout$num.txt"
   Write-Host "---------"
}
Remove-Item a.exe
Remove-Item err.txt 