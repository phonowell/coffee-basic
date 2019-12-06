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

global a := {}

; function

reg() {
  a.回刺时间戳 := 0
  a.回刺冷却 := 10000
}

default() {
  reg()
}

; default
default()

; bind

f2::
  ToolTip % a.回刺冷却
return

; eof