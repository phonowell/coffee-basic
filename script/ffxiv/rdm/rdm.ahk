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

global $cd := {}
global $ts := {}
global $isChanting := false
global $hp := 0
global $isMoving := false
global $mp := 0
global $isTargeting := false
global $step := 0
global $level := 80
global $skill := {}
global $watcher := {}
global $black := 0
global $distance := "far"
global $white := 0
global $isReporting := true
global $ap := 0
global $isIM := false
global $isBR := false
global $isWR := false

; function

toggleView() {
  GetKeyState __value__, 2joy5
  isPressing := __value__ == "D"
  if !(isPressing) {
    SetTimer toggleView, Off
    Send {ctrl up}{up up}
    return
  }
  GetKeyState state, 2joyr
  if (state < 20) {
    Send {ctrl down}{up down}
  }
}

attack() {
  trigger := getCurrentTrigger()
  if !(trigger) {
    return
  }
  use("获取状态")
  use("报告")
  if !(use("索敌")) {
    return
  }
  if (trigger == "right") {
    attackS()
    return
  }
  if (trigger == "both") {
    attackM()
    return
  }
}

bindAttack() {
  GetKeyState __value__, 2joy4
  isPressing := __value__ == "D"
  if !(isPressing) {
    SetTimer bindAttack, Off
    return
  }
  attack()
}

attackX() {
  trigger := getCurrentTrigger()
  if !(trigger) {
    return
  }
  use("获取状态")
  use("报告")
  if !(use("索敌")) {
    return
  }
  if (trigger == "right") {
    if !(use("魔三连")) {
      attackS()
      return
    }
    use("能力技")
    return
  }
  if (trigger == "both") {
    if !(use("魔划圆斩")) {
      attackM()
      return
    }
    use("能力技")
    return
  }
}

bindAttackX() {
  GetKeyState __value__, 2joy2
  isPressing := __value__ == "D"
  if !(isPressing) {
    SetTimer bindAttackX, Off
    return
  }
  attackX()
}

heal() {
  trigger := getCurrentTrigger()
  if !(trigger) {
    return
  }
  use("获取状态")
  use("报告")
  if (trigger == "right") {
    healS()
    return
  }
  if (trigger == "both") {
    revive()
    return
  }
}

bindHeal() {
  GetKeyState __value__, 2joy3
  isPressing := __value__ == "D"
  if !(isPressing) {
    SetTimer bindHeal, Off
    return
  }
  heal()
}

calcCd(name) {
  result := $cd[name] - (A_TickCount - $ts[name])
  if !(result > 0) {
    return 0
  }
  result := Round(result / 1000)
  return result
}

checkChanting() {
  if ($isMoving) {
    $isChanting := false
    return
  }
  PixelGetColor color, 1130, 865, RGB
  $isChanting := color == 0x2B1B13
}

checkHp() {
  PixelSearch x, y, 21, 36, 168, 36, 0x58483E, 10, Fast RGB
  if !(x) {
    $hp := 100
    return
  }
  percent := (x - 21) * 100 / (168 - 21)
  percent := Round(percent)
  $hp := percent
}

checkMoving() {
  GetKeyState dis, 2joyx
  if (dis < 40 or dis > 60) {
    $isMoving := true
    return
  }
  GetKeyState dis, 2joyy
  if (dis < 40 or dis > 60) {
    $isMoving := true
    return
  }
  $isMoving := false
}

checkMp() {
  PixelSearch x, y, 181, 36, 328, 36, 0x58483E, 10, Fast RGB
  if !(x) {
    $mp := 100
    return
  }
  percent := (x - 181) * 100 / (328 - 181)
  percent := Round(percent)
  $mp := percent
}

checkTargeting() {
  PixelGetColor color, 650, 65, RGB
  if (color == 0xFF8888) {
    $isTargeting := true
    return
  }
  if (color == 0xFFC888) {
    $isTargeting := true
    return
  }
  if (color == 0xEBD788) {
    $isTargeting := true
    return
  }
  if (color == 0xFFB1FF) {
    $isTargeting := true
    return
  }
  $isTargeting := false
}

