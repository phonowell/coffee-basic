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
  Send {ctrl down}{8}{ctrl up}
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
  Send {shift down}{4}{shift up}
}

沉稳咏唱() {
  Send {shift down}{5}{shift up}
}

索敌() {
  Send {shift down}{6}{shift up}
}

能力技() {
  索敌()
  交剑()
  飞刺()
  六分反击()
  昏乱()
}

施放赤疾风() {
  res := hasStatus("连续咏唱")
  if (!res) {
    res := hasStatus("赤飞石预备")
    if (res) {
      赤飞石()
      return
    }
    摇荡()
    return
  }
  赤疾风()
  促进()
  施放醒梦()
  delay("能力技", 300, 2)
}

施放赤闪雷() {
  res := hasStatus("连续咏唱")
  if (!res) {
    res := hasStatus("赤火炎预备")
    if (res) {
      赤火炎()
      return
    }
    摇荡()
    return
  }
  赤闪雷()
  促进()
  施放醒梦()
  delay("能力技", 300, 2)
}

施放赤烈风() {
  res := hasStatus("连续咏唱")
  if (!res) {
    赤烈风()
    return
  }
  散碎()
  施放醒梦()
  delay("能力技", 300, 2)
}

施放赤震雷() {
  res := hasStatus("连续咏唱")
  if (!res) {
    赤震雷()
    return
  }
  散碎()
  施放醒梦()
  delay("能力技", 300, 2)
}

施放醒梦() {
  PixelGetColor color, 265, 40
  if (color == 0x3B5264) {
    醒梦()
  }
}

delay(name, time := 300, n := 1) {
  loop %n% {
    if (n != 1) {
      Sleep % " . time . "
    }
    SetTimer %name%, Off
    SetTimer %name%, % 0 - time
  }
}

getGroup() {
  PixelGetColor color, 965, 930
  if (color == 0x6CA9BD) {
    return "r1"
  }
  if (color == 0x7F6967) {
    return "r2"
  }
  PixelGetColor color, 740, 930
  if (color == 0x6BA8BD) {
    return "l1"
  }
  if (color == 0x7F6866) {
    return "l2"
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
    Sleep % " . 3000 . "
    Send {ctrl up}{up up}{pgdn up}
    isViewFar := true
  }
  else {
    Send {ctrl down}{down down}{pgup down}
    Sleep % " . 3000 . "
    Send {ctrl up}{down up}{pgup up}
    isViewFar := false
  }
  SoundBeep
}

; bind

f12::
  SoundBeep
  ExitApp
return

f9::
  MouseGetPos x, y
  PixelGetColor color, x, y
  ToolTip % "" . x . ", " . y . ", " . color . ""
return

f2::
  toggleView()
return

2joy4::
  group := getGroup()
  if (group == "none") {
    return
  }
  索敌()
  if (group == "r1") {
    delay("能力技", 300, 2)
    return
  }
  if (group == "r2") {
    delay("短兵相接")
    return
  }
  if (group == "l1") {
    delay("能力技")
    return
  }
return

2joy2::
  group := getGroup()
  if (group == "none") {
    return
  }
  索敌()
  if (group == "r1") {
    施放赤疾风()
    return
  }
  if (group == "r2") {
    delay("鼓励")
    return
  }
  if (group == "l1") {
    施放赤烈风()
    return
  }
return

2joy1::
  group := getGroup()
  if (group == "none") {
    return
  }
  索敌()
  if (group == "r1") {
    施放赤疾风()
    return
  }
  if (group == "r2") {
    delay("交剑")
    return
  }
  if (group == "l1") {
    施放赤烈风()
    return
  }
return

2joy3::
  group := getGroup()
  if (group == "none") {
    return
  }
  索敌()
  if (group == "r1") {
    施放赤闪雷()
    return
  }
  if (group == "r2") {
    delay("能力技", 300, 2)
    return
  }
  if (group == "l1") {
    施放赤震雷()
    return
  }
return

; eof