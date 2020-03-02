; global variable

global list := [1, 2, 3]

; function

fn(a, b) {
  return a + b
}

default() {
  list[0] := 3
  fn(list[0], list[1])
}

; default
default()