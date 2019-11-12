; transpiled by coffee-basic

#NoEnv
#Persistent
#SingleInstance Force
#UseHook

CoordMode Mouse, Client
CoordMode Pixel, Client
SendMode Event
SetKeyDelay 0, 50
SetMouseDelay 0, 50

beep() {
  SoundBeep
}

f1::
  MouseGetPos x, y
  PixelGetColor color, x, y
  MsgBox current color is %color%
return

f2::
  PixelSearch x, y, 0, 0, 100, 100, 0xFFFFFF, 0, Fast RGB
  MsgBox find #fff at %x%, %y%
return

f3::
  beep()
return

^f12::
  ExitApp
return