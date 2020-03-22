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
global black := 0
global distance := "far"
global white := 0
global isReporting := false
global tsReport := 0
global 能力技余额 := 0
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

特殊攻击() {
  group := getGroup()
  if !(group) {
    return
  }
  report()
  if !(索敌()) {
    return
  }
  if (group == "right") {
    魔三连()
    return
  }
  if (group == "both") {
    魔划圆斩()
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

治疗() {
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
    复活()
    return
  }
}

绑定治疗() {
  GetKeyState __value__, 2joy3
  isPressing := __value__ == "D"
  if !(isPressing) {
    SetTimer 绑定治疗, Off
    SetTimer 清空信息, % 0 - 10000
    return
  }
  SetTimer 清空信息, Off
  治疗()
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
  if !(hasTarget) {
    return "far"
  }
  PixelGetColor color, 1875, 723, RGB
  if (color == 0x1A1D1E) {
    return "near"
  }
  if (color == 0x101312) {
    return "near"
  }
  if (color == 0x101211) {
    return "near"
  }
  return "far"
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
  black := getBlack()
  white := getWhite()
  if !(isReporting) {
    return
  }
  msg := "等级：" . level . " / 魔力：" . mp . "%"
  msg := "" . msg . "`n黑：" . black . " / 白：" . white . ""
  msg := "" . msg . "`n目标距离：" . distance . ""
  msg := "" . msg . "`n耗时：" . A_TickCount - tsReport . "ms`n"
  tsReport := A_TickCount
  msg := makeMsg(msg, "短兵相接", ts.短兵相接, cd.短兵相接)
  msg := makeMsg(msg, "飞刺", ts.飞刺, cd.飞刺)
  msg := makeMsg(msg, "促进", ts.促进, cd.促进)
  msg := makeMsg(msg, "六分反击", ts.六分反击, cd.六分反击)
  msg := makeMsg(msg, "鼓励", ts.鼓励, cd.鼓励)
  msg := makeMsg(msg, "倍增", ts.倍增, cd.倍增)
  msg := makeMsg(msg, "交剑", ts.交剑, cd.交剑)
  msg := makeMsg(msg, "即刻咏唱", ts.即刻咏唱, cd.即刻咏唱)
  msg := makeMsg(msg, "醒梦", ts.醒梦, cd.醒梦)
  ToolTip % msg, 410, 640
  SetTimer clearTip, Off
  SetTimer clearTip, % 0 - 5000
}

回刺() {
  if !(A_TickCount - ts.回刺 > cd.回刺) {
    return false
  }
  if !(black >= 80 and white >= 80) {
    return false
  }
  中断咏唱()
  distance := getDistance()
  if !(distance == "near") {
    短兵相接(true)
    return false
  }
  Send {alt down}{1}{alt up}
  SetTimer 监听回刺, % cd.技能施放判断间隔
  return true
}

监听回刺() {
  if !(isUsed("魔回刺")) {
    return
  }
  SetTimer 监听回刺, Off
  ts.回刺 := A_TickCount - cd.技能施放补正
}

摇荡() {
  Send {alt down}{2}{alt up}
}

赤闪雷() {
  Send {alt down}{3}{alt up}
  ts.赤疾风 := A_TickCount
}

短兵相接(isForced := false) {
  if !(A_TickCount - ts.短兵相接 > cd.短兵相接) {
    return false
  }
  distance := getDistance()
  if !(distance == "near" or isForced) {
    return false
  }
  Send {alt down}{4}{alt up}
  ts.短兵相接 := A_TickCount - cd.短兵相接 + cd.技能施放补正
  SetTimer 监听短兵相接, % cd.技能施放判断间隔
  return true
}

监听短兵相接() {
  if !(isUsed("短兵相接")) {
    return
  }
  SetTimer 监听短兵相接, Off
  ts.短兵相接 := A_TickCount - cd.技能施放补正
}

赤疾风() {
  Send {alt down}{5}{alt up}
  ts.赤疾风 := A_TickCount
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
  if !(level >= 35) {
    return false
  }
  if !(A_TickCount - ts.交击斩 > cd.交击斩) {
    return false
  }
  if !(A_TickCount - ts.回刺 < cd.魔三连) {
    return false
  }
  if !(black >= 50 and white >= 50) {
    return false
  }
  Send {alt down}{-}{alt up}
  SetTimer 监听交击斩, % cd.技能施放判断间隔
  return true
}

监听交击斩() {
  if !(isUsed("魔交击斩")) {
    return
  }
  SetTimer 监听交击斩, Off
  ts.交击斩 := A_TickCount - cd.技能施放补正
}

移转() {
  if !(level >= 40) {
    return false
  }
  Send {alt down}{=}{alt up}
  return true
}

飞刺() {
  if !(level >= 45) {
    return false
  }
  if !(A_TickCount - ts.飞刺 > cd.飞刺) {
    return false
  }
  Send {ctrl down}{1}{ctrl up}
  ts.飞刺 := A_TickCount - cd.飞刺 + cd.技能施放补正
  SetTimer 监听飞刺, % cd.技能施放判断间隔
  return true
}

监听飞刺() {
  if !(isUsed("飞刺")) {
    return
  }
  SetTimer 监听飞刺, Off
  ts.飞刺 := A_TickCount - cd.技能施放补正
}

连攻() {
  if !(level >= 50) {
    return false
  }
  if !(A_TickCount - ts.连攻 > cd.连攻) {
    return false
  }
  if !(A_TickCount - ts.交击斩 < cd.魔三连) {
    return false
  }
  if !(black >= 25 and white >= 25) {
    return false
  }
  Send {ctrl down}{2}{ctrl up}
  SetTimer 监听连攻, % cd.技能施放判断间隔
  return true
}

监听连攻() {
  if !(isUsed("魔连攻")) {
    return
  }
  SetTimer 监听连攻, Off
  ts.连攻 := A_TickCount - cd.技能施放补正
}

促进() {
  if !(level >= 50) {
    return false
  }
  if !(A_TickCount - ts.促进 > cd.促进) {
    return false
  }
  if !(A_TickCount - ts.赤疾风 < 2000) {
    return false
  }
  if !(A_TickCount - ts.回刺 > cd.魔三连) {
    return false
  }
  if (black > 70 or white > 70) {
    return false
  }
  isBR := hasStatus("赤火炎预备")
  isWR := hasStatus("赤飞石预备")
  if (isBR or isWR) {
    return false
  }
  Send {ctrl down}{3}{ctrl up}
  ts.促进 := A_TickCount - cd.促进 + cd.技能施放补正
  SetTimer 监听促进, % cd.技能施放判断间隔
  return true
}

监听促进() {
  if !(isUsed("促进")) {
    return
  }
  SetTimer 监听促进, Off
  ts.促进 := A_TickCount - cd.技能施放补正
}

划圆斩() {
  if !(level >= 52) {
    return false
  }
  if !(black >= 20 and white >= 20) {
    return false
  }
  distance := getDistance()
  if !(distance == "near") {
    短兵相接(true)
    return false
  }
  Send {ctrl down}{4}{ctrl up}
  return true
}

赤治疗() {
  if !(level >= 54) {
    return false
  }
  Send {ctrl down}{5}{ctrl up}
  return true
}

六分反击() {
  if !(level >= 56) {
    return false
  }
  if !(A_TickCount - ts.六分反击 > cd.六分反击) {
    return false
  }
  Send {ctrl down}{6}{ctrl up}
  ts.六分反击 := A_TickCount - cd.六分反击 + cd.技能施放补正
  SetTimer 监听六分反击, % cd.技能施放判断间隔
  return true
}

监听六分反击() {
  if !(isUsed("六分反击")) {
    return
  }
  SetTimer 监听六分反击, Off
  ts.六分反击 := A_TickCount - cd.技能施放补正
}

鼓励() {
  if !(level >= 58) {
    return false
  }
  if !(A_TickCount - ts.鼓励 > cd.鼓励) {
    return false
  }
  if !(A_TickCount - ts.回刺 < cd.回刺) {
    return false
  }
  Send {ctrl down}{7}{ctrl up}
  ts.鼓励 := A_TickCount - cd.鼓励 + cd.技能施放补正
  SetTimer 监听鼓励, % cd.技能施放判断间隔
  return true
}

监听鼓励() {
  if !(isUsed("鼓励")) {
    return
  }
  SetTimer 监听鼓励, Off
  ts.鼓励 := A_TickCount - cd.技能施放补正
}

倍增() {
  if !(level >= 60) {
    return false
  }
  if !(A_TickCount - ts.倍增 > cd.倍增) {
    return false
  }
  if (A_TickCount - ts.回刺 < cd.魔三连) {
    return false
  }
  if !(black >= 40 and black <= 70) {
    return false
  }
  if !(white >= 40 and white <= 70) {
    return false
  }
  Send {ctrl down}{8}{ctrl up}
  ts.倍增 := A_TickCount - cd.倍增 + cd.技能施放补正
  SetTimer 监听倍增, % cd.技能施放判断间隔
  return true
}

监听倍增() {
  if !(isUsed("倍增")) {
    return
  }
  SetTimer 监听倍增, Off
  ts.倍增 := A_TickCount - cd.技能施放补正
  ts.短兵相接 := 0
  ts.移转 := 0
  ts.交剑 := 0
}

赤复活() {
  if !(level >= 64) {
    return false
  }
  Send {ctrl down}{9}{ctrl up}
  return true
}

交剑() {
  if !(level >= 72) {
    return false
  }
  if !(A_TickCount - ts.交剑 > cd.交剑) {
    return false
  }
  distance := getDistance()
  if !(distance == "near") {
    return false
  }
  Send {ctrl down}{0}{ctrl up}
  ts.交剑 := A_TickCount - cd.交剑 + cd.技能施放补正
  SetTimer 监听交剑, % cd.技能施放判断间隔
  return true
}

监听交剑() {
  if !(isUsed("交剑")) {
    return
  }
  SetTimer 监听交剑, Off
  ts.交剑 := A_TickCount - cd.技能施放补正
}

续斩() {
  if !(level >= 76) {
    return false
  }
  Send {ctrl down}{-}{ctrl up}
  return true
}

昏乱() {
  Send {shift down}{1}{shift up}
}

即刻咏唱() {
  if !(level >= 18) {
    return false
  }
  if !(A_TickCount - ts.即刻咏唱 > cd.即刻咏唱) {
    return false
  }
  if !(A_TickCount - ts.回刺 > cd.回刺) {
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
  Send {shift down}{2}{shift up}
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
  if !(level >= 24) {
    return false
  }
  if !(A_TickCount - ts.醒梦 > cd.醒梦) {
    return false
  }
  mp := getMp()
  if (mp > 50) {
    return false
  }
  Send {shift down}{3}{shift up}
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
  if !(level >= 44) {
    return false
  }
  Send {shift down}{4}{shift up}
  return true
}

冲刺() {
  Send {shift down}{-}{shift up}
}

清空信息() {
  Send {shift down}{=}{shift up}
}

赤神圣() {
  if !(level >= 70) {
    return false
  }
  if !(A_TickCount - ts.赤神圣 > cd.赤神圣) {
    return false
  }
  if !(A_TickCount - ts.连攻 < 15000) {
    return false
  }
  赤神圣施放()
  SetTimer 监听赤神圣, % cd.技能施放判断间隔
  return true
}

监听赤神圣() {
  isA := isUsed("赤核爆")
  isB := isUsed("赤神圣")
  if !(isA or isB) {
    return
  }
  SetTimer 监听赤神圣, Off
  ts.赤神圣 := A_TickCount - cd.技能施放补正
}

赤神圣施放() {
  if (black - white > 9) {
    赤疾风()
    return
  }
  if (white - black > 9) {
    赤闪雷()
    return
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
    return
  }
  if (isBR) {
    赤疾风()
    return
  }
  if (isWR) {
    赤闪雷()
    return
  }
  if (black > white) {
    赤疾风()
  }
  else {
    赤闪雷()
  }
}

焦热() {
  if !(level >= 80) {
    return false
  }
  if !(A_TickCount - ts.焦热 > cd.焦热) {
    SoundBeep
    return false
  }
  if !(A_TickCount - ts.赤神圣 < 15000) {
    return false
  }
  摇荡()
  SetTimer 监听焦热, % cd.技能施放判断间隔
  return true
}

监听焦热() {
  if !(isUsed("焦热")) {
    return
  }
  SetTimer 监听焦热, Off
  ts.焦热 := A_TickCount - cd.技能施放补正
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

能力技(n := 2) {
  if !(A_TickCount - ts.能力技 > cd.能力技) {
    return
  }
  ts.能力技 := A_TickCount
  能力技余额 := -n
  SetTimer 施放能力技, % 500
}

施放能力技() {
  if (能力技余额 < 0) {
    能力技余额 := -能力技余额
    return
  }
  if !(能力技余额 > 0) {
    SetTimer 施放能力技, Off
    return
  }
  能力技余额--
  能力技施放()
}

能力技施放() {
  if (倍增()) {
    return
  }
  if (鼓励()) {
    return
  }
  if (促进()) {
    return
  }
  if (即刻咏唱()) {
    return
  }
  if (飞刺()) {
    return
  }
  if (六分反击()) {
    return
  }
  if (短兵相接()) {
    return
  }
  if (交剑()) {
    return
  }
  if (醒梦()) {
    return
  }
}

单体攻击() {
  if (isChanting()) {
    return
  }
  isA := hasStatus("连续咏唱")
  isB := hasStatus("即刻咏唱")
  isBR := hasStatus("赤火炎预备")
  isWR := hasStatus("赤飞石预备")
  if (长单体(isA, isB, isBR, isWR)) {
    能力技()
    return
  }
  if (isMoving()) {
    续斩()
    能力技()
    return
  }
  短单体(isA, isB, isBR, isWR)
}

群体攻击() {
  if (isChanting()) {
    return
  }
  isA := hasStatus("连续咏唱")
  isB := hasStatus("即刻咏唱")
  if (isA or isB) {
    散碎()
    能力技()
    return
  }
  if (isMoving()) {
    续斩()
    能力技()
    return
  }
  if (white >= black) {
    赤震雷()
  }
  else {
    赤烈风()
  }
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
  if (回刺()) {
    能力技()
    return
  }
  if (交击斩()) {
    能力技()
    return
  }
  if (连攻()) {
    能力技()
    return
  }
  if (赤神圣()) {
    能力技()
    return
  }
  if (焦热()) {
    能力技()
    return
  }
}

魔划圆斩() {
  isA := hasStatus("连续咏唱")
  isB := hasStatus("即刻咏唱")
  if (isA or isB) {
    群体攻击()
    return
  }
  if (划圆斩()) {
    能力技()
    return
  }
  群体攻击()
}

短单体(isA, isB, isBR, isWR) {
  if (isA or isB) {
    return
  }
  if (调整魔元()) {
    能力技()
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

调整魔元() {
  if !(level >= 60) {
    return false
  }
  if !(A_TickCount - ts.倍增 > cd.倍增 - 2000) {
    return false
  }
  if !(black >= 60 and white >= 60) {
    return false
  }
  distance := getDistance()
  if !(distance == "near") {
    return false
  }
  划圆斩()
  return true
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

单体治疗() {
  if (isChanting()) {
    return
  }
  isA := hasStatus("连续咏唱")
  isB := hasStatus("即刻咏唱")
  isBR := hasStatus("赤火炎预备")
  isWR := hasStatus("赤飞石预备")
  if (isA or isB) {
    if !(索敌()) {
      赤治疗()
      return
    }
  }
  if (长单体(isA, isB, isBR, isWR)) {
    能力技()
    return
  }
  if (isMoving()) {
    续斩()
    能力技()
    return
  }
  赤治疗()
}

复活() {
  if (isChanting()) {
    return
  }
  isA := hasStatus("连续咏唱")
  isB := hasStatus("即刻咏唱")
  isBR := hasStatus("赤火炎预备")
  isWR := hasStatus("赤飞石预备")
  if !(isA or isB) {
    if !(索敌()) {
      赤治疗()
      return
    }
  }
  if (短单体(isA, isB, isBR, isWR)) {
    return
  }
  if (isMoving()) {
    续斩()
    能力技()
    return
  }
  赤复活()
  能力技()
}

__$default__() {
  cd.技能施放判断间隔 := 100
  cd.技能施放补正 := 1500
  cd.魔三连 := 15000
  ts.回刺 := 0
  cd.回刺 := 10000
  ts.短兵相接 := 0
  cd.短兵相接 := 40000
  ts.赤疾风 := 0
  ts.交击斩 := 0
  cd.交击斩 := 10000
  ts.飞刺 := 0
  cd.飞刺 := 25000
  ts.连攻 := 0
  cd.连攻 := 10000
  ts.促进 := 0
  cd.促进 := 55000
  ts.六分反击 := 0
  cd.六分反击 := 35000
  ts.鼓励 := 0
  cd.鼓励 := 120000
  ts.倍增 := 0
  cd.倍增 := 110000
  ts.交剑 := 0
  cd.交剑 := 35000
  ts.即刻咏唱 := 0
  cd.即刻咏唱 := 60000
  ts.醒梦 := 0
  cd.醒梦 := 60000
  ts.赤神圣 := 0
  cd.赤神圣 := 10000
  ts.焦热 := 0
  cd.焦热 := 10000
  ts.能力技 := 0
  cd.能力技 := 1000
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
  SetTimer 绑定特殊攻击, Off
  SetTimer 绑定特殊攻击, % 300
  特殊攻击()
return

2joy3::
  if !(getGroup()) {
    return
  }
  SetTimer 绑定治疗, Off
  SetTimer 绑定治疗, % 300
  治疗()
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