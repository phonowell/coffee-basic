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

; global

global a := fn()
global a := fn(a, b)

; function

default() {
  fn()
  fn(a, b)
  if (a != true) {
    fn()
  }
}

; default
default()

; eof