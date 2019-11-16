; transpiled by coffee-basic

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

; function

fn() {
  1
}

default() {
  ToolTip
  ToolTip % "" . a . ", " . b . ", " . c . ""
  SetTimer fn, % 0 - 0
  SetTimer %n%, % 0 - 0
}

; default
default()

; eof