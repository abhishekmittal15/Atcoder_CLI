g++ sol.cpp 2> err.txt
$val = [String]::IsNullOrWhiteSpace((Get-Content err.txt))
if ($val -eq $true) {
    Write-Host 'Compiled Successfully'
}
else {
    Get-Content err.txt
    exit
}