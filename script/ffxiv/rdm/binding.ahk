; transpiled by coffee-basic

#NoEnv
#Persistent
#SingleInstance Force
#UseHook

CoordMode Mouse, Client
CoordMode Pixel, Client
CoordMode ToolTip, Client
SendMode Event
SetKeyDelay 0, 50
SetMouseDelay 0, 50

; bind

f12::
  SoundBeep
  ExitApp
return

f6::
  MouseGetPos x, y
  PixelGetColor color, x, y, RGB
  ToolTip % "" . x . ", " . y . ", " . color . ""
return

f7::
  white := getWhite()
  black := getBlack()
  ToolTip % "" . white . " / " . black . ""
return

f8::
  x := 1100
  y := 935
  PixelGetColor color, x, y, RGB
  ToolTip % "" . x . ", " . y . ", " . color . ""
return

f2::
  toggleView()
return

2joy4::
  loop {
    GetKeyState __value__, 2joy4
    isPressing := __value__ == "D"
    if !(isPressing) {
      break
    }
    攻击()
    Sleep % "" . 300 . ""
  }
return

2joy2::
  loop {
    GetKeyState __value__, 2joy2
    isPressing := __value__ == "D"
    if !(isPressing) {
      break
    }
    特殊攻击()
    Sleep % "" . 300 . ""
  }
return

2joy1::
  group := getGroup()
  if (group == "right") {
    if (hasStatus("连续咏唱")) {
      SoundBeep
      return
    }
    索敌()
    摇荡()
    delay("能力技")
    return
  }
return

2joy3::
  group := getGroup()
  if (group == "right") {
    赤治疗()
    return
  }
  if (group == "both") {
    赤复活()
    delay("能力技")
    return
  }
return

; eof