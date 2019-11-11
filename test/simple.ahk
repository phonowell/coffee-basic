; transpiled by coffee-basic

#noEnv
#persistent
#singleInstance force
#useHook

SetKeyDelay 0, 50
SendMode Event

; exit
f1::
  ExitApp
return

; bind

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
  $.send 'esc'
return

; function

attackA(){
  $.send 'c'
  Sleep 20
  $.send 'numpad4'
  Sleep 20
  $.send 'numpad2'
  Sleep 20
  $.send 'numpad6'
  Sleep 20
  $.send 'numpad8'
  Sleep 20
  $.send 'z'
  Sleep 200
  $.send 'up'
  Sleep 200
  $.send 'esc'
  Sleep 600
  return $.send 'esc'
}