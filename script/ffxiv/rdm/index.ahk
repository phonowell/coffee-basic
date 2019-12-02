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

global hp := 0
global mp := 0
global isViewFar := false
global 回刺时间戳 := 0
global 回刺冷却 := 10000
global 短兵相接时间戳 := 0
global 短兵相接冷却 := 40000
global 交击斩时间戳 := 0
global 交击斩冷却 := 10000
global 飞刺时间戳 := 0
global 飞刺冷却 := 25000
global 连攻时间戳 := 0
global 连攻冷却 := 10000
global 促进时间戳 := 0
global 促进冷却 := 35000
global 划圆斩时间戳 := 0
global 六分反击时间戳 := 0
global 六分反击冷却 := 35000
global 鼓励时间戳 := 0
global 鼓励冷却 := 120000
global 倍增时间戳 := 0
global 倍增冷却 := 110000
global 交剑时间戳 := 0
global 交剑冷却 := 35000
global 即刻咏唱时间戳 := 0
global 即刻咏唱冷却 := 60000
global 醒梦时间戳 := 0
global 醒梦冷却 := 60000
global 索敌时间戳 := 0
global 索敌冷却 := 10000
global 魔元警告时间戳 := 0
global 魔元警告冷却 := 10000
global asr := 0
global 赤神圣时间戳 := 0
global 赤神圣冷却 := 10000
global 焦热时间戳 := 0
global 焦热冷却 := 10000
global black := 0
global white := 0
global isReporting := true

; function

getGroup() {
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
  return false
}

getHp() {
  return 0
}

getMp() {
  return 0
}

hasStatus(name) {
  ImageSearch x, y, 725, 840, 925, 875, % A_ScriptDir . "\" . "image\" . name . ".png"
  if (x > 0 and y > 0) {
    return true
  }
  return false
}

isChanted(name) {
  ImageSearch x, y, 20, 885, 285, 975, % A_ScriptDir . "\" . "image\" . name . ".png"
  if (x > 0 and y > 0) {
    return true
  }
  return false
}

