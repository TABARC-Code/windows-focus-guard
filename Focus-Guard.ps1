# TABARC-Code
param(
  [Parameter(Mandatory=$true)][string]$ProcessName,
  [int]$IntervalMs = 2000
)

Add-Type @"
using System;
using System.Runtime.InteropServices;
public static class Win32 {
  [DllImport("user32.dll")] public static extern bool SetForegroundWindow(IntPtr hWnd);
  [DllImport("user32.dll")] public static extern bool ShowWindow(IntPtr hWnd,int nCmdShow);
  [DllImport("user32.dll")] public static extern bool IsIconic(IntPtr hWnd);
}
"@

function Get-Window {
  $p = Get-Process -Name $ProcessName -ErrorAction SilentlyContinue |
       Where-Object { $_.MainWindowHandle -ne 0 } |
       Select-Object -First 1
  if ($p) { [IntPtr]$p.MainWindowHandle } else { [IntPtr]::Zero }
}

while ($true) {
  $h = Get-Window
  if ($h -ne [IntPtr]::Zero) {
    if ([Win32]::IsIconic($h)) { [Win32]::ShowWindow($h,9) | Out-Null }
    else { [Win32]::ShowWindow($h,5) | Out-Null }
    [Win32]::SetForegroundWindow($h) | Out-Null
  }
  Start-Sleep -Milliseconds $IntervalMs
}
