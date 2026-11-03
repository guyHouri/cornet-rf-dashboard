$ErrorActionPreference = "Continue"

Write-Host "Cornet RF Windows setup check (read-only)" -ForegroundColor Cyan
Write-Host ""

Write-Host "[1/4] Serial ports currently present" -ForegroundColor Yellow
$ports = Get-CimInstance Win32_SerialPort -ErrorAction SilentlyContinue |
    Select-Object DeviceID, Name, Manufacturer, PNPDeviceID
if ($ports) {
    $ports | Format-Table -AutoSize
} else {
    Write-Host "No serial ports are currently present. Connect the meter with a data cable."
}

Write-Host "[2/4] Relevant signed Plug and Play drivers" -ForegroundColor Yellow
$drivers = Get-CimInstance Win32_PnPSignedDriver -ErrorAction SilentlyContinue |
    Where-Object {
        $_.DeviceName -match "CH340|CH341|Holtek|FTDI|USB.*Serial|Serial.*USB" -or
        $_.Manufacturer -match "WCH|Holtek|FTDI"
    } |
    Select-Object DeviceName, Manufacturer, DriverVersion, InfName, IsSigned
if ($drivers) {
    $drivers | Sort-Object DeviceName -Unique | Format-Table -AutoSize
} else {
    Write-Host "No matching signed drivers were found through Win32_PnPSignedDriver."
}

Write-Host "[3/4] Driver-store matches" -ForegroundColor Yellow
$driverStore = pnputil /enum-drivers 2>$null
$matches = $driverStore | Select-String -Pattern "ch341ser|ch340|holtek|ftdi|ftdibus|ftdiport" -Context 2,4
if ($matches) {
    $matches | ForEach-Object { $_.ToString() }
} else {
    Write-Host "No CH34x, Holtek or FTDI names were found in the driver-store output."
}

Write-Host "[4/4] Tera Term" -ForegroundColor Yellow
$teraCandidates = @(
    "$env:ProgramFiles\teraterm5\ttermpro.exe",
    "${env:ProgramFiles(x86)}\teraterm5\ttermpro.exe",
    "$env:ProgramFiles\teraterm\ttermpro.exe",
    "${env:ProgramFiles(x86)}\teraterm\ttermpro.exe"
) | Where-Object { $_ -and (Test-Path -LiteralPath $_) }

if ($teraCandidates) {
    foreach ($candidate in $teraCandidates) {
        $item = Get-Item -LiteralPath $candidate
        $signature = Get-AuthenticodeSignature -LiteralPath $candidate
        [PSCustomObject]@{
            Path = $item.FullName
            Version = $item.VersionInfo.FileVersion
            Signature = $signature.Status
        } | Format-List
    }
} else {
    Write-Host "Tera Term was not found in the usual Program Files locations."
}

Write-Host "Expected serial settings: 9600 baud, 8 data bits, no parity, 1 stop bit, no flow control." -ForegroundColor Green
Write-Host "Use the COM port that appears when the Cornet is connected; do not assume a saved COM number."
