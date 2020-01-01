﻿; transpiled by coffee-basic

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

global mp := 0
global hasTarget := false
global isViewFar := false
global isReporting := true
global tsReport := 0
global 重劈时间戳 := 0
global 重劈冷却 := 5000
global 凶残裂时间戳 := 0
global 凶残裂冷却 := 5000
global 索敌时间戳 := 0
global 索敌冷却 := 3000

; function

clearTip() {
  ToolTip
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
  if (color == 0xFFC888) {
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

report() {
  if !(isReporting) {
    return
  }
  msg := "体力：" . hp . "% / 魔力：" . mp . "%"
  msg := "" . msg . "`n耗时：" . A_TickCount - tsReport . "ms`n"
  tsReport := A_TickCount
  ToolTip % msg, 410, 640
  SetTimer clearTip, Off
  SetTimer clearTip, % 0 - 5000
}

重劈() {
  if !(A_TickCount - 重劈时间戳 > 重劈冷却) {
    return false
  }
  Send {alt down}{1}{alt up}
  SetTimer 监听重劈, % 200
  return true
}

监听重劈() {
  if !(isUsed("重劈")) {
    return
  }
  重劈时间戳 := A_TickCount - 2000
  SetTimer 监听重劈, Off
}

凶残裂() {
  if !(A_TickCount - 凶残裂时间戳 > 凶残裂冷却) {
    return false
  }
  if !(A_TickCount - 重劈时间戳 < 15000) {
    return false
  }
  Send {alt down}{2}{alt up}
  SetTimer 监听凶残裂, % 200
  return true
}

监听凶残裂() {
  if !(isUsed("凶残裂")) {
    return
  }
  凶残裂时间戳 := A_TickCount - 2000
  重劈时间戳 := 0
  SetTimer 监听凶残裂, Off
}

狂暴() {
  Send {alt down}{3}{alt up}
}

超压斧() {
  Send {alt down}{4}{alt up}
}

守护() {
  Send {alt down}{5}{alt up}
}

飞斧() {
  Send {alt down}{6}{alt up}
}

暴风斩() {
  Send {alt down}{7}{alt up}
}

战栗() {
  Send {alt down}{8}{alt up}
}

复仇() {
  Send {alt down}{9}{alt up}
}

死斗() {
  Send {alt down}{0}{alt up}
}

暴风碎() {
  Send {alt down}{-}{alt up}
}

原初之魂() {
  Send {alt down}{=}{alt up}
}

秘银暴风() {
  Send {ctrl down}{1}{ctrl up}
}

钢铁旋风() {
  Send {ctrl down}{2}{ctrl up}
}

战壕() {
  Send {ctrl down}{3}{ctrl up}
}

裂石飞环() {
  Send {ctrl down}{4}{ctrl up}
}

原初的直觉() {
  Send {ctrl down}{5}{ctrl up}
}

泰然自若() {
  Send {ctrl down}{6}{ctrl up}
}

地毁人亡() {
  Send {ctrl down}{7}{ctrl up}
}

猛攻() {
  Send {ctrl down}{8}{ctrl up}
}

动乱() {
  Send {ctrl down}{9}{ctrl up}
}

摆脱() {
  Send {ctrl down}{0}{ctrl up}
}

原初的解放() {
  Send {ctrl down}{-}{ctrl up}
}

原初的勇猛() {
  Send {ctrl down}{=}{ctrl up}
}

混沌旋风() {
  Send {shift down}{1}{shift up}
}

狂魂() {
  Send {shift down}{2}{shift up}
}

铁壁() {
  Send {shift down}{3}{shift up}
}

下踢() {
  Send {shift down}{4}{shift up}
}

挑衅() {
  Send {shift down}{5}{shift up}
}

插言() {
  Send {shift down}{6}{shift up}
}

雪仇() {
  Send {shift down}{7}{shift up}
}

亲疏自行() {
  Send {shift down}{8}{shift up}
}

退避() {
  Send {shift down}{9}{shift up}
}

索敌() {
  if !(A_TickCount - 索敌时间戳 > 索敌冷却) {
    return false
  }
  if (isChanting()) {
    return false
  }
  Send {shift down}{-}{shift up}
  索敌时间戳 := A_TickCount - 2000
  return true
}

清空信息() {
  Send {shift down}{=}{shift up}
}

单体攻击() {
  if (凶残裂()) {
    return
  }
  重劈()
}

群体攻击() {
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

f9::
  MouseGetPos x, y
  PixelGetColor color, x, y, RGB
  ToolTip % "" . x . ", " . y . ", " . color . ""
return

f6::
  PixelSearch x, y, 0, 0, A_ScreenWidth, A_ScreenHeight, 0x58483E, 0, Fast RGB
  MouseMove x, y, 0
  ToolTip % "" . x . ", " . y . ""
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
  SetTimer 绑定攻击, % 300
  攻击()
return

; eof