clearTip() {
  ToolTip
}

clearWatcher(name, type := "hasUsed") {
  if (type == "hasUsed") {
    if !(hasUsed(name)) {
      return
    }
  }
  else if (type == "status") {
    if !(hasStatus(name)) {
      return
    }
  }
  if !($watcher[name]) {
    MsgBox % "invalid watcher: " . name . ""
    return
  }
  __timer__ := $watcher[name]
  SetTimer %__timer__%, Off
  $ts[name] := A_TickCount - $cd.技能施放补正
  return true
}

getCurrentTrigger() {
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
  return
}

hasStatus(name) {
  ImageSearch x, y, 725, 840, 925, 875, % A_ScriptDir . "\" . "image\" . name . ".png"
  if (x > 0 and y > 0) {
    return true
  }
  return false
}

hasStatusByTarget(name) {
  ImageSearch x, y, 725, 765, 925, 800, % A_ScriptDir . "\" . "image\" . name . ".png"
  if (x > 0 and y > 0) {
    return true
  }
  return false
}

hasUsed(name) {
  ImageSearch x, y, 60, 915, 225, 975, % A_ScriptDir . "\" . "image\" . name . ".png"
  if (x > 0 and y > 0) {
    return true
  }
  return false
}

makeReportMsg(msg, list) {
  for __i__, name in list {
    result := calcCd(name)
    if !(result > 1) {
      continue
    }
    msg := "" . msg . "`n" . name . "：" . result . "s"
  }
  return msg
}

resetKey() {
  Send {alt up}
  Send {ctrl up}
  Send {shift up}
  MouseMove 410, 640, 0
}

resetStep() {
  $step := 0
}

resetTs() {
  for key, value in $ts {
    $ts[key] := 0
  }
}

setLevel() {
  InputBox $level, , % "input level", , , , , , , , % $level
  if !($level > 0) {
    $level := 80
  }
  if ($level < 10) {
    $level := $level * 10
  }
  resetTs()
}

use(name, option := false) {
  if !($skill[name]) {
    MsgBox % "invalid skill: " . name . ""
    return
  }
  return $skill[name].Call(option)
}

watch(name) {
  if !($watcher[name]) {
    MsgBox % "invalid watcher: " . name . ""
    return
  }
  return $watcher[name]()
}

checkBlack() {
  PixelSearch x, y, 1023, 811, 1170, 811, 0x58483E, 10, Fast RGB
  if !(x) {
    $black := 100
    return
  }
  percent := (x - 1023) * 100 / (1170 - 1023)
  percent := Floor(percent)
  $black := percent
}

checkDistance() {
  if !($isTargeting) {
    $distance := "far"
    return
  }
  PixelGetColor color, 1875, 723, RGB
  if (color == 0x1A1D1E) {
    $distance := "near"
    return
  }
  if (color == 0x101312) {
    $distance := "near"
    return
  }
  if (color == 0x101211) {
    $distance := "near"
    return
  }
  $distance := "far"
}

checkWhite() {
  PixelSearch x, y, 1023, 798, 1170, 798, 0x58483E, 10, Fast RGB
  if !(x) {
    $white := 100
    return
  }
  percent := (x - 1023) * 100 / (1170 - 1023)
  percent := Floor(percent)
  $white := percent
}

__$skill_dot_中断咏唱__() {
  if !($isChanting) {
    return
  }
  Send {space}
}

__$skill_dot_冲刺__() {
  Send {shift down}{-}{shift up}
}

__$skill_dot_空白信息__() {
  Send {shift down}{=}{shift up}
}

__$skill_dot_索敌__() {
  checkTargeting()
  if ($isTargeting) {
    return true
  }
  Send {f11}
  checkTargeting()
  return $isTargeting
}

__$skill_dot_交击斩__() {
  if !($level >= 35) {
    return
  }
  if !($step == 1) {
    return
  }
  if !($black >= 50 and $white >= 50) {
    return
  }
  Send {alt down}{-}{alt up}
  SetTimer __$watcher_dot_交击斩__, % $cd.技能施放判断间隔
  return true
}

