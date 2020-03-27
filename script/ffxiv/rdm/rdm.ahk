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
global mp := 0
global hasTarget := false
global $level := 80
global $skill := {}
global $watcher := {}
global $black := 0
global distance := "far"
global $white := 0
global isReporting := false
global tsReport := 0
global 能力技余额 := 0

; function

calcCD(name) {
  result := $cd[name] - (A_TickCount - $ts[name])
  if !(result > 0) {
    return 0
  }
  result := Round(result / 1000)
  return result
}

clearTip() {
  ToolTip
}

clearWatcher(name, type := "used") {
  if (type == "used") {
    if !(isUsed(name)) {
      return
    }
  }
  else if (type == "status") {
    if !(hasStatus(name)) {
      return
    }
  }
  SetTimer %$watcher[name]%, Off
  $ts[name] := A_TickCount - $cd.技能施放补正
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

makeReportMsg(msg, name) {
  result := calcCD(name)
  if !(result) {
    return msg
  }
  return "" . msg . "`n" . name . "：" . result . "s"
}

resetKey() {
  Send {alt up}
  Send {ctrl up}
  Send {shift up}
}

resetTs() {
  for key, value in ts {
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
}

use(name, option) {
  return $skill[name](option)
}

watch(name) {
  return $watcher[name]()
}

attack() {
  group := getGroup()
  if !(group) {
    return
  }
  use("获取状态")
  report()
  if !(use("索敌")) {
    return
  }
  if (group == "right") {
    attackS()
    return
  }
  if (group == "both") {
    attackM()
    return
  }
}

bindAttack() {
  if !($.isPressing("2-joy-4")) {
    SetTimer bindAttack, Off
    SetTimer %清空信息%, % 0 - 10000
    return
  }
  SetTimer %清空信息%, Off
  attack()
}

attackX() {
  group := getGroup()
  if !(group) {
    return
  }
  use("获取状态")
  report()
  if !(use("索敌")) {
    return
  }
  if (group == "right") {
    if !(use("魔三连")) {
      attackS()
      return
    }
    use("能力技")
    return
  }
  if (group == "both") {
    if !(use("魔划圆斩")) {
      attackM()
      return
    }
    use("能力技")
    return
  }
}

bindAttackX() {
  if !($.isPressing("2-joy-2")) {
    SetTimer %bindAttackSpecial%, Off
    SetTimer %清空信息%, % 0 - 10000
    return
  }
  SetTimer %清空信息%, Off
  attackX()
}

heal() {
  group := getGroup()
  if !(group) {
    return
  }
  use("获取状态")
  report()
  if (group == "right") {
    healS()
    return
  }
  if (group == "both") {
    revive()
    return
  }
}

bindHeal() {
  if !($.isPressing("2-joy-3")) {
    SetTimer bindHeal, Off
    SetTimer %清空信息%, % 0 - 10000
    return
  }
  SetTimer %清空信息%, Off
  heal()
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

report() {
  if !(isReporting) {
    return
  }
  msg := "等级：" . $level . " / 魔力：" . mp . "%"
  msg := "" . msg . "`n黑：" . $black . " / 白：" . $white . ""
  msg := "" . msg . "`n目标距离：" . distance . ""
  msg := "" . msg . "`n耗时：" . A_TickCount - tsReport . "ms`n"
  tsReport := A_TickCount
  msg := makeReportMsg(msg, "短兵相接")
  msg := makeReportMsg(msg, "飞刺")
  msg := makeReportMsg(msg, "促进")
  msg := makeReportMsg(msg, "六分反击")
  msg := makeReportMsg(msg, "鼓励")
  msg := makeReportMsg(msg, "倍增")
  msg := makeReportMsg(msg, "交剑")
  msg := makeReportMsg(msg, "即刻咏唱")
  msg := makeReportMsg(msg, "醒梦")
  ToolTip % msg, 410, 640
  SetTimer clearTip, Off
  SetTimer clearTip, % 0 - 5000
}

__$skill_dot_回刺__() {
  if !(A_TickCount - $ts.回刺 > $cd.回刺) {
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
  SetTimer %$watcher.回刺%, % $cd.技能施放判断间隔
  return true
}

__$watcher_dot_回刺__() {
  clearWatcher("魔回刺")
}

__$skill_dot_摇荡__() {
  Send {alt down}{2}{alt up}
}

__$skill_dot_赤闪雷__() {
  Send {alt down}{3}{alt up}
  $ts.赤疾风 := A_TickCount
}

__$skill_dot_短兵相接__(isForced := false) {
  if !(A_TickCount - $ts.短兵相接 > $cd.短兵相接) {
    return false
  }
  distance := getDistance()
  if !(distance == "near" or isForced) {
    return false
  }
  Send {alt down}{4}{alt up}
  $ts.短兵相接 := A_TickCount - $cd.短兵相接 + $cd.技能施放补正
  SetTimer %$watcher.短兵相接%, % $cd.技能施放判断间隔
  return true
}

__$watcher_dot_短兵相接__() {
  clearWatcher("短兵相接")
}

__$skill_dot_赤疾风__() {
  Send {alt down}{5}{alt up}
  $ts.赤疾风 := A_TickCount
}

__$skill_dot_散碎__() {
  Send {alt down}{6}{alt up}
}

__$skill_dot_赤震雷__() {
  Send {alt down}{7}{alt up}
}

__$skill_dot_赤烈风__() {
  Send {alt down}{8}{alt up}
}

__$skill_dot_赤火炎__() {
  Send {alt down}{9}{alt up}
}

__$skill_dot_赤飞石__() {
  Send {alt down}{0}{alt up}
}

__$skill_dot_交击斩__() {
  if !($level >= 35) {
    return false
  }
  if !(A_TickCount - $ts.交击斩 > $cd.交击斩) {
    return false
  }
  if !(A_TickCount - $ts.回刺 < $cd.comboZ) {
    return false
  }
  if !($black >= 50 and $white >= 50) {
    return false
  }
  Send {alt down}{-}{alt up}
  SetTimer %$watcher.交击斩%, % $cd.技能施放判断间隔
  return true
}

__$watcher_dot_交击斩__() {
  if !(isUsed("魔交击斩")) {
    return
  }
  SetTimer %$watcher.交击斩%, Off
  $ts.交击斩 := A_TickCount - $cd.技能施放补正
}

__$skill_dot_移转__() {
  if !($level >= 40) {
    return false
  }
  Send {alt down}{=}{alt up}
  return true
}

__$skill_dot_飞刺__() {
  if !($level >= 45) {
    return false
  }
  if !(A_TickCount - $ts.飞刺 > $cd.飞刺) {
    return false
  }
  Send {ctrl down}{1}{ctrl up}
  $ts.飞刺 := A_TickCount - $cd.飞刺 + $cd.技能施放补正
  SetTimer %$watcher.飞刺%, % $cd.技能施放判断间隔
  return true
}

__$watcher_dot_飞刺__() {
  clearWatcher("飞刺")
}

__$skill_dot_连攻__() {
  if !($level >= 50) {
    return false
  }
  if !(A_TickCount - $ts.连攻 > $cd.连攻) {
    return false
  }
  if !(A_TickCount - $ts.交击斩 < $cd.comboZ) {
    return false
  }
  if !($black >= 25 and $white >= 25) {
    return false
  }
  Send {ctrl down}{2}{ctrl up}
  SetTimer %$watcher.连攻%, % $cd.技能施放判断间隔
  return true
}

__$watcher_dot_连攻__() {
  if !(isUsed("魔连攻")) {
    return
  }
  SetTimer %$watcher.连攻%, Off
  $ts.连攻 := A_TickCount - $cd.技能施放补正
}

__$skill_dot_促进__() {
  if !($level >= 50) {
    return false
  }
  if !(A_TickCount - $ts.促进 > $cd.促进) {
    return false
  }
  if !(A_TickCount - $ts.赤疾风 < 2000) {
    return false
  }
  if !(A_TickCount - $ts.回刺 > $cd.comboZ) {
    return false
  }
  if ($black > 70 or $white > 70) {
    return false
  }
  if ($isBR or $isWR) {
    return false
  }
  Send {ctrl down}{3}{ctrl up}
  $ts.促进 := A_TickCount - $cd.促进 + $cd.技能施放补正
  SetTimer %$watcher.促进%, % $cd.技能施放判断间隔
  return true
}

__$watcher_dot_促进__() {
  clearWatcher("促进")
}

__$skill_dot_划圆斩__() {
  if !($level >= 52) {
    return false
  }
  if !($black >= 20 and $white >= 20) {
    return false
  }
  distance := getDistance()
  if !(distance == "near") {
    use("短兵相接", true)
    return false
  }
  Send {ctrl down}{4}{ctrl up}
  return true
}

__$skill_dot_赤治疗__() {
  if !($level >= 54) {
    return false
  }
  Send {ctrl down}{5}{ctrl up}
  return true
}

__$skill_dot_六分反击__() {
  if !($level >= 56) {
    return false
  }
  if !(A_TickCount - $ts.六分反击 > $cd.六分反击) {
    return false
  }
  Send {ctrl down}{6}{ctrl up}
  $ts.六分反击 := A_TickCount - $cd.六分反击 + $cd.技能施放补正
  SetTimer %$watcher.六分反击%, % $cd.技能施放判断间隔
  return true
}

__$watcher_dot_六分反击__() {
  clearWatcher("六分反击")
}

__$skill_dot_鼓励__() {
  if !($level >= 58) {
    return false
  }
  if !(A_TickCount - $ts.鼓励 > $cd.鼓励) {
    return false
  }
  if !(A_TickCount - $ts.回刺 < $cd.回刺) {
    return false
  }
  Send {ctrl down}{7}{ctrl up}
  $ts.鼓励 := A_TickCount - $cd.鼓励 + $cd.技能施放补正
  SetTimer %$watcher.鼓励%, % $cd.技能施放判断间隔
  return true
}

__$watcher_dot_鼓励__() {
  clearWatcher("鼓励")
}

__$skill_dot_倍增__() {
  if !($level >= 60) {
    return false
  }
  if !(A_TickCount - $ts.倍增 > $cd.倍增) {
    return false
  }
  if (A_TickCount - $ts.回刺 < $cd.comboZ) {
    return false
  }
  if !($black >= 40 and $black <= 70) {
    return false
  }
  if !($white >= 40 and $white <= 70) {
    return false
  }
  Send {ctrl down}{8}{ctrl up}
  $ts.倍增 := A_TickCount - $cd.倍增 + $cd.技能施放补正
  SetTimer %$watcher.倍增%, % $cd.技能施放判断间隔
  return true
}

__$watcher_dot_倍增__() {
  clearWatcher("倍增")
  $ts.短兵相接 := 0
  $ts.移转 := 0
  $ts.交剑 := 0
}

__$skill_dot_赤复活__() {
  if !($level >= 64) {
    return false
  }
  Send {ctrl down}{9}{ctrl up}
  return true
}

__$skill_dot_交剑__() {
  if !($level >= 72) {
    return false
  }
  if !(A_TickCount - $ts.交剑 > $cd.交剑) {
    return false
  }
  distance := getDistance()
  if !(distance == "near") {
    return false
  }
  Send {ctrl down}{0}{ctrl up}
  $ts.交剑 := A_TickCount - $cd.交剑 + $cd.技能施放补正
  SetTimer %$watcher.交剑%, % $cd.技能施放判断间隔
  return true
}

__$watcher_dot_交剑__() {
  clearWatcher("交剑")
}

__$skill_dot_续斩__() {
  if !($level >= 76) {
    return false
  }
  Send {ctrl down}{-}{ctrl up}
  return true
}

__$skill_dot_昏乱__() {
  Send {shift down}{1}{shift up}
}

__$skill_dot_即刻咏唱__() {
  if !($level >= 18) {
    return false
  }
  if !(A_TickCount - $ts.即刻咏唱 > $cd.即刻咏唱) {
    return false
  }
  if !(A_TickCount - $ts.回刺 > $cd.回刺) {
    return false
  }
  if ($black > 70 or $white > 70) {
    return false
  }
  if (hasStatus("连续咏唱")) {
    return false
  }
  if ($isBR and $isWR) {
    return
  }
  Send {shift down}{2}{shift up}
  $ts.即刻咏唱 := A_TickCount - $cd.即刻咏唱 + $cd.技能施放补正
  SetTimer %$watcher.即刻咏唱%, % $cd.技能施放判断间隔
  return true
}

__$watcher_dot_即刻咏唱__() {
  clearWatcher("即刻咏唱", "status")
}

__$skill_dot_醒梦__() {
  if !($level >= 24) {
    return false
  }
  if !(A_TickCount - $ts.醒梦 > $cd.醒梦) {
    return false
  }
  mp := getMp()
  if (mp > 50) {
    return false
  }
  Send {shift down}{3}{shift up}
  $ts.醒梦 := A_TickCount - $cd.醒梦 + $cd.技能施放补正
  SetTimer %$watcher.醒梦%, % $cd.技能施放判断间隔
  return true
}

__$watcher_dot_醒梦__() {
  clearWatcher("醒梦", "status")
}

__$skill_dot_沉稳咏唱__() {
  if !($level >= 44) {
    return false
  }
  Send {shift down}{4}{shift up}
  return true
}

__$skill_dot_冲刺__() {
  Send {shift down}{-}{shift up}
}

__$skill_dot_清空信息__() {
  Send {shift down}{=}{shift up}
}

__$skill_dot_赤神圣__() {
  if !($level >= 70) {
    return false
  }
  if !(A_TickCount - $ts.赤神圣 > $cd.赤神圣) {
    return false
  }
  if !(A_TickCount - $ts.连攻 < 15000) {
    return false
  }
  赤神圣施放()
  SetTimer %$watcher.赤神圣%, % $cd.技能施放判断间隔
  return true
}

__$watcher_dot_赤神圣__() {
  isA := isUsed("赤核爆")
  isB := isUsed("赤神圣")
  if !(isA or isB) {
    return
  }
  SetTimer %$watcher.赤神圣%, Off
  $ts.赤神圣 := A_TickCount - $cd.技能施放补正
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

__$skill_dot_焦热__() {
  if !($level >= 80) {
    return false
  }
  if !(A_TickCount - $ts.焦热 > $cd.焦热) {
    SoundBeep
    return false
  }
  if !(A_TickCount - $ts.赤神圣 < 15000) {
    return false
  }
  摇荡()
  SetTimer %$watcher.焦热%, % $cd.技能施放判断间隔
  return true
}

__$watcher_dot_焦热__() {
  clearWatcher("焦热")
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

__$skill_dot_能力技__(n := 2) {
  if !(A_TickCount - $ts.能力技 > $cd.能力技) {
    return
  }
  $ts.能力技 := A_TickCount
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
  if (use("倍增")) {
    return
  }
  if (use("鼓励")) {
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

__$skill_dot_调整魔元__() {
  if !($level >= 60) {
    return
  }
  if !(A_TickCount - $ts.倍增 > $cd.倍增 - 2000) {
    return
  }
  if !($black >= 60 and $white >= 60) {
    return
  }
  distance := getDistance()
  if !(distance == "near") {
    return
  }
  use("划圆斩")
  return true
}

__$skill_dot_魔三连__() {
  isValid := true
  if (hasStatus("连续咏唱")) {
    isValid := false
  }
  if (hasStatus("即刻咏唱")) {
    isValid := false
  }
  if !(isValid) {
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

attackS() {
  if (isChanting()) {
    return
  }
  if (attackSL()) {
    use("能力技")
    return
  }
  if (isMoving()) {
    use("续斩")
    use("能力技")
    return
  }
  attackSS()
}

attackM() {
  if (isChanting()) {
    return
  }
  if ($isIM) {
    use("散碎")
    use("能力技")
    return
  }
  if (isMoving()) {
    use("续斩")
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
    return false
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
  if (isChanting()) {
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
  if (isMoving()) {
    use("续斩")
    use("能力技")
    return
  }
  use("赤治疗")
}

revive() {
  if (isChanting()) {
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
  if (isMoving()) {
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
  $cd.comboZ := 15000
  $ts.回刺 := 0
  $cd.回刺 := 10000
  $skill.回刺 := Func("__$skill_dot_回刺__")
  $watcher.回刺 := Func("__$watcher_dot_回刺__")
  $skill.摇荡 := Func("__$skill_dot_摇荡__")
  $skill.赤闪雷 := Func("__$skill_dot_赤闪雷__")
  $ts.短兵相接 := 0
  $cd.短兵相接 := 40000
  $skill.短兵相接 := Func("__$skill_dot_短兵相接__")
  $watcher.短兵相接 := Func("__$watcher_dot_短兵相接__")
  $ts.赤疾风 := 0
  $skill.赤疾风 := Func("__$skill_dot_赤疾风__")
  $skill.散碎 := Func("__$skill_dot_散碎__")
  $skill.赤震雷 := Func("__$skill_dot_赤震雷__")
  $skill.赤烈风 := Func("__$skill_dot_赤烈风__")
  $skill.赤火炎 := Func("__$skill_dot_赤火炎__")
  $skill.赤飞石 := Func("__$skill_dot_赤飞石__")
  $ts.交击斩 := 0
  $cd.交击斩 := 10000
  $skill.交击斩 := Func("__$skill_dot_交击斩__")
  $watcher.交击斩 := Func("__$watcher_dot_交击斩__")
  $skill.移转 := Func("__$skill_dot_移转__")
  $ts.飞刺 := 0
  $cd.飞刺 := 25000
  $skill.飞刺 := Func("__$skill_dot_飞刺__")
  $watcher.飞刺 := Func("__$watcher_dot_飞刺__")
  $ts.连攻 := 0
  $cd.连攻 := 10000
  $skill.连攻 := Func("__$skill_dot_连攻__")
  $watcher.连攻 := Func("__$watcher_dot_连攻__")
  $ts.促进 := 0
  $cd.促进 := 55000
  $skill.促进 := Func("__$skill_dot_促进__")
  $watcher.促进 := Func("__$watcher_dot_促进__")
  $skill.划圆斩 := Func("__$skill_dot_划圆斩__")
  $skill.赤治疗 := Func("__$skill_dot_赤治疗__")
  $ts.六分反击 := 0
  $cd.六分反击 := 35000
  $skill.六分反击 := Func("__$skill_dot_六分反击__")
  $watcher.六分反击 := Func("__$watcher_dot_六分反击__")
  $ts.鼓励 := 0
  $cd.鼓励 := 120000
  $skill.鼓励 := Func("__$skill_dot_鼓励__")
  $watcher.鼓励 := Func("__$watcher_dot_鼓励__")
  $ts.倍增 := 0
  $cd.倍增 := 110000
  $skill.倍增 := Func("__$skill_dot_倍增__")
  $watcher.倍增 := Func("__$watcher_dot_倍增__")
  $skill.赤复活 := Func("__$skill_dot_赤复活__")
  $ts.交剑 := 0
  $cd.交剑 := 35000
  $skill.交剑 := Func("__$skill_dot_交剑__")
  $watcher.交剑 := Func("__$watcher_dot_交剑__")
  $skill.续斩 := Func("__$skill_dot_续斩__")
  $skill.昏乱 := Func("__$skill_dot_昏乱__")
  $ts.即刻咏唱 := 0
  $cd.即刻咏唱 := 60000
  $skill.即刻咏唱 := Func("__$skill_dot_即刻咏唱__")
  $watcher.即刻咏唱 := Func("__$watcher_dot_即刻咏唱__")
  $ts.醒梦 := 0
  $cd.醒梦 := 60000
  $skill.醒梦 := Func("__$skill_dot_醒梦__")
  $watcher.醒梦 := Func("__$watcher_dot_醒梦__")
  $skill.沉稳咏唱 := Func("__$skill_dot_沉稳咏唱__")
  $skill.冲刺 := Func("__$skill_dot_冲刺__")
  $skill.清空信息 := Func("__$skill_dot_清空信息__")
  $ts.赤神圣 := 0
  $cd.赤神圣 := 10000
  $skill.赤神圣 := Func("__$skill_dot_赤神圣__")
  $watcher.赤神圣 := Func("__$watcher_dot_赤神圣__")
  $ts.焦热 := 0
  $cd.焦热 := 10000
  $skill.焦热 := Func("__$skill_dot_焦热__")
  $watcher.焦热 := Func("__$watcher_dot_焦热__")
  $ts.能力技 := 0
  $cd.能力技 := 1000
  $skill.能力技 := Func("__$skill_dot_能力技__")
  $skill.调整魔元 := Func("__$skill_dot_调整魔元__")
  $skill.魔三连 := Func("__$skill_dot_魔三连__")
  $skill.魔划圆斩 := Func("__$skill_dot_魔划圆斩__")
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
  SetTimer bindAttack, Off
  SetTimer bindAttack, % 300
  attack()
return

2joy2::
  if !(getGroup()) {
    return
  }
  SetTimer bindAttackX, Off
  SetTimer bindAttackX, % 300
  attackX()
return

2joy3::
  if !(getGroup()) {
    return
  }
  SetTimer bindHeal, Off
  SetTimer bindHeal, % 300
  heal()
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
  use("冲刺")
return

; eof