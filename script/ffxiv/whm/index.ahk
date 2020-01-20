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
global red := 0
global white := 0
global isReporting := true
global tsReport := 0
global 技能施放判断间隔 := 100
global 技能施放时间戳补正 := 1500
global 神速咏唱时间戳 := 0
global 神速咏唱冷却 := 150000
global 法令时间戳 := 0
global 法令冷却 := 45000
global 无中生有时间戳 := 0
global 无中生有冷却 := 120000
global 神名时间戳 := 0
global 神名冷却 := 60000
global 全大赦时间戳 := 0
global 全大赦冷却 := 60000
global 即刻咏唱时间戳 := 0
global 即刻咏唱冷却 := 60000
global 醒梦时间戳 := 0
global 醒梦冷却 := 60000
global 能力技时间戳 := 0
global 能力技冷却 := 300

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
  if !(索敌()) {
    return
  }
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

_治疗() {
  group := getGroup()
  if !(group) {
    return
  }
  report()
  if (group == "right") {
    单体治疗()
    return
  }
  if (group == "both") {
    群体治疗()
    return
  }
}

绑定治疗() {
  GetKeyState __value__, 2joy2
  isPressing := __value__ == "D"
  if !(isPressing) {
    SetTimer 绑定治疗, Off
    SetTimer 清空信息, % 0 - 10000
    return
  }
  SetTimer 清空信息, Off
  _治疗()
}

getRed() {
  PixelGetColor color, 1075, 818, RGB
  if !(color == 0xDEB673) {
    return 3
  }
  PixelGetColor color, 1057, 818, RGB
  if !(color == 0xDEB673) {
    return 2
  }
  PixelGetColor color, 1039, 818, RGB
  if !(color == 0xDEB673) {
    return 1
  }
  return 0
}

getWhite() {
  PixelGetColor color, 1078, 790, RGB
  if !(color == 0xD6B273) {
    return 3
  }
  PixelGetColor color, 1058, 790, RGB
  if !(color == 0xD6B273) {
    return 2
  }
  PixelGetColor color, 1038, 790, RGB
  if !(color == 0xD6B273) {
    return 1
  }
  return 0
}

calcCD(ts, cd) {
  result := cd - (A_TickCount - ts)
  if !(result > 0) {
    return 0
  }
  result := result / 1000
  result := Round(result)
  return result
}

makeMsg(msg, prefix, ts, cd) {
  res := calcCD(ts, cd)
  if !(res) {
    return msg
  }
  return "" . msg . "`n" . prefix . "：" . res . "s"
}

report() {
  red := getRed()
  white := getWhite()
  if !(isReporting) {
    return
  }
  msg := "魔力：" . mp . "% / 白：" . white . " / 红：" . red . ""
  msg := "" . msg . "`n耗时：" . A_TickCount - tsReport . "ms`n"
  tsReport := A_TickCount
  msg := makeMsg(msg, "神速咏唱", 神速咏唱时间戳, 神速咏唱冷却)
  msg := makeMsg(msg, "法令", 法令时间戳, 法令冷却)
  msg := makeMsg(msg, "无中生有", 无中生有时间戳, 无中生有冷却)
  msg := makeMsg(msg, "神名", 神名时间戳, 神名冷却)
  msg := makeMsg(msg, "全大赦", 全大赦时间戳, 全大赦冷却)
  msg := makeMsg(msg, "即刻咏唱", 即刻咏唱时间戳, 即刻咏唱冷却)
  msg := makeMsg(msg, "醒梦", 醒梦时间戳, 醒梦冷却)
  ToolTip % msg, 410, 640
  SetTimer clearTip, Off
  SetTimer clearTip, % 0 - 5000
}

飞石() {
  Send {alt down}{1}{alt up}
}

治疗() {
  Send {alt down}{2}{alt up}
}

疾风() {
  if !(isMoving()) {
    if (hasStatusTarget("天辉")) {
      return false
    }
    if (hasStatusTarget("烈风")) {
      return false
    }
    if (hasStatusTarget("疾风")) {
      return false
    }
  }
  Send {alt down}{3}{alt up}
  return true
}

