; function

fn() {
  GetKeyState __value__, z
  state := __value__ == "D"
}

default() {
  ToolTip
  ToolTip % "" . a . ", " . b . ", " . c . ""
  SetTimer fn, % 0 - 0
  SetTimer %n%, % 0 - 0
  Sleep % 1000
  Send {a}
  Send {shift}
  Send {shift down}{a}{shift up}
}

; default
default()