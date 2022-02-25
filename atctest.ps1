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
    $message="Unknown error occured"
    $color="Brown"
    if($val -eq $true){
        $message="Your code didnt produce any output" 
        $color="Yellow"
    }
    else{
        Compare-Object (Get-Content $outfile) (Get-Content $myout) > comparison.txt
        $val=[String]::IsNullOrWhiteSpace((Get-Content .\comparison.txt))
        if($val -eq $false){
            $message="Failed" 
            $color="Red"  
        }
        else{
            $message="Passed" 
            $color="Green"
        }
        Remove-Item comparison.txt
    }
    Write-Host "Testcase$num :  $message" -ForegroundColor $color
	Write-Host "Input"
	Get-Content $infile
	Write-Host "---------"
	Write-Host "Expected Output"
	Get-Content $outfile
	Write-Host "---------"
	Write-Host "My Output"
	Get-Content $myout
	Write-Host "---------"
    Remove-Item "myout$num.txt"
}
Remove-Item a.exe
Remove-Item err.txt 