__$watcher_dot_交击斩__() {
  if !(hasUsed("魔交击斩")) {
    return
  }
  SetTimer __$watcher_dot_交击斩__, Off
  $ts.交击斩 := A_TickCount - $cd.技能施放补正
  SetTimer resetStep, Off
  if ($level >= 50) {
    $step := 2
    SetTimer resetStep, % 0 - $cd.魔三连
  }
  else {
    $step := 0
  }
}

__$skill_dot_交剑__() {
  if !($level >= 72) {
    return
  }
  if !(A_TickCount - $ts.交剑 > $cd.交剑) {
    return
  }
  if !($distance == "near") {
    return
  }
  Send {ctrl down}{0}{ctrl up}
  $ts.交剑 := A_TickCount - $cd.交剑 + $cd.技能施放补正
  SetTimer __$watcher_dot_交剑__, % $cd.技能施放判断间隔
  return true
}

__$watcher_dot_交剑__() {
  clearWatcher("交剑")
}

__$skill_dot_促进__() {
  if !($level >= 50) {
    return
  }
  if !(A_TickCount - $ts.促进 > $cd.促进) {
    return
  }
  if !(A_TickCount - $ts.赤疾风 < 2000) {
    return
  }
  if ($black > 70 or $white > 70) {
    return
  }
  if ($isBR or $isWR) {
    return
  }
  Send {ctrl down}{3}{ctrl up}
  $ts.促进 := A_TickCount - $cd.促进 + $cd.技能施放补正
  SetTimer __$watcher_dot_促进__, % $cd.技能施放判断间隔
  return true
}

__$watcher_dot_促进__() {
  clearWatcher("促进")
}

__$skill_dot_倍增__() {
  if !($level >= 60) {
    return
  }
  if !(A_TickCount - $ts.倍增 > $cd.倍增) {
    return
  }
  if !($black >= 40 and $black <= 70) {
    return
  }
  if !($white >= 40 and $white <= 70) {
    return
  }
  Send {ctrl down}{8}{ctrl up}
  $ts.倍增 := A_TickCount - $cd.倍增 + $cd.技能施放补正
  SetTimer __$watcher_dot_倍增__, % $cd.技能施放判断间隔
  return true
}

__$watcher_dot_倍增__() {
  clearWatcher("倍增")
  $ts.短兵相接 := 0
  $ts.移转 := 0
  $ts.交剑 := 0
}

__$skill_dot_六分反击__() {
  if !($level >= 56) {
    return
  }
  if !(A_TickCount - $ts.六分反击 > $cd.六分反击) {
    return
  }
  Send {ctrl down}{6}{ctrl up}
  $ts.六分反击 := A_TickCount - $cd.六分反击 + $cd.技能施放补正
  SetTimer __$watcher_dot_六分反击__, % $cd.技能施放判断间隔
  return true
}

__$watcher_dot_六分反击__() {
  clearWatcher("六分反击")
}

__$skill_dot_划圆斩__() {
  if !($level >= 52) {
    return
  }
  if !($black >= 20 and $white >= 20) {
    return
  }
  checkDistance()
  if !($distance == "near") {
    use("短兵相接", true)
    return
  }
  Send {ctrl down}{4}{ctrl up}
  return true
}

__$skill_dot_即刻咏唱__() {
  if !(A_TickCount - $ts.即刻咏唱 > $cd.即刻咏唱) {
    return
  }
  if ($black > 70 or $white > 70) {
    return
  }
  if (hasStatus("连续咏唱")) {
    return
  }
  if ($isBR and $isWR) {
    return
  }
  Send {shift down}{2}{shift up}
  $ts.即刻咏唱 := A_TickCount - $cd.即刻咏唱 + $cd.技能施放补正
  SetTimer __$watcher_dot_即刻咏唱__, % $cd.技能施放判断间隔
  return true
}

