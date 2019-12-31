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
global hasTarget := false
global isViewFar := false
global isDotEnabled := true
global element := false
global isMpLacking := false
global isReporting := true
global tsReport := 0
global 闪雷时间戳 := 0
global 闪雷冷却 := 10000
global 震雷时间戳 := 0
global 震雷冷却 := 10000
global 即刻咏唱时间戳 := 0
global 即刻咏唱冷却 := 60000

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

isTargeting() {
  PixelGetColor color, 650, 65, RGB
  if (color == 0xFF8888) {
    return true
  }
  if (color == 0xEBD788) {
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
    SetTimer 清空信息, % 0 - 5000
    return
  }
  SetTimer 清空信息, Off
  攻击()
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

checkElement() {
  PixelGetColor color, 1030, 815, RGB
  if (color == 0xFFABA7) {
    element := "fire"
    return
  }
  if (color == 0x93C9FF) {
    element := "ice"
    return
  }
  element := false
}

checkMp() {
  mp := getMp()
  if (mp < 30 and isMpLacking == false) {
    isMpLacking := true
  }
  else if (mp > 70 and isMpLacking == true) {
    isMpLacking := false
  }
}

report() {
  if !(isReporting) {
    return
  }
  msg := "体力：" . hp . "% / 魔力：" . mp . "%"
  msg := "" . msg . "`n元素状态：" . element . ""
  msg := "" . msg . "`n使用Dot：" . isDotEnabled . ""
  msg := "" . msg . "`n耗时：" . A_TickCount - tsReport . "ms`n"
  tsReport := A_TickCount
  res := calcCD(即刻咏唱时间戳, 即刻咏唱冷却)
  if (res) {
    msg := "" . msg . "`n即刻咏唱：" . res . "s"
  }
  ToolTip % msg, 410, 640
  SetTimer clearTip, Off
  SetTimer clearTip, % 0 - 5000
}

冰结() {
  Send {alt down}{1}{alt up}
}

火炎() {
  Send {alt down}{2}{alt up}
}

星灵移位() {
  Send {alt down}{3}{alt up}
}

闪雷() {
  if (!isDotEnabled) {
    return false
  }
  if !(A_TickCount - 闪雷时间戳 > 闪雷冷却) {
    return false
  }
  if (hasStatusTarget("闪雷")) {
    return false
  }
  Send {alt down}{4}{alt up}
  闪雷时间戳 := A_TickCount - 2000
  return true
}

催眠() {
  Send {alt down}{5}{alt up}
}

冰冻() {
  Send {alt down}{6}{alt up}
}

崩溃() {
  Send {alt down}{7}{alt up}
}

烈炎() {
  Send {alt down}{8}{alt up}
}

震雷() {
  if !(A_TickCount - 震雷时间戳 > 震雷冷却) {
    return false
  }
  if (hasStatusTarget("震雷")) {
    return false
  }
  Send {alt down}{9}{alt up}
  震雷时间戳 := A_TickCount - 2000
  return true
}

魔罩() {
  Send {alt down}{0}{alt up}
}

爆炎() {
  Send {alt down}{-}{alt up}
}

以太步() {
  Send {alt down}{=}{alt up}
}

昏乱() {
  Send {shift down}{4}{shift up}
}

即刻咏唱() {
  if !(A_TickCount - 即刻咏唱时间戳 > 即刻咏唱冷却) {
    return false
  }
  Send {shift down}{5}{shift up}
  SetTimer 监听即刻咏唱, % 200
  return true
}

监听即刻咏唱() {
  if !(isUsed("即刻咏唱2")) {
    return
  }
  SetTimer 监听即刻咏唱, Off
  即刻咏唱时间戳 := A_TickCount - 2000
}

醒梦() {
  Send {shift down}{6}{shift up}
}

沉稳咏唱() {
  Send {shift down}{7}{shift up}
}

索敌() {
  ehp := getEnemyHp()
  if (ehp) {
    return false
  }
  Send {f11}
  return true
}

清空信息() {
  Send {shift down}{=}{shift up}
}

单体攻击() {
  if (isChanting()) {
    return
  }
  if (isMoving()) {
    即刻咏唱()
  }
  if (闪雷()) {
    return
  }
  checkMp()
  checkElement()
  if (isMpLacking) {
    if (element == "fire") {
      星灵移位()
      return
    }
    冰结()
    return
  }
  if (element == "ice") {
    星灵移位()
    return
  }
  火炎()
  return
}

群体攻击() {
  if (isChanting()) {
    return
  }
  if (isMoving()) {
    即刻咏唱()
  }
  if (震雷()) {
    return
  }
  checkMp()
  checkElement()
  if (isMpLacking) {
    if (element == "fire") {
      星灵移位()
      return
    }
    冰冻()
    return
  }
  if (element == "ice") {
    星灵移位()
    return
  }
  烈炎()
  return
}

default() {
  SetTimer 清空信息, % 0 - 3000
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

f6::
  MouseGetPos x, y
  PixelGetColor color, x, y, RGB
  ToolTip % "" . x . ", " . y . ", " . color . ""
return

f9::
  PixelSearch x, y, 0, 0, A_ScreenWidth, A_ScreenHeight, 0x58483E, 0, Fast RGB
  MouseMove x, y, 0
  ToolTip % "" . x . ", " . y . ""
return

f10::
  SoundBeep
  ExitApp
return

2joy13::
  isDotEnabled := !isDotEnabled
  SoundBeep
return

2joy4::
  if !(getGroup()) {
    return
  }
  SetTimer 绑定攻击, Off
  SetTimer 绑定攻击, % 300
  攻击()
return

; eof