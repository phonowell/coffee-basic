; global variable

global a := fn()
global a := fn(a, b)

; function

__$default__() {
  fn()
  fn(a, b)
  fn(a + 1)
  fn(!a)
}

; default
__$default__()