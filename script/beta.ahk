; transpiled by coffee-basic

if (A_IsAdmin != true) {
  Run *RunAs "%A_ScriptFullPath%"
  ExitApp
}

#NoEnv
#Persistent
#SingleInstance Force
#UseHook

CoordMode Mouse, Client
CoordMode Pixel, Client
CoordMode ToolTip, Client
SendMode Event
SetKeyDelay 0, 50
SetMouseDelay 0, 50

; bind

f12::
  ExitApp
return

rbutton::
  Click % "right"
  loop 4 {
    Sleep % "" . 100 . ""
    Send {numpad0}
  }
return

; eof