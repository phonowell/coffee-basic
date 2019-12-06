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

; global

global a := 1
global b := "string"
global c := "" . a . ", " . c . ""
global d := true
global e := fn()
global f := fn(a, b)

; function

inside() {
  a := 1
  b := "string, string"
  c := "" . a . ", " . c . ""
  d := true
  e := fn()
  f := fn(a, b)
}

default() {
  if (a != true) {
    a := 1
  }
}

; default
default()

; eof