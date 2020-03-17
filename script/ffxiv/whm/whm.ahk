﻿; generated by coffee-basic/0.0.2

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

; global variable

global mp := 0
global hasTarget := false
global red := 0
global white := 0
global isReporting := false
global tsReport := 0
global level := 80
global ts := {}
global cd := {}

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
  PixelGetColor color, 1130, 865, RGB
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
  if (color == 0xFFB1FF) {
    return true
  }
  return false
}

resetKey() {
  Send {alt up}
  Send {ctrl up}
  Send {shift up}
}

resetTs() {
  for key, value in ts {
    ts[key] := 0
  }
}

setLevel() {
  InputBox level, , % "input level", , , , , , , , % level
  if !(level > 0) {
    level := 80
  }
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
  msg := "等级：" . level . " / 魔力：" . mp . "%"
  msg := "" . msg . "`n白：" . white . " / 红：" . red . ""
  msg := "" . msg . "`n耗时：" . A_TickCount - tsReport . "ms`n"
  tsReport := A_TickCount
  msg := makeMsg(msg, "神速咏唱", ts.神速咏唱, cd.神速咏唱)
  msg := makeMsg(msg, "法令", ts.法令, cd.法令)
  msg := makeMsg(msg, "无中生有", ts.无中生有, cd.无中生有)
  msg := makeMsg(msg, "神名", ts.神名, cd.神名)
  msg := makeMsg(msg, "全大赦", ts.全大赦, cd.全大赦)
  msg := makeMsg(msg, "即刻咏唱", ts.即刻咏唱, cd.即刻咏唱)
  msg := makeMsg(msg, "醒梦", ts.醒梦, cd.醒梦)
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
  if !(A_TickCount - ts.神速咏唱 > cd.神速咏唱) {
    return false
  }
  Send {alt down}{9}{alt up}
  ts.神速咏唱 := A_TickCount - cd.神速咏唱 + cd.技能施放补正
  SetTimer 监听神速咏唱, % cd.技能施放判断间隔
  return true
}

监听神速咏唱() {
  if !(hasStatus("神速咏唱")) {
    return
  }
  SetTimer 监听神速咏唱, Off
  ts.神速咏唱 := A_TickCount - cd.技能施放补正
}