__$watcher_dot_即刻咏唱__() {
  clearWatcher("即刻咏唱", "status")
}

__$skill_dot_回刺__() {
  if !($step == 0) {
    return
  }
  if !($black >= 80 and $white >= 80) {
    return
  }
  use("中断咏唱")
  if !($distance == "near") {
    use("短兵相接", true)
    return
  }
  Send {alt down}{1}{alt up}
  SetTimer __$watcher_dot_回刺__, % $cd.技能施放判断间隔
  return true
}

__$watcher_dot_回刺__() {
  if !(hasUsed("魔回刺")) {
    return
  }
  SetTimer __$watcher_dot_回刺__, Off
  $ts.回刺 := A_TickCount - $cd.技能施放补正
  SetTimer resetStep, Off
  if ($level >= 35) {
    $step := 1
    SetTimer resetStep, % 0 - $cd.魔三连
  }
}

__$skill_dot_报告__() {
  if !($isReporting) {
    return
  }
  msg := "等级：" . $level . " / 魔力：" . $mp . "%"
  msg := "" . msg . "`n黑：" . $black . " / 白：" . $white . ""
  msg := "" . msg . "`n赤火炎：" . $isBR . " / 赤飞石：" . $isWR . " / 连续咏唱：" . $isIM . ""
  msg := "" . msg . "`n咏唱：" . $isChanting . " / 移动：" . $isMoving . " / 目标距离：" . $distance . ""
  msg := "" . msg . "`n耗时：" . A_TickCount - $ts.报告 . "ms`n"
  $ts.报告 := A_TickCount
  msg := makeReportMsg(msg, ["短兵相接", "飞刺", "促进", "六分反击", "鼓励", "倍增", "交剑", "即刻咏唱", "醒梦"])
  ToolTip % msg, 410, 640
  SetTimer clearTip, Off
  SetTimer clearTip, % 0 - 10000
}

__$skill_dot_摇荡__() {
  Send {alt down}{2}{alt up}
}

__$skill_dot_散碎__() {
  if !($level >= 15) {
    return
  }
  Send {alt down}{6}{alt up}
  return true
}

__$skill_dot_焦热__() {
  if !($level >= 80) {
    return
  }
  if !($step == 4) {
    return
  }
  use("摇荡")
  SetTimer __$watcher_dot_焦热__, % $cd.技能施放判断间隔
  return true
}

__$watcher_dot_焦热__() {
  if !(clearWatcher("焦热")) {
    return
  }
  SetTimer resetStep, Off
  $step := 0
}

__$skill_dot_短兵相接__(isForced := false) {
  if !(A_TickCount - $ts.短兵相接 > $cd.短兵相接) {
    return
  }
  if !($distance == "near" or isForced) {
    return
  }
  Send {alt down}{4}{alt up}
  $ts.短兵相接 := A_TickCount - $cd.短兵相接 + $cd.技能施放补正
  SetTimer __$watcher_dot_短兵相接__, % $cd.技能施放判断间隔
  return true
}

__$watcher_dot_短兵相接__() {
  clearWatcher("短兵相接")
}

__$skill_dot_移转__() {
  if !($level >= 40) {
    return
  }
  Send {alt down}{=}{alt up}
  return true
}

__$skill_dot_续斩__() {
  if !($level >= 76) {
    return
  }
  if !($black >= 5 and $black < 80) {
    return
  }
  if !($white >= 5 and $white < 80) {
    return
  }
  Send {ctrl down}{-}{ctrl up}
  return true
}

__$skill_dot_能力技__() {
  if !($ap == 0) {
    return
  }
  if !(A_TickCount - $ts.能力技 > $cd.能力技) {
    return
  }
  $ts.能力技 := A_TickCount
  $ap := -2
  SetTimer 施放能力技, % 500
}

施放能力技() {
  if ($ap < 0) {
    $ap := -$ap
    return
  }
  if ($ap == 0) {
    SetTimer 施放能力技, Off
    return
  }
  $ap--
  if ($step == 0) {
    常时能力技()
  }
  else {
    魔三连能力技()
  }
}

