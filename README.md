# windows-focus-guard
Force a target window to remain foreground.

# windows-window-focus-watchdog

A blunt PowerShell watchdog that repeatedly forces a specific application window
into the foreground.

Author: TABARC-Code

## What this is for

Some applications lose focus.
Some steal it.
Some minimise themselves.
Some sit there politely while you scream at the screen.

Windows does not provide a reliable, supported way to say:
"this window stays visible and focused".

This script does it anyway.

## What it does

- Locates the main window for a named process
- Restores it if minimised
- Brings it to the foreground
- Repeats on a fixed interval

No UI automation.
No keystrokes.
No guessing.

## Quick start

Run PowerShell, then:

.\src\Window-Focus-Watchdog.ps1 -ProcessName notepad

cpp
Copy code

Optional interval override:

.\src\Window-Focus-Watchdog.ps1 -ProcessName chrome -IntervalMs 1000

csharp
Copy code

Press Ctrl+C to stop it.

## Notes

- This uses Win32 calls. Windows may still refuse occasionally.
- If something else is aggressively stealing focus, expect a tug of war.
- This is intentional. It is a watchdog, not a gentleman. DEAL WITH/.

## Licence

MIT.
