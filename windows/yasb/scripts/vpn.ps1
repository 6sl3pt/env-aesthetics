[Console]::OutputEncoding = [System.Text.UTF8Encoding]::new($false)
$ProgressPreference = 'SilentlyContinue'

$vpn = & 'C:\Program Files (x86)\Cisco\Cisco Secure Client\vpncli.exe' status 2>&1 | Select-String 'state: Connected'

if ($vpn) {
  $icon = [char]::ConvertFromUtf32(0xF0565)
  $connection = "Connected"
} else {
  $icon = [char]::ConvertFromUtf32(0xF099E)
  $connection = "Disconnected"
}

$output = @{
  icon = $icon
  connection = $connection
}

$output | ConvertTo-Json -Compress | Write-Output
