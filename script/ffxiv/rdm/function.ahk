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

getBlack() {
  PixelSearch x, y, 1027, 810, 1166, 810, 0x56463C, 0, Fast RGB
  if !(x) {
    return 100
  }
  percent := (x - 1023) * 100 / (1170 - 1023)
  percent := Round(percent)
  return percent - 1
}

getWhite() {
  PixelSearch x, y, 1027, 801, 1166, 801, 0x2E1E14, 0, Fast RGB
  if !(x) {
    return 100
  }
  percent := (x - 1023) * 100 / (1170 - 1023)
  percent := Round(percent)
  return percent - 1
}

; eof