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

; function

攻击() {
  group := getGroup()
  if !(group) {
    return
  }
  索敌()
  魔元警告()
  if (group == "right") {
    单体攻击()
    return
  }
  if (group == "both") {
    群体攻击()
    return
  }
}

绑定攻击() {
  GetKeyState __value__, 2joy4
  isPressing := __value__ == "D"
  if !(isPressing) {
    SetTimer 绑定攻击, Off
    SetTimer %清空信息%, % 0 - 3000
    return
  }
  SetTimer %清空信息%, Off
  攻击()
}

特殊攻击() {
  group := getGroup()
  if !(group) {
    return
  }
  索敌()
  魔元警告()
  if (group == "right") {
    魔三连()
    return
  }
  if (group == "both") {
    isA := hasStatus("连续咏唱")
    isB := hasStatus("即刻咏唱")
    if (isA or isB) {
      攻击()
      asr := 2
    }
    if (划圆斩()) {
      asr := 2
    }
    else {
      群体攻击()
      SoundBeep
    }
    短兵相接()
    能力技()
    return
  }
}

绑定特殊攻击() {
  GetKeyState __value__, 2joy2
  isPressing := __value__ == "D"
  if !(isPressing) {
    SetTimer 绑定特殊攻击, Off
    SetTimer %清空信息%, % 0 - 3000
    return
  }
  SetTimer %清空信息%, Off
  特殊攻击()
}

; bind

f2::
  toggleView()
return

f4::
  isReporting := !isReporting
  if (!isReporting) {
    ToolTip
  }
return

f5::
  SoundBeep
  Reload
return

f9::
  MouseGetPos x, y
  PixelGetColor color, x, y, RGB
  ToolTip % "" . x . ", " . y . ", " . color . ""
return

f12::
  SoundBeep
  ExitApp
return

2joy4::
  if !(getGroup()) {
    return
  }
  SetTimer 绑定攻击, Off
  SetTimer 绑定攻击, 350
  攻击()
return

2joy2::
  if !(getGroup()) {
    return
  }
  SetTimer 绑定特殊攻击, Off
  SetTimer 绑定特殊攻击, 350
  特殊攻击()
return

2joy3::
  group := getGroup()
  if (group == "right") {
    赤治疗()
    return
  }
  if (group == "both") {
    赤复活()
    asr := 2
    能力技()
    return
  }
return

; eof