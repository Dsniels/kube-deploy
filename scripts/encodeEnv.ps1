$content = Get-Content ..\.env  

foreach ($line in $content) {
    $split = $line.Split("=") 
    $key = $split[0]
    $split = $split | ForEach-Object {
        $_.Trim()
    }
    $len = $split.Length
    $value = $split[1.. ($len - 1)] -join "="
    Write-Host $value
    $bytes = [System.Text.Encoding]::UTF8.GetBytes($value)
    $encoded = [System.Convert]::ToBase64String($bytes)
    Add-Content ..\secrets.yml -Value "$key : $encoded"
}

