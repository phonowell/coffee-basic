; global variable

global a := fn()
global a := fn(a, b)

; function

default() {
  fn()
  fn(a, b)
  fn(a + 1)
  fn(!a)
}

; default
default()