; function

__$tip__(msg := "", x := -1, y := -1) {
  if (x >= 0 and y >= 0) {
    ToolTip % msg, x, y
  }
  else {
    ToolTip % msg
  }
  return msg
}

__$info__(msg) {
  TrayTip % msg
  return msg
}

; event

f2::
  a := __$tip__(2)
  __$info__(a)
return