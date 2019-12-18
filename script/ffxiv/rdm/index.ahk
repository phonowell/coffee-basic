; transpiled by coffee-basic

if (A_IsAdmin != true) {
  Run *RunAs "%A_ScriptFullPath%"
  ExitApp
}

#KeyHistory 0
#MaxThreads 20
#NoEnv
#Persistent
#SingleInstance Force
#UseHook

CoordMode Mouse, Client
CoordMode Pixel, Client
CoordMode ToolTip, Client
SendMode Event
SetBatchLines 100ms
SetKeyDelay 0, 50
SetMouseDelay 0, 50

; global

global ehp := 0
global hp := 0
global mp := 0
global isViewFar := false
global black := 0
global distance := "far"
global white := 0
global isReporting := true
global tsReport := 0
global asr := 0
global 回刺时间戳 := 0
global 回刺冷却 := 10000
global 短兵相接时间戳 := 0
global 短兵相接冷却 := 40000
global 交击斩时间戳 := 0
global 交击斩冷却 := 10000
global 移转时间戳 := 0
global 移转冷却 := 35000
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
global 能力时间戳 := 0
global 能力冷却 := 300
global 赤神圣时间戳 := 0
global 赤神圣冷却 := 10000
global 焦热时间戳 := 0
global 焦热冷却 := 10000

; function

clearTip() {
  ToolTip
}

getEnemyHp() {
  PixelGetColor color, 650, 65, RGB
  if !(color == 0xFF8888) {
    return 0
  }
  PixelSearch x, y, 650, 65, 1084, 65, 0x471515, 0, Fast RGB
  if !(x) {
    return 100
  }
  percent := (x - 650) * 100 / (1084 - 650)
  percent := Floor(percent)
  return percent
}

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
  PixelSearch x, y, 21, 36, 168, 36, 0x58483E, 10, Fast RGB
  if !(x) {
    return 100
  }
  percent := (x - 21) * 100 / (168 - 21)
  percent := Floor(percent)
  return percent
}

getMp() {
  PixelSearch x, y, 181, 36, 328, 36, 0x58483E, 10, Fast RGB
  if !(x) {
    return 100
  }
  percent := (x - 181) * 100 / (328 - 181)
  percent := Floor(percent)
  return percent
}

hasStatus(name) {
  ImageSearch x, y, 725, 840, 925, 875, % A_ScriptDir . "\" . "image\" . name . ".png"
  if (x > 0 and y > 0) {
    return true
  }
  return false
}

hasStatusTarget(name) {
  ImageSearch x, y, 725, 765, 925, 800, % A_ScriptDir . "\" . "image\" . name . ".png"
  if (x > 0 and y > 0) {
    return true
  }
  return false
}

isUsed(name) {
  ImageSearch x, y, 60, 915, 225, 975, % A_ScriptDir . "\" . "image\" . name . ".png"
  if (x > 0 and y > 0) {
    return true
  }
  return false
}

