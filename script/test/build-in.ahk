; function

fn() {
  GetKeyState __value__, z
  state := __value__ == "D"
}

__$default__() {
  __$tip__()
  __$tip__("" . a . ", " . b . ", " . c . "")
  SetTimer fn, % 0 - 0
  SetTimer %n%, % 0 - 0
  Sleep % 1000
  Send {a}
  Send {shift}
  Send {shift down}{a}{shift up}
}

__$tip__(msg) {
  ToolTip % msg
  return msg
}

; default
__$default__()