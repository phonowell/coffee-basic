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

f1::
  ExitApp
return

joy4::
  BlockInput %true%
  attackC()
  BlockInput %false%
return

joy5::
  BlockInput %true%
  attackB()
  BlockInput %false%
return

joy6::
  BlockInput %true%
  attackA()
  BlockInput %false%
return

joy7::
  Send "esc"
return

attackA() {
  Send "c"
  Sleep 20
  Send "numpad4"
  Sleep 20
  Send "numpad2"
  Sleep 20
  Send "numpad6"
  Sleep 20
  Send "numpad8"
  Sleep 20
  Send "z"
  Sleep 200
  Send "up"
  Sleep 200
  Send "esc"
  Sleep 600
  Send "esc"
}

attackB() {
  Send "numpad4"
  Sleep 20
  Send "numpad8"
  Sleep 20
  Send "numpad6"
  Sleep 20
  Send "numpad2"
  Sleep 20
  Send "z"
}

attackC() {
  Send "z down"
  Send "x"
  Send "z up"
}