常时能力技() {
  if (use("倍增")) {
    return
  }
  if (use("促进")) {
    return
  }
  if (use("即刻咏唱")) {
    return
  }
  if (use("飞刺")) {
    return
  }
  if (use("六分反击")) {
    return
  }
  if (use("短兵相接")) {
    return
  }
  if (use("交剑")) {
    return
  }
  if (use("醒梦")) {
    return
  }
}

魔三连能力技() {
  if (use("鼓励")) {
    return
  }
  if (use("飞刺")) {
    return
  }
  if (use("六分反击")) {
    return
  }
  if (use("短兵相接")) {
    return
  }
  if (use("交剑")) {
    return
  }
}

__$skill_dot_获取状态__() {
  if (A_TickCount - $ts.获取状态 > 10000) {
    use("空白信息")
    use("空白信息")
    use("空白信息")
  }
  $ts.获取状态 := A_TickCount
  checkMoving()
  checkChanting()
  checkDistance()
  checkBlack()
  checkWhite()
  isA := hasStatus("连续咏唱")
  isB := hasStatus("即刻咏唱")
  $isIM := isA or isB
  $isBR := hasStatus("赤火炎预备")
  $isWR := hasStatus("赤飞石预备")
}

__$skill_dot_调整魔元__() {
  if !($level >= 60) {
    return
  }
  if !($step == 0) {
    return
  }
  if !(A_TickCount - $ts.倍增 > $cd.倍增 - 2000) {
    return
  }
  if !($black >= 60 and $white >= 60) {
    return
  }
  if !($distance == "near") {
    return
  }
  use("划圆斩")
  return true
}

__$skill_dot_赤复活__() {
  if !($level >= 64) {
    return
  }
  Send {ctrl down}{9}{ctrl up}
  return true
}

__$skill_dot_赤治疗__() {
  if !($level >= 54) {
    return
  }
  Send {ctrl down}{5}{ctrl up}
  return true
}

__$skill_dot_赤火炎__() {
  if !($level >= 30) {
    return
  }
  Send {alt down}{9}{alt up}
  return true
}

__$skill_dot_赤烈风__() {
  if !($level >= 22) {
    return
  }
  Send {alt down}{8}{alt up}
  return true
}

__$skill_dot_赤疾风__() {
  Send {alt down}{5}{alt up}
  $ts.赤疾风 := A_TickCount - $cd.赤疾风 + $cd.技能施放补正
}

__$skill_dot_赤神圣__() {
  if !($level >= 70) {
    return
  }
  if !($step == 3) {
    return
  }
  赤神圣施放()
  SetTimer __$watcher_dot_赤神圣__, % $cd.技能施放判断间隔
  return true
}

__$watcher_dot_赤神圣__() {
  isA := hasUsed("赤核爆")
  isB := hasUsed("赤神圣")
  if !(isA or isB) {
    return
  }
  SetTimer __$watcher_dot_赤神圣__, Off
  $ts.赤神圣 := A_TickCount - $cd.技能施放补正
  SetTimer resetStep, Off
  if ($level >= 80) {
    $step := 4
    SetTimer resetStep, % 0 - $cd.魔三连
  }
  else {
    $step := 0
  }
}

赤神圣施放() {
  if ($black - $white > 9) {
    use("赤疾风")
    return
  }
  if ($white - $black > 9) {
    use("赤闪雷")
    return
  }
  if ($isBR and $isWR) {
    if ($black > $white) {
      use("赤疾风")
    }
    else {
      use("赤闪雷")
    }
    return
  }
  if ($isBR) {
    use("赤疾风")
    return
  }
  if ($isWR) {
    use("赤闪雷")
    return
  }
  if ($black > $white) {
    use("赤疾风")
  }
  else {
    use("赤闪雷")
  }
}

__$skill_dot_赤闪雷__() {
  Send {alt down}{3}{alt up}
  $ts.赤疾风 := A_TickCount - $cd.赤疾风 + $cd.技能施放补正
}