isChanting() {
  PixelGetColor color, 1010, 620, RGB
  return color == 0x2B1B13
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

回刺() {
  if !(A_TickCount - 回刺时间戳 > 回刺冷却) {
    return false
  }
  if !(black >= 80 and white >= 80) {
    return false
  }
  Send {alt down}{1}{alt up}
  return true
}

监听回刺() {
  if !(A_TickCount - 回刺时间戳 > 回刺冷却) {
    return
  }
  if !(isChanted("魔回刺")) {
    return
  }
  回刺时间戳 := A_TickCount - 2000
}

摇荡() {
  Send {alt down}{2}{alt up}
}

赤闪雷() {
  Send {alt down}{3}{alt up}
}

短兵相接() {
  if !(asr > 0) {
    return false
  }
  if !(A_TickCount - 短兵相接时间戳 > 短兵相接冷却) {
    return false
  }
  Send {alt down}{4}{alt up}
  asr--
  return true
}

监听短兵相接() {
  if !(A_TickCount - 短兵相接时间戳 > 短兵相接冷却) {
    return
  }
  if !(isChanted("短兵相接")) {
    return
  }
  短兵相接时间戳 := A_TickCount - 2000
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
  if !(A_TickCount - 交击斩时间戳 > 交击斩冷却) {
    return false
  }
  if !(A_TickCount - 回刺时间戳 < 10000) {
    return false
  }
  if !(black >= 50 and white >= 50) {
    return false
  }
  Send {alt down}{-}{alt up}
  return true
}

监听交击斩() {
  if !(A_TickCount - 交击斩时间戳 > 交击斩冷却) {
    return
  }
  if !(isChanted("魔交击斩")) {
    return
  }
  交击斩时间戳 := A_TickCount - 2000
}

移转() {
  Send {alt down}{=}{alt up}
}

飞刺() {
  if !(asr > 0) {
    return
  }
  if !(A_TickCount - 飞刺时间戳 > 飞刺冷却) {
    return false
  }
  Send {ctrl down}{1}{ctrl up}
  asr--
  return true
}

监听飞刺() {
  if !(A_TickCount - 飞刺时间戳 > 飞刺冷却) {
    return
  }
  if !(isChanted("飞刺")) {
    return
  }
  飞刺时间戳 := A_TickCount - 2000
}

连攻() {
  if !(A_TickCount - 连攻时间戳 > 连攻冷却) {
    return false
  }
  if !(A_TickCount - 交击斩时间戳 < 10000) {
    return false
  }
  if !(black >= 25 and white >= 25) {
    return false
  }
  Send {ctrl down}{2}{ctrl up}
  return true
}

监听连攻() {
  if !(A_TickCount - 连攻时间戳 > 连攻冷却) {
    return
  }
  if !(isChanted("魔连攻")) {
    return
  }
  连攻时间戳 := A_TickCount - 2000
}

促进() {
  if !(asr > 0) {
    return
  }
  if !(A_TickCount - 促进时间戳 > 促进冷却) {
    return false
  }
  Send {ctrl down}{3}{ctrl up}
  asr--
  return true
}

监听促进() {
  if !(A_TickCount - 促进时间戳 > 促进冷却) {
    return
  }
  if !(isChanted("促进")) {
    return
  }
  促进时间戳 := A_TickCount - 2000
}

划圆斩() {
  if !(black >= 20 and white >= 20) {
    return false
  }
  Send {ctrl down}{4}{ctrl up}
  if !(isChanted("魔划圆斩")) {
    return false
  }
  划圆斩时间戳 := A_TickCount - 2000
  return true
}

赤治疗() {
  Send {ctrl down}{5}{ctrl up}
}

六分反击() {
  if !(asr > 0) {
    return
  }
  if !(A_TickCount - 六分反击时间戳 > 六分反击冷却) {
    return false
  }
  Send {ctrl down}{6}{ctrl up}
  asr--
  return true
}

监听六分反击() {
  if !(A_TickCount - 六分反击时间戳 > 六分反击冷却) {
    return
  }
  if !(isChanted("六分反击")) {
    return
  }
  六分反击时间戳 := A_TickCount - 2000
}

鼓励() {
  if !(asr > 0) {
    return
  }
  if !(A_TickCount - 鼓励时间戳 > 鼓励冷却) {
    return false
  }
  Send {ctrl down}{7}{ctrl up}
  asr--
  return true
}

监听鼓励() {
  if !(A_TickCount - 鼓励时间戳 > 鼓励冷却) {
    return
  }
  if !(isChanted("鼓励")) {
    return
  }
  鼓励时间戳 := A_TickCount - 2000
}

倍增() {
  if !(asr > 0) {
    return
  }
  if !(A_TickCount - 倍增时间戳 > 倍增冷却) {
    return false
  }
  if !(A_TickCount - 回刺时间戳 > 回刺冷却) {
    return false
  }
  if !(white >= 40 and white < 70) {
    return false
  }
  if !(black >= 40 and black < 70) {
    return false
  }
  Send {ctrl down}{8}{ctrl up}
  asr--
  return true
}

监听倍增() {
  if !(A_TickCount - 倍增时间戳 > 倍增冷却) {
    return
  }
  if !(isChanted("倍增")) {
    return
  }
  倍增时间戳 := A_TickCount - 2000
  短兵相接时间戳 := 0
  交剑时间戳 := 0
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
  if !(asr > 0) {
    return
  }
  if !(A_TickCount - 交剑时间戳 > 交剑冷却) {
    return false
  }
  Send {ctrl down}{=}{ctrl up}
  asr--
  return true
}

监听交剑() {
  if !(A_TickCount - 交剑时间戳 > 交剑冷却) {
    return
  }
  if !(isChanted("交剑")) {
    return
  }
  交剑时间戳 := A_TickCount - 2000
}

续斩() {
  Send {shift down}{1}{shift up}
}

昏乱() {
  Send {shift down}{2}{shift up}
}

即刻咏唱() {
  if !(asr > 0) {
    return
  }
  if !(A_TickCount - 即刻咏唱时间戳 > 即刻咏唱冷却) {
    return false
  }
  if !(A_TickCount - 回刺时间戳 > 回刺冷却) {
    return false
  }
  if (black > 80 and white > 80) {
    return false
  }
  if (hasStatus("连续咏唱")) {
    return false
  }
  Send {shift down}{3}{shift up}
  asr--
  return true
}

监听即刻咏唱() {
  if !(A_TickCount - 即刻咏唱时间戳 > 即刻咏唱冷却) {
    return
  }
  if !(isChanted("即刻咏唱2")) {
    return
  }
  即刻咏唱时间戳 := A_TickCount - 2000
}

醒梦() {
  if !(asr > 0) {
    return
  }
  if !(A_TickCount - 醒梦时间戳 > 醒梦冷却) {
    return false
  }
  PixelGetColor color, 260, 35, RGB
  if !(color == 0x56463C) {
    return false
  }
  Send {shift down}{4}{shift up}
  asr--
  return true
}

监听醒梦() {
  if !(A_TickCount - 醒梦时间戳 > 醒梦冷却) {
    return
  }
  if !(isChanted("醒梦")) {
    return
  }
  醒梦时间戳 := A_TickCount - 2000
}

沉稳咏唱() {
  Send {shift down}{5}{shift up}
}

索敌() {
  if !(A_TickCount - 索敌时间戳 > 索敌冷却) {
    return false
  }
  Send {shift down}{-}{shift up}
  索敌时间戳 := A_TickCount - 2000
  return true
}

清空信息() {
  Send {shift down}{=}{shift up}
}

魔元警告() {
  if !(A_TickCount - 魔元警告时间戳 > 魔元警告冷却) {
    return false
  }
  total := black + white
  if !(170 < total and total < 200) {
    return false
  }
  SoundBeep
  魔元警告时间戳 := A_TickCount - 2000
  return true
}

能力技() {
  if !(asr > 0) {
    return false
  }
  if (倍增()) {
    return true
  }
  if (飞刺()) {
    return true
  }
  if (六分反击()) {
    return true
  }
  if (交剑()) {
    return true
  }
  if (醒梦()) {
    return true
  }
}

赤神圣() {
  if !(A_TickCount - 赤神圣时间戳 > 赤神圣冷却) {
    return false
  }
  if !(A_TickCount - 连攻时间戳 < 10000) {
    return false
  }
  if (black > white) {
    赤疾风()
  }
  else {
    赤闪雷()
  }
  return true
}

监听赤神圣() {
  if !(A_TickCount - 赤神圣时间戳 > 赤神圣冷却) {
    return
  }
  isBR := isChanted("赤核爆")
  isWR := isChanted("赤神圣")
  if !(isBR or isWR) {
    return
  }
  赤神圣时间戳 := A_TickCount - 2000
}

焦热() {
  if !(A_TickCount - 焦热时间戳 > 焦热冷却) {
    return false
  }
  if !(A_TickCount - 赤神圣时间戳 < 10000) {
    return false
  }
  摇荡()
  return true
}

监听焦热() {
  if !(A_TickCount - 焦热时间戳 > 焦热冷却) {
    return
  }
  if !(isChanted("焦热")) {
    return
  }
  焦热时间戳 := A_TickCount - 2000
}

监听() {
  report()
  hp := getHp()
  mp := getMp()
  black := getBlack()
  white := getWhite()
  监听回刺()
  监听短兵相接()
  监听交击斩()
  监听飞刺()
  监听连攻()
  监听促进()
  监听六分反击()
  监听鼓励()
  监听倍增()
  监听交剑()
  监听即刻咏唱()
  监听醒梦()
  监听赤神圣()
}

calcCD(ts, cd) {
  result := cd - (A_TickCount - ts)
  if (result < 0) {
    result := 0
  }
  result := result / 1000
  result := Round(result)
  return result
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

report() {
  if !(isReporting) {
    return
  }
  msg := "体力：" . hp . " / 魔力：" . mp . ""
  msg := "" . msg . "`n黑：" . black . " / 白：" . white . "`n"
  res := calcCD(短兵相接时间戳, 短兵相接冷却)
  if (res) {
    msg := "" . msg . "`n短兵相接：" . res . "s"
  }
  res := calcCD(飞刺时间戳, 飞刺冷却)
  if (res) {
    msg := "" . msg . "`n飞刺：" . res . "s"
  }
  res := calcCD(促进时间戳, 促进冷却)
  if (res) {
    msg := "" . msg . "`n促进：" . res . "s"
  }
  res := calcCD(六分反击时间戳, 六分反击冷却)
  if (res) {
    msg := "" . msg . "`n六分反击：" . res . "s"
  }
  res := calcCD(鼓励时间戳, 鼓励冷却)
  if (res) {
    msg := "" . msg . "`n鼓励：" . res . "s"
  }
  res := calcCD(倍增时间戳, 倍增冷却)
  if (res) {
    msg := "" . msg . "`n倍增：" . res . "s"
  }
  res := calcCD(交剑时间戳, 交剑冷却)
  if (res) {
    msg := "" . msg . "`n交剑：" . res . "s"
  }
  res := calcCD(即刻咏唱时间戳, 即刻咏唱冷却)
  if (res) {
    msg := "" . msg . "`n即刻咏唱：" . res . "s"
  }
  res := calcCD(醒梦时间戳, 醒梦冷却)
  if (res) {
    msg := "" . msg . "`n醒梦：" . res . "s"
  }
  ToolTip % msg, 1210, 800
}

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
    SetTimer 清空信息, % 0 - 3000
    return
  }
  SetTimer 清空信息, Off
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
    SetTimer 清空信息, % 0 - 3000
    return
  }
  SetTimer 清空信息, Off
  特殊攻击()
}

