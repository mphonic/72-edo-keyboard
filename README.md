# 72-edo Keyboard

72-note equal-tempered octave keyboard for Windows touch devices (i.e., Surface). Theoretically works on any touch device that can run Chrome and SuperCollider &ndash; you'll just need to manually run Node and sclang or create your own shell scripts.

Runs in Chrome. Uses osc.js and SuperCollider to route Reaper-specific OSC messages (note on, note off, pitch bend). Uses multiple channels to allow polyphonic pitch bends.

You can modify capture-osc.scd or use your own SuperCollider code to do whatever you want with the incoming OSC messages (`/72edo/noteOn`, `/72edo/noteOff`).

## Installation

From the command line:
1. Run <code>npm install</code>
2. In the <code>web</code> folder, run <code>npm install</code>
3. Install forever: `npm install -g forever`
4. Install [SuperCollider](https://supercollider.github.io/download)
5. Add sclang.exe to your PATH: `$Env:Path += ";C:\Program Files\SuperCollider-3.10.2"` (Confirm the path to SuperCollider on your machine). You can add this to your [profile](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_profiles?view=powershell-6)
6. Enable touch events in Chrome: Go to `chrome://flags/#touch-events` and select "Enabled" for Touch Events API
7. If you're not using an [MPE](http://www.rogerlinndesign.com/mpe.html) compatible virtual instrument, setup a [Reaper](http://reaper.fm/download.php) project with 10 virtual instruments, each accepting an individual MIDI channel from 2-11. Make sure that instrument pitch bend range is set to 1.
8. Enable script execution in PowerShell (as Administrator, run `Set-ExecutionPolicy RemoteSigned`)

## Starting

Navigate to project directory in PowerShell and execute `.\init.ps1`

A tab should open in Chrome with the keyboard GUI.

## Stopping

From same PowerShell window, hit ctrl-C to stop sclang, then execute `.\quit.ps1`

Accidently closed initial PowerShell window? 
1. Open a new one and navigate to project directory
2. Execute `Stop-Process -Name sclang`
3. Execute `.\quit.ps1`