医治() {
  Send {alt down}{4}{alt up}
}

复活() {
  Send {alt down}{5}{alt up}
}

水流环() {
  Send {alt down}{6}{alt up}
}

救疗() {
  Send {alt down}{7}{alt up}
}

医济() {
  if (hasStatus("医济")) {
    return false
  }
  Send {alt down}{8}{alt up}
  return true
}

神速咏唱() {
  if !(A_TickCount - 神速咏唱时间戳 > 神速咏唱冷却) {
    return false
  }
  Send {alt down}{9}{alt up}
  神速咏唱时间戳 := A_TickCount - 神速咏唱冷却 + 技能施放时间戳补正
  SetTimer 监听神速咏唱, % 技能施放判断间隔
  return true
}

监听神速咏唱() {
  if !(hasStatus("神速咏唱")) {
    return
  }
  SetTimer 监听神速咏唱, Off
  神速咏唱时间戳 := A_TickCount - 技能施放时间戳补正
}

再生() {
  if (hasStatusTarget("再生")) {
    return false
  }
  if !(能力技冷却判断()) {
    return false
  }
  Send {alt down}{0}{alt up}
  return true
}

愈疗() {
  Send {alt down}{-}{alt up}
}

神圣() {
  Send {alt down}{=}{alt up}
}

天赐祝福() {
  Send {ctrl down}{1}{ctrl up}
}

安慰之心() {
  if !(white >= 1) {
    return false
  }
  if !(能力技冷却判断()) {
    return false
  }
  Send {ctrl down}{2}{ctrl up}
  return true
}

庇护所() {
  Send {ctrl down}{3}{ctrl up}
}

法令() {
  if !(A_TickCount - 法令时间戳 > 法令冷却) {
    return false
  }
  Send {ctrl down}{4}{ctrl up}
  法令时间戳 := A_TickCount - 法令冷却 + 技能施放时间戳补正
  SetTimer 监听法令, % 技能施放判断间隔
  return true
}

监听法令() {
  if !(isUsed("法令")) {
    return
  }
  SetTimer 监听法令, Off
  法令时间戳 := A_TickCount - 技能施放时间戳补正
}

无中生有() {
  if !(A_TickCount - 无中生有时间戳 > 无中生有冷却) {
    return false
  }
  Send {ctrl down}{5}{ctrl up}
  无中生有时间戳 := A_TickCount - 无中生有冷却 + 技能施放时间戳补正
  SetTimer 监听无中生有, % 技能施放判断间隔
  return true
}

监听无中生有() {
  if !(hasStatus("无中生有")) {
    return
  }
  SetTimer 监听无中生有, Off
  无中生有时间戳 := A_TickCount - 技能施放时间戳补正
}

神名() {
  if !(A_TickCount - 神名时间戳 > 神名冷却) {
    return false
  }
  if !(能力技冷却判断()) {
    return false
  }
  Send {ctrl down}{6}{ctrl up}
  神名时间戳 := A_TickCount - 神名冷却 + 技能施放时间戳补正
  SetTimer 监听神名, % 技能施放判断间隔
  return true
}

监听神名() {
  if !(isUsed("神名")) {
    return
  }
  SetTimer 监听神名, Off
  神名时间戳 := A_TickCount - 技能施放时间戳补正
}

神祝祷() {
  Send {ctrl down}{7}{ctrl up}
}

全大赦() {
  if !(A_TickCount - 全大赦时间戳 > 全大赦冷却) {
    return false
  }
  if !(能力技冷却判断()) {
    return false
  }
  Send {ctrl down}{8}{ctrl up}
  全大赦时间戳 := A_TickCount - 全大赦冷却 + 技能施放时间戳补正
  SetTimer 监听全大赦, % 技能施放判断间隔
  return true
}

监听全大赦() {
  if !(isUsed("全大赦")) {
    return
  }
  SetTimer 监听全大赦, Off
  全大赦时间戳 := A_TickCount - 技能施放时间戳补正
}

