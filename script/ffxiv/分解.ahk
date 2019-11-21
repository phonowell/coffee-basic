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

; global

global limit := 10

; function

退出界面() {
  loop 4 {
    Sleep % "" . 200 . ""
    Send {numpaddot}
  }
  Sleep % "" . 200 . ""
  Sleep % "" . 1000 . ""
}

分解() {
  Send {shift down}{9}{shift up}
  Sleep % "" . 1000 . ""
  loop %limit% {
    Send {numpad0}
    Sleep % "" . 500 . ""
    Send {numpad4}
    Sleep % "" . 500 . ""
    Send {numpad0}
    Sleep % "" . 3000 . ""
    Send {numpad0}
    Sleep % "" . 500 . ""
  }
  退出界面()
}

; bind

f12::
  SoundBeep
  ExitApp
return

f2::
  分解()
return

; eof