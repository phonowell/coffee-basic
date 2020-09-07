; global variable

global $ := {}

; function

fn() {
  $.click()
}

__$_dot_click__(input) {
  if (!input) {
    Click
    return
  }
  Click % StrReplace input, ":", " "
}

__$default__() {
  $.click := Func("__$_dot_click__")
}