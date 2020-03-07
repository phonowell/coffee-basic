; global variable

global list := []

; function

fn(a, b) {
  return a + b
}

default() {
  list[0] := 1
  list[1] := 2
  list[2] := 3
  list[0] := 3
  fn(list[0], list[1])
}

; default
default()