__$skill_dot_赤震雷__() {
  if !($level >= 22) {
    return
  }
  Send {alt down}{7}{alt up}
  return true
}

__$skill_dot_赤飞石__() {
  if !($level >= 30) {
    return
  }
  Send {alt down}{0}{alt up}
  return true
}

__$skill_dot_连攻__() {
  if !($level >= 50) {
    return
  }
  if !($step == 2) {
    return
  }
  if !($black >= 25 and $white >= 25) {
    return
  }
  Send {ctrl down}{2}{ctrl up}
  SetTimer __$watcher_dot_连攻__, % $cd.技能施放判断间隔
  return true
}

__$watcher_dot_连攻__() {
  if !(hasUsed("魔连攻")) {
    return
  }
  SetTimer __$watcher_dot_连攻__, Off
  $ts.连攻 := A_TickCount - $cd.技能施放补正
  SetTimer resetStep, Off
  if ($level >= 70) {
    $step := 3
    SetTimer resetStep, % 0 - $cd.魔三连
  }
  else {
    $step := 0
  }
}

__$skill_dot_醒梦__() {
  if !(A_TickCount - $ts.醒梦 > $cd.醒梦) {
    return
  }
  checkMp()
  if ($mp > 50) {
    return
  }
  Send {shift down}{3}{shift up}
  $ts.醒梦 := A_TickCount - $cd.醒梦 + $cd.技能施放补正
  SetTimer __$watcher_dot_醒梦__, % $cd.技能施放判断间隔
  return true
}

__$watcher_dot_醒梦__() {
  clearWatcher("醒梦", "status")
}

__$skill_dot_飞刺__() {
  if !($level >= 45) {
    return
  }
  if !(A_TickCount - $ts.飞刺 > $cd.飞刺) {
    return
  }
  Send {ctrl down}{1}{ctrl up}
  $ts.飞刺 := A_TickCount - $cd.飞刺 + $cd.技能施放补正
  SetTimer __$watcher_dot_飞刺__, % $cd.技能施放判断间隔
  return true
}

__$watcher_dot_飞刺__() {
  clearWatcher("飞刺")
}

__$skill_dot_魔三连__() {
  if ($isIM) {
    return
  }
  if (use("回刺")) {
    return true
  }
  if (use("交击斩")) {
    return true
  }
  if (use("连攻")) {
    return true
  }
  if (use("赤神圣")) {
    return true
  }
  if (use("焦热")) {
    return true
  }
}

__$skill_dot_魔划圆斩__() {
  if ($isIM) {
    return
  }
  if !(use("划圆斩")) {
    return
  }
  use("能力技")
  return true
}

__$skill_dot_鼓励__() {
  if !($level >= 58) {
    return
  }
  if !(A_TickCount - $ts.鼓励 > $cd.鼓励) {
    return
  }
  Send {ctrl down}{7}{ctrl up}
  $ts.鼓励 := A_TickCount - $cd.鼓励 + $cd.技能施放补正
  SetTimer __$watcher_dot_鼓励__, % $cd.技能施放判断间隔
  return true
}

__$watcher_dot_鼓励__() {
  clearWatcher("鼓励")
}

attackS() {
  if ($isChanting) {
    return
  }
  if (attackSL()) {
    use("能力技")
    return
  }
  if ($isMoving) {
    use("续斩")
    use("能力技")
    return
  }
  attackSS()
}

attackM() {
  if ($isChanting) {
    return
  }
  if ($isIM) {
    use("散碎")
    use("能力技")
    return
  }
  if ($isMoving) {
    use("续斩")
    use("能力技")
    return
  }
  if ($isWR) {
    use("赤飞石")
    use("能力技")
    return
  }
  if ($isBR) {
    use("赤火炎")
    use("能力技")
    return
  }
  if ($white >= $black) {
    use("赤震雷")
  }
  else {
    use("赤烈风")
  }
}

