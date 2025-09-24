; ================================
; Game Launcher GUI with Wait Time
; ================================

swap := "https://www.spatial.io/s/Future-Fab-Heroes-68af3ddfd1fa7707b88f6c7b?share=1953632267909538882"
shield := "https://www.spatial.io/s/Shield-Future-Fab-Heros-68bb1ec36d0f15ba3b5c65b3?share=2707585135207394608"

; Default wait time in milliseconds
waitTime := 2000

; ---- Create GUI ----
Gui, Font, s12 Bold, Segoe UI   ; Larger, bold font
Gui, Add, Text, x20 y20 w300 h30, Select a game to launch:

Gui, Add, Button, x20 y60 w140 h50 gLaunchSwap, Launch Swap
Gui, Add, Button, x180 y60 w140 h50 gLaunchShield, Launch Shield

Gui, Add, Text, x20 y130 w310 h50, Wait Time Between Page Reload and Game Full Screen (in seconds):
Gui, Add, Edit, x20 y185 w300 h30 vUserWaitTime, % waitTime / 1000  ; default value

Gui, Show, w360 h250, Future Fab Heroes Launcher
return

; ---- Button Actions ----
LaunchSwap:
    Run, firefox.exe -kiosk -private-window %swap%
    waitTime := 3500
    Sleep, waitTime
    Send, !l
return

LaunchShield:
    Run, firefox.exe -kiosk -private-window %shield%
    waitTime := 3500
    Sleep, waitTime
    Send, !l
return

; ---- Reload Hotkey ----
^r::
    WinActivate, ahk_exe firefox.exe
    WinWaitActive, ahk_exe firefox.exe
    Sleep, 200

    ; Reload page via F5
    Send, {F5}

    WaitUserTime()

    ; Alt+L for fullscreen
    Send, !l
return

; ---- Close GUI properly ----
GuiClose:
    ExitApp
return

; Wait time for Reload and Full Screen based off of User's Input or Default of 2 seconds
WaitUserTime() {
    global UserWaitTime  ; Access GUI input variable
    Gui, Submit, NoHide  ; update UserWaitTime from GUI
    if (UserWaitTime <> "")
        waitTime := UserWaitTime * 1000
    else
        waitTime := 2000  ; default 2 seconds
    Sleep, waitTime
}
