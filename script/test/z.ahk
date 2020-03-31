; global variable

global d := {}

; function

__d_dot_display__() {
  if !(d.value == 0) {
    return
  }
  if !(d.value > 1) {
    d.value := 1
  }
  if (d.value == -1) {
    d.value := -2
  }
  else {
    d.value := 0
  }
  MsgBox % d.value
}

__$default__() {
  d.value := 2
  d.display := Func("__d_dot_display__")
}

; default
__$default__()

; event

f1::
  fn()
return