attackSS() {
  if ($isIM) {
    return
  }
  if (use("调整魔元")) {
    use("能力技")
    return
  }
  if ($black - $white > 21) {
    if ($isWR) {
      use("赤飞石")
    }
    else {
      use("摇荡")
    }
    return
  }
  if ($white - $black > 21) {
    if ($isBR) {
      use("赤火炎")
    }
    else {
      use("摇荡")
    }
    return
  }
  attackSS2()
}

attackSS2() {
  if ($isWR and $isBR) {
    if ($black > $white) {
      use("赤飞石")
    }
    else {
      use("赤火炎")
    }
    return
  }
  if ($isWR) {
    use("赤飞石")
    return
  }
  if ($isBR) {
    use("赤火炎")
    return
  }
  use("摇荡")
}

attackSL() {
  if !($isIM) {
    return
  }
  if ($black - $white > 19) {
    use("赤疾风")
    return true
  }
  if ($white - $black > 19) {
    use("赤闪雷")
    return true
  }
  if ($isWR) {
    use("赤闪雷")
    return true
  }
  if ($isBR) {
    use("赤疾风")
    return true
  }
  if ($white >= $black) {
    use("赤闪雷")
  }
  else {
    use("赤疾风")
  }
  return true
}

healS() {
  if ($isChanting) {
    return
  }
  if ($isIM) {
    if !(use("索敌")) {
      use("赤治疗")
      return
    }
  }
  if (attackSL()) {
    use("能力技")
    return
  }
  if ($isMoving) {
    use("续斩")
    use("能力技")
    return
  }
  use("赤治疗")
}

revive() {
  if ($isChanting) {
    return
  }
  if !($isIM) {
    if !(use("索敌")) {
      use("赤治疗")
      return
    }
  }
  if (attackSS()) {
    return
  }
  if ($isMoving) {
    use("续斩")
    use("能力技")
    return
  }
  use("赤复活")
  use("能力技")
}

