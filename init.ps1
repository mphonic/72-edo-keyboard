param([String]$destination='reaper')
Function Init($destination = 'reaper') {
forever start .\index.js;
Start-Process "chrome.exe" .\web\index.html;
sclang.exe ".\capture-osc-$($destination).scd";
}

Init($destination)