; transpiled by coffee-basic

if (A_IsAdmin != true) {
  Run *RunAs "%A_ScriptFullPath%"
  ExitApp
}

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

; global

global isViewFar := false

; function

回刺() {
  Send {alt down}{1}{alt up}
}

摇荡() {
  Send {alt down}{2}{alt up}
}

赤闪雷() {
  Send {alt down}{3}{alt up}
}

短兵相接() {
  Send {alt down}{4}{alt up}
}

赤疾风() {
  Send {alt down}{5}{alt up}
}

散碎() {
  Send {alt down}{6}{alt up}
}

赤震雷() {
  Send {alt down}{7}{alt up}
}

赤烈风() {
  Send {alt down}{8}{alt up}
}

赤火炎() {
  Send {alt down}{9}{alt up}
}

赤飞石() {
  Send {alt down}{0}{alt up}
}

交击斩() {
  Send {alt down}{-}{alt up}
}

移转() {
  Send {alt down}{=}{alt up}
}

飞刺() {
  Send {ctrl down}{1}{ctrl up}
}

连攻() {
  Send {ctrl down}{2}{ctrl up}
}

促进() {
  Send {ctrl down}{3}{ctrl up}
}

划圆斩() {
  Send {ctrl down}{4}{ctrl up}
}

赤治疗() {
  Send {ctrl down}{5}{ctrl up}
}

六分反击() {
  Send {ctrl down}{6}{ctrl up}
}

鼓励() {
  Send {ctrl down}{7}{ctrl up}
}

倍增() {
  white := getWhite()
  if !(white >= 40 and white <= 60) {
    return false
  }
  black := getBlack()
  if !(black >= 40 and black <= 60) {
    return false
  }
  Send {ctrl down}{8}{ctrl up}
  return true
}

震荡() {
  Send {ctrl down}{9}{ctrl up}
}

赤复活() {
  Send {ctrl down}{0}{ctrl up}
}

冲击() {
  Send {ctrl down}{-}{ctrl up}
}

交剑() {
  Send {ctrl down}{=}{ctrl up}
}

续斩() {
  Send {shift down}{1}{shift up}
}

昏乱() {
  Send {shift down}{2}{shift up}
}

即刻咏唱() {
  Send {shift down}{3}{shift up}
}

醒梦() {
  PixelGetColor color, 260, 35, RGB
  if !(color == 0x56463C) {
    return false
  }
  Send {shift down}{4}{shift up}
  return true
}

沉稳咏唱() {
  Send {shift down}{5}{shift up}
}

索敌() {
  Send {shift down}{6}{shift up}
}

爆发药() {
  Send {shift down}{7}{shift up}
}

能力技() {
  索敌()
  倍增()
  飞刺()
  六分反击()
  交剑()
  昏乱()
  醒梦()
}

delay(name, time := 300, n := 1) {
  loop %n% {
    if (n != 1) {
      Sleep % "" . time . ""
    }
    SetTimer %name%, Off
    SetTimer %name%, % 0 - time
  }
}

getGroup() {
  isLT := false
  isRT := false
  GetKeyState __value__, 2joy7
  isLT := __value__ == "D"
  GetKeyState __value__, 2joy8
  isRT := __value__ == "D"
  if (isLT and isRT) {
    return "both"
  }
  if (isLT) {
    return "left"
  }
  if (isRT) {
    return "right"
  }
  return "none"
}

hasStatus(name) {
  ImageSearch x, y, 725, 840, 925, 875, % A_ScriptDir . "\" . name . ".png"
  if (x > 0 and y > 0) {
    return true
  }
  return false
}

toggleView() {
  if (isViewFar == false) {
    Send {ctrl down}{up down}{pgdn down}
    Sleep % "" . 3000 . ""
    Send {ctrl up}{up up}{pgdn up}
    isViewFar := true
  }
  else {
    Send {ctrl down}{down down}{pgup down}
    Sleep % "" . 3000 . ""
    Send {ctrl up}{down up}{pgup up}
    isViewFar := false
  }
  SoundBeep
}

attackCombo() {
  if (hasStatus("连续咏唱")) {
    SoundBeep
    return
  }
  索敌()
  white := getWhite()
  black := getBlack()
  if (white >= 80 and black >= 80) {
    回刺()
    短兵相接()
    return
  }
  if (white >= 50 and black >= 50) {
    交击斩()
    鼓励()
    return
  }
  if (white >= 25 and black >= 25) {
    连攻()
    交剑()
    短兵相接()
    return
  }
  if (white >= black) {
    赤闪雷()
  }
  else {
    赤疾风()
  }
  delay("能力技")
}

attackMulti() {
  索敌()
  if (isMoving()) {
    续斩()
    return
  }
  white := getWhite()
  black := getBlack()
  if (white > 90 or black > 90) {
    SoundBeep
  }
  if (hasStatus("连续咏唱")) {
    散碎()
    delay("能力技")
    return
  }
  if (white >= black) {
    赤震雷()
  }
  else {
    赤烈风()
  }
}

attackSingle() {
  索敌()
  if (isMoving()) {
    续斩()
    return
  }
  white := getWhite()
  black := getBlack()
  total := white + black
  if (total > 170 and total < 200) {
    SoundBeep
  }
  isW := hasStatus("赤飞石预备")
  isB := hasStatus("赤火炎预备")
  if (hasStatus("连续咏唱")) {
    if (isW) {
      赤闪雷()
    }
    else if (isB) {
      赤疾风()
    }
    else {
      if (white >= black) {
        赤闪雷()
      }
      else {
        赤疾风()
      }
    }
    delay("促进")
    delay("能力技")
    return
  }
  if (isW and isB) {
    if (white >= black) {
      赤火炎()
    }
    else {
      赤飞石()
    }
    return
  }
  if (isW) {
    赤飞石()
    return
  }
  if (isB) {
    赤火炎()
    return
  }
  摇荡()
}

getBlack() {
  PixelSearch x, y, 1027, 810, 1166, 810, 0x56463C, 0, Fast RGB
  if !(x) {
    return 100
  }
  percent := (x - 1023) * 100 / (1170 - 1023)
  percent := Round(percent)
  return percent - 1
}

getWhite() {
  PixelSearch x, y, 1027, 801, 1166, 801, 0x2E1E14, 0, Fast RGB
  if !(x) {
    return 100
  }
  percent := (x - 1023) * 100 / (1170 - 1023)
  percent := Round(percent)
  return percent - 1
}

isMoving() {
  GetKeyState dis, 2joyx
  if (dis < 40) {
    return true
  }
  if (dis > 60) {
    return true
  }
  GetKeyState dis, 2joyy
  if (dis < 40) {
    return true
  }
  if (dis > 60) {
    return true
  }
  return false
}

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
  group := getGroup()
  if (group == "right") {
    attackSingle()
    return
  }
  if (group == "both") {
    attackMulti()
    return
  }
return

2joy2::
  group := getGroup()
  if (group == "right") {
    attackCombo()
    return
  }
  if (group == "both") {
    if (getWhite() < 20) {
      SoundBeep
      return
    }
    if (getBlack() < 20) {
      SoundBeep
      return
    }
    if (hasStatus("连续咏唱")) {
      SoundBeep
      return
    }
    索敌()
    划圆斩()
    delay("能力技")
    return
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