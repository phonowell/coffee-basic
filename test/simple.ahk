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
  BlockInput on
  attackC()
  BlockInput off
return

joy5::
  BlockInput on
  attackB()
  BlockInput off
return

joy6::
  BlockInput on
  attackA()
  BlockInput off
return

joy7::
  Send {esc}
return

attackA() {
  Send {c}
  Sleep 20
  Send {numpad4}
  Sleep 20
  Send {numpad2}
  Sleep 20
  Send {numpad6}
  Sleep 20
  Send {numpad8}
  Sleep 20
  Send {z}
  Sleep 200
  Send {up}
  Sleep 200
  Send {esc}
  Sleep 600
  return Send {esc}
}

attackB() {
  Send {numpad4}
  Sleep 20
  Send {numpad8}
  Sleep 20
  Send {numpad6}
  Sleep 20
  Send {numpad2}
  Sleep 20
  return Send {z}
}

attactC() {
  Send {z down}
  Send {x}
  return Send {z up}
}