再生() {
  if (hasStatusTarget("再生")) {
    return false
  }
  if !(cd.能力技判断()) {
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
  if !(cd.能力技判断()) {
    return false
  }
  Send {ctrl down}{2}{ctrl up}
  return true
}

庇护所() {
  Send {ctrl down}{3}{ctrl up}
}

法令() {
  if !(A_TickCount - ts.法令 > cd.法令) {
    return false
  }
  Send {ctrl down}{4}{ctrl up}
  ts.法令 := A_TickCount - cd.法令 + cd.技能施放补正
  SetTimer 监听法令, % cd.技能施放判断间隔
  return true
}

监听法令() {
  if !(isUsed("法令")) {
    return
  }
  SetTimer 监听法令, Off
  ts.法令 := A_TickCount - cd.技能施放补正
}

无中生有() {
  if !(A_TickCount - ts.无中生有 > cd.无中生有) {
    return false
  }
  Send {ctrl down}{5}{ctrl up}
  ts.无中生有 := A_TickCount - cd.无中生有 + cd.技能施放补正
  SetTimer 监听无中生有, % cd.技能施放判断间隔
  return true
}

监听无中生有() {
  if !(hasStatus("无中生有")) {
    return
  }
  SetTimer 监听无中生有, Off
  ts.无中生有 := A_TickCount - cd.技能施放补正
}

神名() {
  if !(A_TickCount - ts.神名 > cd.神名) {
    return false
  }
  if !(cd.能力技判断()) {
    return false
  }
  Send {ctrl down}{6}{ctrl up}
  ts.神名 := A_TickCount - cd.神名 + cd.技能施放补正
  SetTimer 监听神名, % cd.技能施放判断间隔
  return true
}

监听神名() {
  if !(isUsed("神名")) {
    return
  }
  SetTimer 监听神名, Off
  ts.神名 := A_TickCount - cd.技能施放补正
}

神祝祷() {
  Send {ctrl down}{7}{ctrl up}
}

全大赦() {
  if !(A_TickCount - ts.全大赦 > cd.全大赦) {
    return false
  }
  if !(cd.能力技判断()) {
    return false
  }
  Send {ctrl down}{8}{ctrl up}
  ts.全大赦 := A_TickCount - cd.全大赦 + cd.技能施放补正
  SetTimer 监听全大赦, % cd.技能施放判断间隔
  return true
}

监听全大赦() {
  if !(isUsed("全大赦")) {
    return
  }
  SetTimer 监听全大赦, Off
  ts.全大赦 := A_TickCount - cd.技能施放补正
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
  if !(cd.能力技判断()) {
    return false
  }
  Send {ctrl down}{0}{ctrl up}
  return true
}

节制() {
  Send {ctrl down}{-}{ctrl up}
}

沉静() {
  Send {shift down}{1}{shift up}
}

康复() {
  Send {shift down}{2}{shift up}
}

即刻咏唱() {
  if !(A_TickCount - ts.即刻咏唱 > cd.即刻咏唱) {
    return false
  }
  Send {shift down}{3}{shift up}
  ts.即刻咏唱 := A_TickCount - cd.即刻咏唱 + cd.技能施放补正
  SetTimer 监听即刻咏唱, % cd.技能施放判断间隔
  return true
}

监听即刻咏唱() {
  if !(hasStatus("即刻咏唱")) {
    return
  }
  SetTimer 监听即刻咏唱, Off
  ts.即刻咏唱 := A_TickCount - cd.技能施放补正
}

醒梦() {
  if !(A_TickCount - ts.醒梦 > cd.醒梦) {
    return false
  }
  mp := getMp()
  if (mp > 50) {
    return false
  }
  Send {shift down}{4}{shift up}
  ts.醒梦 := A_TickCount - cd.醒梦 + cd.技能施放补正
  SetTimer 监听醒梦, % cd.技能施放判断间隔
  return true
}

监听醒梦() {
  if !(hasStatus("醒梦")) {
    return
  }
  SetTimer 监听醒梦, Off
  ts.醒梦 := A_TickCount - cd.技能施放补正
}

沉稳咏唱() {
  Send {shift down}{5}{shift up}
}

营救() {
  Send {shift down}{6}{shift up}
}

冲刺() {
  Send {shift down}{-}{shift up}
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

cd.能力技判断() {
  if !(A_TickCount - ts.能力技 > cd.能力技) {
    return false
  }
  ts.能力技 := A_TickCount
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

__$default__() {
  cd.技能施放判断间隔 := 100
  cd.技能施放补正 := 1500
  ts.神速咏唱 := 0
  cd.神速咏唱 := 150000
  ts.法令 := 0
  cd.法令 := 45000
  ts.无中生有 := 0
  cd.无中生有 := 120000
  ts.神名 := 0
  cd.神名 := 60000
  ts.全大赦 := 0
  cd.全大赦 := 60000
  ts.即刻咏唱 := 0
  cd.即刻咏唱 := 60000
  ts.醒梦 := 0
  cd.醒梦 := 60000
  ts.能力技 := 0
  cd.能力技 := 300
}

; default
__$default__()

; event

f5::
  清空信息()
  resetKey()
  resetTs()
  SoundBeep
  setLevel()
return

^f5::
  清空信息()
  resetKey()
  SoundBeep
  Reload
return

!f4::
  resetKey()
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

2joy5::
  if !(getGroup() == "both") {
    return
  }
  Send {shift down}{tab}{shift up}
return

2joy6::
  if !(getGroup() == "both") {
    return
  }
  Send {tab}
return

2joy12::
  if !(getGroup()) {
    return
  }
  冲刺()
return

; eof