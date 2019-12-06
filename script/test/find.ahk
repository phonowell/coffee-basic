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

default() {
  PixelSearch x, y, 0, 0, A_ScreenWidth, A_ScreenHeight, 0xFFFFFF, 0, Fast RGB
  ImageSearch x, y, 0, 0, A_ScreenWidth, A_ScreenHeight, % A_ScriptDir . "\" . "white.png"
  PixelSearch x, y, 0, 0, A_ScreenWidth, A_ScreenHeight, color, 0, Fast RGB
  ImageSearch x, y, 0, 0, A_ScreenWidth, A_ScreenHeight, % A_ScriptDir . "\" . path . ".png"
}

; default
default()

; eof