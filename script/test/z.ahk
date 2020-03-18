; global variable

global d := {}

; function

__d_dot_ask__() {
  InputBox d.value, , % "input value", , , , , , , , % d.ask
}

__d_dot_show__() {
  MsgBox % d.value
}

__$default__() {
  d.ask := Func("__d_dot_ask__")
  d.show := Func("__d_dot_show__")
}

; default
__$default__()

; event

!f2::
  d.show()
return