isChanting() {
  PixelGetColor color, 1010, 612, RGB
  return color == 0x58483E
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

reset() {
  Send {alt up}
  Send {ctrl up}
  Send {shift up}
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

攻击() {
  group := getGroup()
  if !(group) {
    return
  }
  report()
  索敌()
  black := getBlack()
  white := getWhite()
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
    SetTimer 清空信息, % 0 - 10000
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
  report()
  索敌()
  black := getBlack()
  white := getWhite()
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
    SetTimer 清空信息, % 0 - 5000
    return
  }
  SetTimer 清空信息, Off
  特殊攻击()
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
  PixelSearch x, y, 1023, 811, 1170, 811, 0x58483E, 10, Fast RGB
  if !(x) {
    return 100
  }
  percent := (x - 1023) * 100 / (1170 - 1023)
  percent := Floor(percent)
  return percent
}

getDistance() {
  PixelGetColor color, 1079, 961, RGB
  if (color == 0xD53B3B) {
    return "far"
  }
  if (color == 0x9A1E1F) {
    return "far"
  }
  return "near"
}

getWhite() {
  PixelSearch x, y, 1023, 798, 1170, 798, 0x58483E, 10, Fast RGB
  if !(x) {
    return 100
  }
  percent := (x - 1023) * 100 / (1170 - 1023)
  percent := Floor(percent)
  return percent
}

report() {
  black := getBlack()
  distance := getDistance()
  ehp := getEnemyHp()
  white := getWhite()
  if !(isReporting) {
    return
  }
  msg := "目标体力：" . ehp . "% / 目标距离：" . distance . ""
  msg := "" . msg . "`n魔力：" . mp . "% / 黑：" . black . " / 白：" . white . ""
  msg := "" . msg . "`n能力技余额：" . asr . "`n"
  msg := "" . msg . "`n耗时：" . A_TickCount - tsReport . "ms`n"
  tsReport := A_TickCount
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
  ToolTip % msg, 410, 640
  SetTimer clearTip, Off
  SetTimer clearTip, % 0 - 5000
}

回刺() {
  if !(A_TickCount - 回刺时间戳 > 回刺冷却) {
    return false
  }
  if !(black >= 80 and white >= 80) {
    return false
  }
  Send {alt down}{1}{alt up}
  SetTimer 监听回刺, 200
  return true
}

监听回刺() {
  if !(isUsed("魔回刺")) {
    return
  }
  回刺时间戳 := A_TickCount - 1500
  SetTimer 监听回刺, Off
}

摇荡() {
  Send {alt down}{2}{alt up}
}

赤闪雷() {
  Send {alt down}{3}{alt up}
}

短兵相接(isForced := false) {
  if !(asr > 0) {
    return false
  }
  if !(A_TickCount - 短兵相接时间戳 > 短兵相接冷却) {
    return false
  }
  if !(distance == "near" or isForced) {
    return false
  }
  Send {alt down}{4}{alt up}
  asr--
  SetTimer 监听短兵相接, 200
  return true
}

监听短兵相接() {
  if !(isUsed("短兵相接")) {
    return
  }
  短兵相接时间戳 := A_TickCount - 1500
  SetTimer 短兵相接, Off
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
  if !(A_TickCount - 回刺时间戳 < 15000) {
    return false
  }
  if !(black >= 50 and white >= 50) {
    return false
  }
  Send {alt down}{-}{alt up}
  SetTimer 监听交击斩, 200
  return true
}

监听交击斩() {
  if !(isUsed("魔交击斩")) {
    return
  }
  交击斩时间戳 := A_TickCount - 1500
  SetTimer 监听交击斩, Off
}

移转() {
  if !(asr > 0) {
    return false
  }
  if !(A_TickCount - 移转时间戳 > 移转冷却) {
    return false
  }
  if !(A_TickCount - 回刺时间戳 > 15000) {
    return false
  }
  if (black > 70 or white > 70) {
    return false
  }
  Send {alt down}{=}{alt up}
  asr--
  SetTimer 监听移转, 200
  return true
}

监听移转() {
  if !(isUsed("移转")) {
    return
  }
  移转时间戳 := A_TickCount - 1500
  SetTimer 监听移转, Off
}

飞刺() {
  if !(asr > 0) {
    return false
  }
  if !(A_TickCount - 飞刺时间戳 > 飞刺冷却) {
    return false
  }
  Send {ctrl down}{1}{ctrl up}
  asr--
  SetTimer 监听飞刺, 200
  return true
}

监听飞刺() {
  if !(isUsed("飞刺")) {
    return
  }
  飞刺时间戳 := A_TickCount - 1500
  SetTimer 监听飞刺, Off
}

连攻() {
  if !(A_TickCount - 连攻时间戳 > 连攻冷却) {
    return false
  }
  if !(A_TickCount - 交击斩时间戳 < 15000) {
    return false
  }
  if !(black >= 25 and white >= 25) {
    return false
  }
  Send {ctrl down}{2}{ctrl up}
  SetTimer 监听连攻, 200
  return true
}

监听连攻() {
  if !(isUsed("魔连攻")) {
    return
  }
  连攻时间戳 := A_TickCount - 1500
  SetTimer 监听连攻, Off
}

促进() {
  if !(asr > 0) {
    return false
  }
  if !(A_TickCount - 促进时间戳 > 促进冷却) {
    return false
  }
  if (black > 70 or white > 70) {
    return false
  }
  isBR := hasStatus("赤火炎预备")
  isWR := hasStatus("赤飞石预备"+)
  if (isBR or isWR) {
    return false
  }
  Send {ctrl down}{3}{ctrl up}
  asr--
  SetTimer 监听促进, 200
  return true
}

监听促进() {
  if !(hasStatus("促进")) {
    return
  }
  促进时间戳 := A_TickCount - 1500
  SetTimer 监听促进, Off
}

划圆斩() {
  if !(black >= 20 and white >= 20) {
    return false
  }
  Send {ctrl down}{4}{ctrl up}
  if !(isUsed("魔划圆斩")) {
    return false
  }
  划圆斩时间戳 := A_TickCount - 1500
  return true
}

赤治疗() {
  Send {ctrl down}{5}{ctrl up}
}

六分反击() {
  if !(asr > 0) {
    return false
  }
  if !(A_TickCount - 六分反击时间戳 > 六分反击冷却) {
    return false
  }
  Send {ctrl down}{6}{ctrl up}
  asr--
  SetTimer 监听六分反击, 0
  return true
}

监听六分反击() {
  if !(isUsed("六分反击")) {
    return
  }
  六分反击时间戳 := A_TickCount - 1500
  SetTimer 监听六分反击, Off
}

鼓励() {
  if !(asr > 0) {
    return false
  }
  if !(A_TickCount - 鼓励时间戳 > 鼓励冷却) {
    return false
  }
  Send {ctrl down}{7}{ctrl up}
  asr--
  SetTimer 监听鼓励, 200
  return true
}

监听鼓励() {
  if !(isUsed("鼓励")) {
    return
  }
  鼓励时间戳 := A_TickCount - 1500
  SetTimer 监听鼓励, Off
}

倍增() {
  if !(asr > 0) {
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
  SetTimer 监听倍增, 200
  return true
}

监听倍增() {
  if !(isUsed("倍增")) {
    return
  }
  倍增时间戳 := A_TickCount - 1500
  短兵相接时间戳 := 0
  移转时间戳 := 0
  交剑时间戳 := 0
  SetTimer 监听倍增, Off
}

赤复活() {
  Send {ctrl down}{9}{ctrl up}
}

交剑() {
  if !(asr > 0) {
    return false
  }
  if !(A_TickCount - 交剑时间戳 > 交剑冷却) {
    return false
  }
  if !(distance == "near") {
    return false
  }
  Send {ctrl down}{0}{ctrl up}
  asr--
  SetTimer 监听交剑, 200
  return true
}

监听交剑() {
  if !(isUsed("交剑")) {
    return
  }
  交剑时间戳 := A_TickCount - 1500
  SetTimer 监听交剑, Off
}

续斩() {
  Send {ctrl down}{-}{ctrl up}
}

昏乱() {
  Send {ctrl down}{=}{ctrl up}
}

即刻咏唱() {
  if !(asr > 0) {
    return false
  }
  if !(A_TickCount - 即刻咏唱时间戳 > 即刻咏唱冷却) {
    return false
  }
  if !(A_TickCount - 回刺时间戳 > 回刺冷却) {
    return false
  }
  if (black > 70 or white > 70) {
    return false
  }
  if (hasStatus("连续咏唱")) {
    return false
  }
  isBR := hasStatus("赤火炎预备")
  isWR := hasStatus("赤飞石预备")
  if (isBR and isWR) {
    return
  }
  Send {shift down}{1}{shift up}
  asr--
  SetTimer 监听即刻咏唱, 200
  return true
}

监听即刻咏唱() {
  if !(hasStatus("即刻咏唱")) {
    return
  }
  即刻咏唱时间戳 := A_TickCount - 1500
  SetTimer 监听即刻咏唱, Off
}

醒梦() {
  if !(asr > 0) {
    return false
  }
  if !(A_TickCount - 醒梦时间戳 > 醒梦冷却) {
    return false
  }
  mp := getMp()
  if (mp > 50) {
    return false
  }
  Send {shift down}{2}{shift up}
  asr--
  SetTimer 监听醒梦, 200
  return true
}

监听醒梦() {
  if !(hasStatus("醒梦")) {
    return
  }
  醒梦时间戳 := A_TickCount - 1500
  SetTimer 监听醒梦, Off
}

沉稳咏唱() {
  Send {shift down}{3}{shift up}
}

索敌() {
  if (ehp) {
    return false
  }
  Send {f11}
  return true
}

清空信息() {
  Send {shift down}{=}{shift up}
}

能力技() {
  if !(asr > 0) {
    return false
  }
  if !(A_TickCount - 能力时间戳 > 能力冷却) {
    return false
  }
  能力时间戳 := A_TickCount
  if (飞刺()) {
    return true
  }
  if (六分反击()) {
    return true
  }
  if (短兵相接()) {
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
  if !(A_TickCount - 连攻时间戳 < 15000) {
    return false
  }
  SetTimer 监听赤神圣, 200
  if (black - white > 9) {
    赤疾风()
    return true
  }
  if (white - black > 9) {
    赤闪雷()
    return true
  }
  isBR := hasStatus("赤火炎预备")
  isWR := hasStatus("赤飞石预备")
  if (isBR and isWR) {
    if (black > white) {
      赤疾风()
    }
    else {
      赤闪雷()
    }
    return true
  }
  if (isBR) {
    赤疾风()
    return true
  }
  if (isWR) {
    赤闪雷()
    return true
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
  isBR := isUsed("赤核爆")
  isWR := isUsed("赤神圣")
  if !(isBR or isWR) {
    return
  }
  赤神圣时间戳 := A_TickCount - 1500
  SetTimer 监听赤神圣, Off
}

焦热() {
  if !(A_TickCount - 焦热时间戳 > 焦热冷却) {
    单体攻击()
    SoundBeep
    return false
  }
  if !(A_TickCount - 赤神圣时间戳 < 15000) {
    return false
  }
  摇荡()
  SetTimer 监听焦热, 200
  return true
}

监听焦热() {
  if !(isUsed("焦热")) {
    return
  }
  焦热时间戳 := A_TickCount - 1500
  SetTimer 监听焦热, Off
}

单体攻击() {
  if (isChanting()) {
    return
  }
  isA := hasStatus("连续咏唱")
  isB := hasStatus("即刻咏唱")
  isBR := hasStatus("赤火炎预备")
  isWR := hasStatus("赤飞石预备")
  if (black > 85 and white > 85) {
    续斩()
    asr := 2
    return
  }
  if (长单体(isA, isB, isBR, isWR)) {
    asr := 2
    return
  }
  if (isMoving()) {
    续斩()
    asr := 2
    return
  }
  短单体(isA, isB, isBR, isWR)
  倍增()
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
    return
  }
  if (isMoving()) {
    续斩()
    asr := 2
    return
  }
  if (white >= black) {
    赤震雷()
  }
  else {
    赤烈风()
  }
  倍增()
  即刻咏唱()
  能力技()
}

魔三连() {
  isValid := true
  if (hasStatus("连续咏唱")) {
    isValid := false
  }
  if (hasStatus("即刻咏唱")) {
    isValid := false
  }
  if !(isValid) {
    单体攻击()
    return
  }
  if !(distance == "near") {
    asr := 1
    短兵相接(true)
    return
  }
  if (回刺()) {
    asr := 2
    return
  }
  if (交击斩()) {
    asr := 2
    鼓励()
    return
  }
  if (连攻()) {
    asr := 2
    return
  }
  if (赤神圣()) {
    asr := 2
    return
  }
  if (焦热()) {
    asr := 2
    return
  }
  能力技()
}

短单体(isA, isB, isBR, isWR) {
  if (isA or isB) {
    return
  }
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

长单体(isA, isB, isBR, isWR) {
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

; bind

f2::
  toggleView()
return

f4::
  isReporting := !isReporting
  if (isReporting) {
    report()
  }
  else {
    ToolTip
  }
return

f5::
  清空信息()
  reset()
  SoundBeep
  Reload
return

f6::
  PixelSearch x, y, 0, 0, A_ScreenWidth, A_ScreenHeight, 0x58483E, 0, Fast RGB
  MouseMove x, y, 0
  ToolTip % "" . x . ", " . y . ""
return

f9::
  MouseGetPos x, y
  PixelGetColor color, x, y, RGB
  ToolTip % "" . x . ", " . y . ", " . color . ""
return

f10::
  SoundBeep
  reset()
  ExitApp
return

2joy4::
  if !(getGroup()) {
    return
  }
  SetTimer 绑定攻击, Off
  SetTimer 绑定攻击, 300
  攻击()
return

2joy2::
  if !(getGroup()) {
    return
  }
  SetTimer 绑定特殊攻击, Off
  SetTimer 绑定特殊攻击, 300
  特殊攻击()
return

2joy3::
  group := getGroup()
  if !(group) {
    return
  }
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