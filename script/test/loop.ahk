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

default() {
  loop {
    1
  }
  loop 2 {
    2
  }
  loop %count% {
    3
  }
}

; default
default()

; eof