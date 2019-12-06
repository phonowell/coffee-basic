; transpiled by coffee-basic

#KeyHistory 0
#MaxThreads 20
#NoEnv
#Persistent
#SingleInstance Force
#UseHook

CoordMode Mouse, Client
CoordMode Pixel, Client
CoordMode ToolTip, Client
SendMode Event
SetBatchLines 100ms
SetKeyDelay 0, 50
SetMouseDelay 0, 50

; function

fn() {
  GetKeyState __value__, z
  state := __value__ == "D"
}

default() {
  ToolTip
  ToolTip % "" . a . ", " . b . ", " . c . ""
  SetTimer fn, % 0 - 0
  SetTimer %n%, % 0 - 0
  Sleep % "" . 1000 . ""
  Send {a}
  Send {shift}
  Send {shift down}{a}{shift up}
}

; default
default()

; eof