__$default__() {
  $cd.技能施放判断间隔 := 100
  $cd.技能施放补正 := 1500
  $skill.中断咏唱 := Func("__$skill_dot_中断咏唱__")
  $skill.冲刺 := Func("__$skill_dot_冲刺__")
  $skill.空白信息 := Func("__$skill_dot_空白信息__")
  $skill.索敌 := Func("__$skill_dot_索敌__")
  $ts.交击斩 := 0
  $skill.交击斩 := Func("__$skill_dot_交击斩__")
  $watcher.交击斩 := Func("__$watcher_dot_交击斩__")
  $ts.交剑 := 0
  $cd.交剑 := 35000
  $skill.交剑 := Func("__$skill_dot_交剑__")
  $watcher.交剑 := Func("__$watcher_dot_交剑__")
  $ts.促进 := 0
  $cd.促进 := 55000
  $skill.促进 := Func("__$skill_dot_促进__")
  $watcher.促进 := Func("__$watcher_dot_促进__")
  $ts.倍增 := 0
  $cd.倍增 := 110000
  $skill.倍增 := Func("__$skill_dot_倍增__")
  $watcher.倍增 := Func("__$watcher_dot_倍增__")
  $ts.六分反击 := 0
  $cd.六分反击 := 35000
  $skill.六分反击 := Func("__$skill_dot_六分反击__")
  $watcher.六分反击 := Func("__$watcher_dot_六分反击__")
  $skill.划圆斩 := Func("__$skill_dot_划圆斩__")
  $ts.即刻咏唱 := 0
  $cd.即刻咏唱 := 60000
  $skill.即刻咏唱 := Func("__$skill_dot_即刻咏唱__")
  $watcher.即刻咏唱 := Func("__$watcher_dot_即刻咏唱__")
  $ts.回刺 := 0
  $skill.回刺 := Func("__$skill_dot_回刺__")
  $watcher.回刺 := Func("__$watcher_dot_回刺__")
  $ts.报告 := 0
  $skill.报告 := Func("__$skill_dot_报告__")
  $skill.摇荡 := Func("__$skill_dot_摇荡__")
  $skill.散碎 := Func("__$skill_dot_散碎__")
  $ts.焦热 := 0
  $skill.焦热 := Func("__$skill_dot_焦热__")
  $watcher.焦热 := Func("__$watcher_dot_焦热__")
  $ts.短兵相接 := 0
  $cd.短兵相接 := 40000
  $skill.短兵相接 := Func("__$skill_dot_短兵相接__")
  $watcher.短兵相接 := Func("__$watcher_dot_短兵相接__")
  $skill.移转 := Func("__$skill_dot_移转__")
  $skill.续斩 := Func("__$skill_dot_续斩__")
  $ts.能力技 := 0
  $cd.能力技 := 1000
  $skill.能力技 := Func("__$skill_dot_能力技__")
  $ts.获取状态 := 0
  $skill.获取状态 := Func("__$skill_dot_获取状态__")
  $skill.调整魔元 := Func("__$skill_dot_调整魔元__")
  $skill.赤复活 := Func("__$skill_dot_赤复活__")
  $skill.赤治疗 := Func("__$skill_dot_赤治疗__")
  $skill.赤火炎 := Func("__$skill_dot_赤火炎__")
  $skill.赤烈风 := Func("__$skill_dot_赤烈风__")
  $ts.赤疾风 := 0
  $cd.赤疾风 := 2500
  $skill.赤疾风 := Func("__$skill_dot_赤疾风__")
  $ts.赤神圣 := 0
  $skill.赤神圣 := Func("__$skill_dot_赤神圣__")
  $watcher.赤神圣 := Func("__$watcher_dot_赤神圣__")
  $skill.赤闪雷 := Func("__$skill_dot_赤闪雷__")
  $skill.赤震雷 := Func("__$skill_dot_赤震雷__")
  $skill.赤飞石 := Func("__$skill_dot_赤飞石__")
  $ts.连攻 := 0
  $skill.连攻 := Func("__$skill_dot_连攻__")
  $watcher.连攻 := Func("__$watcher_dot_连攻__")
  $ts.醒梦 := 0
  $cd.醒梦 := 60000
  $skill.醒梦 := Func("__$skill_dot_醒梦__")
  $watcher.醒梦 := Func("__$watcher_dot_醒梦__")
  $ts.飞刺 := 0
  $cd.飞刺 := 25000
  $skill.飞刺 := Func("__$skill_dot_飞刺__")
  $watcher.飞刺 := Func("__$watcher_dot_飞刺__")
  $cd.魔三连 := 15000
  $skill.魔三连 := Func("__$skill_dot_魔三连__")
  $skill.魔划圆斩 := Func("__$skill_dot_魔划圆斩__")
  $ts.鼓励 := 0
  $cd.鼓励 := 120000
  $skill.鼓励 := Func("__$skill_dot_鼓励__")
  $watcher.鼓励 := Func("__$watcher_dot_鼓励__")
}

; default
__$default__()

; event

f5::
  resetKey()
  resetTs()
  SoundBeep
  setLevel()
return

^f5::
  resetKey()
  SoundBeep
  Reload
return

!f4::
  resetKey()
  SoundBeep
  ExitApp
return

2joy5::
  if !(getCurrentTrigger() == "both") {
    SetTimer toggleView, Off
    SetTimer toggleView, % 300
    return
  }
  Send {shift down}{tab}{shift up}
return

2joy6::
  if !(getCurrentTrigger() == "both") {
    return
  }
  Send {tab}
return

2joy12::
  if !(getCurrentTrigger()) {
    return
  }
  use("冲刺")
return

2joy4::
  if !(getCurrentTrigger()) {
    return
  }
  SetTimer bindAttack, Off
  SetTimer bindAttack, % 300
  attack()
return

2joy2::
  if !(getCurrentTrigger()) {
    return
  }
  SetTimer bindAttackX, Off
  SetTimer bindAttackX, % 300
  attackX()
return

2joy3::
  if !(getCurrentTrigger()) {
    return
  }
  SetTimer bindHeal, Off
  SetTimer bindHeal, % 300
  heal()
return

; eof