苦难之心() {
  if !(red >= 3) {
    return false
  }
  Send {ctrl down}{9}{ctrl up}
  return true
}

狂喜之心() {
  if !(white >= 1) {
    return false
  }
  if !(能力技冷却判断()) {
    return false
  }
  Send {ctrl down}{0}{ctrl up}
  return true
}

节制() {
  Send {ctrl down}{-}{ctrl up}
}

沉静() {
  Send {ctrl down}{=}{ctrl up}
}

康复() {
  Send {shift down}{1}{shift up}
}

即刻咏唱() {
  if !(A_TickCount - 即刻咏唱时间戳 > 即刻咏唱冷却) {
    return false
  }
  Send {shift down}{2}{shift up}
  即刻咏唱时间戳 := A_TickCount - 即刻咏唱冷却 + 技能施放时间戳补正
  SetTimer 监听即刻咏唱, % 技能施放判断间隔
  return true
}

监听即刻咏唱() {
  if !(hasStatus("即刻咏唱")) {
    return
  }
  SetTimer 监听即刻咏唱, Off
  即刻咏唱时间戳 := A_TickCount - 技能施放时间戳补正
}

醒梦() {
  if !(A_TickCount - 醒梦时间戳 > 醒梦冷却) {
    return false
  }
  mp := getMp()
  if (mp > 50) {
    return false
  }
  Send {shift down}{3}{shift up}
  醒梦时间戳 := A_TickCount - 醒梦冷却 + 技能施放时间戳补正
  SetTimer 监听醒梦, % 技能施放判断间隔
  return true
}

监听醒梦() {
  if !(hasStatus("醒梦")) {
    return
  }
  SetTimer 监听醒梦, Off
  醒梦时间戳 := A_TickCount - 技能施放时间戳补正
}

沉稳咏唱() {
  Send {shift down}{4}{shift up}
}

营救() {
  Send {shift down}{5}{shift up}
}

清空信息() {
  Send {shift down}{=}{shift up}
}

索敌() {
  hasTarget := isTargeting()
  if (hasTarget) {
    return true
  }
  Send {f11}
  hasTarget := isTargeting()
  return hasTarget
}

中断咏唱() {
  if !(isChanting()) {
    return
  }
  Send {space}
}

能力技冷却判断() {
  if !(A_TickCount - 能力技时间戳 > 能力技冷却) {
    return false
  }
  能力技时间戳 := A_TickCount
  return true
}

单体攻击() {
  if (isChanting()) {
    return
  }
  醒梦()
  法令()
  苦难之心()
  神速咏唱()
  if (isMoving()) {
    疾风()
    return
  }
  疾风()
  飞石()
}

群体攻击() {
  if (isChanting()) {
    return
  }
  醒梦()
  法令()
  苦难之心()
  神速咏唱()
  无中生有()
  即刻咏唱()
  if (isMoving()) {
    疾风()
    return
  }
  神圣()
}

单体治疗() {
  if (isChanting()) {
    return
  }
  醒梦()
  法令()
  神名()
  安慰之心()
  再生()
  救疗()
  治疗()
}

群体治疗() {
  if (isChanting()) {
    return
  }
  醒梦()
  法令()
  全大赦()
  狂喜之心()
  医济()
  医治()
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
  SetTimer 绑定攻击, % 300
  攻击()
return

2joy2::
  if !(getGroup()) {
    return
  }
  SetTimer 绑定治疗, Off
  SetTimer 绑定治疗, % 300
  _治疗()
return

2joy1::
  group := getGroup()
  if !(group) {
    return
  }
  if (group == "right") {
    神祝祷()
    return
  }
  if (group == "both") {
    康复()
    return
  }
  if (group == "left") {
    即刻咏唱()
    无中生有()
    复活()
    return
  }
return

2joy3::
  group := getGroup()
  if !(group) {
    return
  }
  if (group == "right") {
    庇护所()
    return
  }
  if (group == "both") {
    无中生有()
    愈疗()
    return
  }
return

; eof