短单体(isBR, isWR) {
  if (black - white > 21) {
    if (isWR) {
      赤飞石()
    }
    else {
      摇荡()
    }
    return
  }
  if (white - black > 21) {
    if (isBR) {
      赤火炎()
    }
    else {
      摇荡()
    }
    return
  }
  if (isWR and isBR) {
    if (black > white) {
      赤飞石()
    }
    else {
      赤火炎()
    }
    return
  }
  if (isWR) {
    赤飞石()
    return
  }
  if (isBR) {
    赤火炎()
    return
  }
  摇荡()
}

长单体(isBR, isWR) {
  isA := hasStatus("连续咏唱")
  isB := hasStatus("即刻咏唱")
  if !(isA or isB) {
    return false
  }
  if (black - white > 19) {
    赤疾风()
    return true
  }
  if (white - black > 19) {
    赤闪雷()
    return true
  }
  if (isWR) {
    赤闪雷()
    return true
  }
  if (isBR) {
    赤疾风()
    return true
  }
  if (white >= black) {
    赤闪雷()
  }
  else {
    赤疾风()
  }
  return true
}

单体攻击() {
  if (isChanting()) {
    return
  }
  isBR := hasStatus("赤火炎预备")
  isWR := hasStatus("赤飞石预备")
  if (长单体(isBR, isWR)) {
    asr := 2
  }
  if (isMoving()) {
    续斩()
    asr := 2
  }
  短单体(isBR, isWR)
  促进()
  即刻咏唱()
  能力技()
}

群体攻击() {
  if (isChanting()) {
    return
  }
  isA := hasStatus("连续咏唱")
  isB := hasStatus("即刻咏唱")
  if (isA or isB) {
    散碎()
    asr := 2
  }
  if (isMoving()) {
    续斩()
    asr := 2
  }
  if (white >= black) {
    赤震雷()
  }
  else {
    赤烈风()
  }
  即刻咏唱()
  能力技()
}

魔三连() {
  isA := hasStatus("连续咏唱")
  isB := hasStatus("即刻咏唱")
  if (isA or isB) {
    攻击()
    asr := 2
  }
  if (焦热()) {
    asr := 2
  }
  if (赤神圣()) {
    asr := 2
  }
  if (连攻()) {
    asr := 2
    交剑()
    短兵相接()
  }
  if (交击斩()) {
    asr := 2
    鼓励()
  }
  if (回刺()) {
    asr := 2
    短兵相接()
  }
  能力技()
}

default() {
  SetTimer 清空信息, % 0 - 3000
  SetTimer 监听, 200
}

; default
default()

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