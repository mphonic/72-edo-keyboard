Function Init {
forever start .\index.js;
Start-Process "chrome.exe" .\web\index.html;
sclang.exe .\capture-osc.scd;
}

Init