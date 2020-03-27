; global variable

global d := {}

; function

__d_dot_setTimer__(name) {
  __timer__ := d[name]
  SetTimer %__timer__%, Off
  __timer__ := d[name]
  SetTimer %__timer__%, % 1000
}

__d_dot_clearTimer__(name) {
  __timer__ := d[name]
  SetTimer %__timer__%, Off
}

__d_dot_display__() {
  ToolTip % A_TickCount
}

__$default__() {
  d.setTimer := Func("__d_dot_setTimer__")
  d.clearTimer := Func("__d_dot_clearTimer__")
  d.display := Func("__d_dot_display__")
}

; default
__$default__()

; event

f5::
  SoundBeep
  Reload
return

!f4::
  SoundBeep
  ExitApp
return

f2::
  d.setTimer.Call("display")
return

f4::
  d.clearTimer.Call("display")
return