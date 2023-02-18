$domain = Read-Host "Enter Domain Name to scan"
$ports = Read-Host "Enter port range to scan (e.g 1-1000)"

$start_port_no = [int]$ports.Split("-")[0]
$end_port_no = [int]$ports.Split("-")[1]

$ip = (Resolve-DnsName $domain -ErrorAction Stop)[1].IPAddress

Write-Host "Scanning Ports of $domain : $ip [$start_port_no -- $end_port_no] "

for ($port = $start_port_no; $port -lt $end_port_no; $port++) {
    $socket = New-Object System.Net.Sockets.TcpClient
    $connection = $socket.BeginConnect($ip, $port, $null, $null)

    $wait = $connection.AsyncWaitHandle.WaitOne(1000, $false)

    if ($wait -and $socket.Connected) {
        Write-Host "Port $port is Open" -ForegroundColor Cyan
        $socket.Close()
    }
    else {
        Write-Host "Port $port is Closed"
    }
}