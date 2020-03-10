; function

__$tip__(msg) {
  ToolTip % msg
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