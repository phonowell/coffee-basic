; global variable

global a := 1
global b := "string"
global c := "" . a . ", " . c . ""
global d := true
global e := fn()
global f := fn(a, b)

; function

inside() {
  a := 1
  b := "string, string"
  c := "" . a . ", " . c . ""
  d := true
  e := fn()
  f := fn(a, b)
}

__$default__() {
  if (a != true) {
    a := 1
  }
}

; default
__$default__()