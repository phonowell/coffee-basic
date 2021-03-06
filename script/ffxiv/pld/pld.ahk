﻿; generated by coffee-basic/0.0.3

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
global $isNear := false
global $isTargeting := false
global $trigger := false
global $step := 0
global $level := 80
global $skill := {}
global $watcher := {}
global $gold := 0
global $isReporting := true
global $ap := 0

; function

attack() {
  use("获取状态")
  use("报告")
  if ($trigger == "right") {
    attackS()
    return
  }
  if ($trigger == "both") {
    attackM()
    return
  }
  if ($trigger == "left") {
    attackF()
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
    return $isChanting
  }
  PixelGetColor color, 1130, 865, RGB
  $isChanting := color == 0x2B1B13
  return isChanting
}

checkHp() {
  PixelSearch x, y, 21, 36, 168, 36, 0x58483E, 10, Fast RGB
  if !(x) {
    $hp := 100
    return $hp
  }
  percent := (x - 21) * 100 / (168 - 21)
  percent := Round(percent)
  $hp := percent
  return $hp
}

checkMoving() {
  GetKeyState dis, 2joyx
  if (dis < 40 or dis > 60) {
    $isMoving := true
    return $isMoving
  }
  GetKeyState dis, 2joyy
  if (dis < 40 or dis > 60) {
    $isMoving := true
    return $isMoving
  }
  $isMoving := false
  return $isMoving
}

checkMp() {
  PixelSearch x, y, 181, 36, 328, 36, 0x58483E, 10, Fast RGB
  if !(x) {
    $mp := 100
    return $mp
  }
  percent := (x - 181) * 100 / (328 - 181)
  percent := Round(percent)
  $mp := percent
  return $mp
}

checkNear() {
  if !($isTargeting) {
    $isNear := false
    return $isNear
  }
  PixelGetColor color, 1803, 764, RGB
  if (color == 0xD23A3A) {
    $isNear := false
    return $isNear
  }
  $isNear := true
  return $isNear
}

checkTargeting() {
  PixelGetColor color, 650, 65, RGB
  if (color == 0xFF8888) {
    return setTargeting()
  }
  if (color == 0xFFC888) {
    return setTargeting()
  }
  if (color == 0xEBD788) {
    return setTargeting()
  }
  if (color == 0xFFB1FF) {
    return setTargeting()
  }
  $isTargeting := false
  return $isTargeting
}

setTargeting() {
  $isTargeting := true
  $ts.targeting := A_TickCount
  return $isTargeting
}

checkTrigger() {
  GetKeyState __value__, 2joy7
  isLT := __value__ == "D"
  GetKeyState __value__, 2joy8
  isRT := __value__ == "D"
  if (isLT and isRT) {
    $trigger := "both"
    return $trigger
  }
  if (isLT) {
    $trigger := "left"
    return $trigger
  }
  if (isRT) {
    $trigger := "right"
    return $trigger
  }
  $trigger := false
  return $trigger
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

hasStatus(name) {
  ImageSearch x, y, 725, 840, 925, 875, % A_ScriptDir . "\" . "image\" . name . ".png"
  return x > 0 and y > 0
}

hasStatusByTarget(name) {
  ImageSearch x, y, 725, 765, 925, 800, % A_ScriptDir . "\" . "image\" . name . ".png"
  return x > 0 and y > 0
}

hasUsed(name) {
  ImageSearch x, y, 60, 915, 225, 975, % A_ScriptDir . "\" . "image\" . name . ".png"
  return x > 0 and y > 0
}

makeReportMsg(msg := false, list := false) {
  if !(msg) {
    msg := "Lv." . $level . " / " . $trigger . " / " . A_TickCount - $ts.报告 . " ms"
    msg := "" . msg . "`nhp: " . $hp . " / mp: " . $mp . ""
    msg := "" . msg . "`ntargeting: " . $isTargeting . " / near: " . $isNear . ""
    msg := "" . msg . "`nmoving: " . $isMoving . " / chanting: " . $isChanting . ""
    return msg
  }
  for __i__, name in list {
    result := calcCd(name)
    if !(result > 1) {
      continue
    }
    msg := "" . msg . "`n" . name . ": " . result . " s"
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

checkGold() {
  if !($level >= 35) {
    $gold := 0
    return
  }
  PixelSearch x, y, 1104, 806, 1247, 806, 0x58483E, 10, Fast RGB
  if !(x) {
    $gold := 100
    return
  }
  percent := (x - 1104) * 100 / (1247 - 1104)
  percent := Round(percent / 5)
  $gold := percent * 5
}

__$skill_dot_中断咏唱__() {
  if !($isChanting) {
    return true
  }
  Send {space}
  return true
}

__$skill_dot_冲刺__() {
  Send {ctrl down}{alt down}{-}{alt up}{ctrl up}
  return true
}

__$skill_dot_空白信息__() {
  Send {ctrl down}{alt down}{=}{alt up}{ctrl up}
  return true
}

__$skill_dot_索敌__() {
  if ($isTargeting) {
    return true
  }
  Send {f11}
  return true
}

__$skill_dot_下踢__() {
  if !(A_TickCount - $ts.下踢 > $cd.下踢) {
    return
  }
  if (hasStatusByTarget("眩晕")) {
    return
  }
  Send {ctrl down}{alt down}{2}{alt up}{ctrl up}
  SetTimer __$watcher_dot_下踢__, % $cd.技能施放判断间隔
  return true
}

__$watcher_dot_下踢__() {
  clearWatcher("下踢")
}

__$skill_dot_亲疏自行__() {
  if !(A_TickCount - $ts.亲疏自行 > $cd.亲疏自行) {
    return
  }
  Send {ctrl down}{alt down}{6}{alt up}{ctrl up}
  SetTimer __$watcher_dot_亲疏自行__, % $cd.技能施放判断间隔
  return true
}

__$watcher_dot_亲疏自行__() {
  clearWatcher("亲疏自行", "status")
}

__$skill_dot_先锋剑__() {
  if !($step == 0 or $step > 20) {
    return
  }
  if !(A_TickCount - $ts.先锋剑 > $cd.先锋剑) {
    return
  }
  Send {ctrl down}{1}{ctrl up}
  SetTimer __$watcher_dot_先锋剑__, % $cd.技能施放判断间隔
  return true
}

__$watcher_dot_先锋剑__() {
  if !(clearWatcher("先锋剑")) {
    return
  }
  $step := 1
  SetTimer resetStep, Off
  SetTimer resetStep, % 0 - 15000
}

__$skill_dot_全蚀斩__() {
  if !($step < 20) {
    return
  }
  if !(A_TickCount - $ts.全蚀斩 > $cd.全蚀斩) {
    return
  }
  Send {ctrl down}{4}{ctrl up}
  SetTimer __$watcher_dot_全蚀斩__, % $cd.技能施放判断间隔
  return true
}

__$watcher_dot_全蚀斩__() {
  if !(clearWatcher("全蚀斩")) {
    return
  }
  if !($level >= 40) {
    $step := 0
    SetTimer resetStep, Off
    return
  }
  $step := 21
  SetTimer resetStep, Off
  SetTimer resetStep, % 15000
}

__$skill_dot_厄运流转__() {
  if !($level >= 50) {
    return
  }
  if !(A_TickCount - $ts.厄运流转 > $cd.厄运流转) {
    return
  }
  Send {ctrl down}{0}{ctrl up}
  SetTimer __$watcher_dot_厄运流转__, % $cd.技能施放判断间隔
  return true
}

__$watcher_dot_厄运流转__() {
  clearWatcher("厄运流转")
}

__$skill_dot_圣光幕帘__() {
  if !($level >= 56) {
    return
  }
  if !($isTargeting) {
    return
  }
  if !(A_TickCount - $ts.圣光幕帘 > $cd.圣光幕帘) {
    return
  }
  Send {alt down}{5}{alt up}
  SetTimer __$watcher_dot_圣光幕帘__, % $cd.技能施放判断间隔
  return true
}

__$watcher_dot_圣光幕帘__() {
  clearWatcher("圣光幕帘")
}

__$skill_dot_圣灵__() {
  if !($level >= 64) {
    return
  }
  if !($mp >= 20) {
    return
  }
  if !(hasStatus("安魂祈祷")) {
    return
  }
  Send {alt down}{8}{alt up}
  $step := 0
  return true
}

__$skill_dot_圣环__() {
  if !($level >= 72) {
    return
  }
  if !($mp >= 20) {
    return
  }
  if !(hasStatus("安魂祈祷")) {
    return
  }
  Send {alt down}{-}{alt up}
  $step := 0
  return true
}

__$skill_dot_安魂祈祷__() {
  if !($level >= 68) {
    return
  }
  if !($isTargeting) {
    return
  }
  if !($mp > 80) {
    return
  }
  if !($step == 0) {
    return
  }
  if !(A_TickCount - $ts.安魂祈祷 > $cd.安魂祈祷) {
    return
  }
  Send {alt down}{9}{alt up}
  SetTimer __$watcher_dot_安魂祈祷__, % $cd.技能施放判断间隔
  return true
}

__$watcher_dot_安魂祈祷__() {
  clearWatcher("安魂祈祷", "status")
}

__$skill_dot_战女神之怒__() {
  if !($level >= 26) {
    return
  }
  if !($step == 2) {
    return
  }
  if !(A_TickCount - $ts.战女神之怒 > $cd.战女神之怒) {
    return
  }
  Send {ctrl down}{8}{ctrl up}
  SetTimer __$watcher_dot_战女神之怒__, % $cd.技能施放判断间隔
  return true
}

__$watcher_dot_战女神之怒__() {
  if ($level < 60) {
    if !(clearWatcher("战女神之怒")) {
      return
    }
  }
  else {
    if !(hasUsed("王权剑")) {
      return
    }
    SetTimer __$watcher_dot_战女神之怒__, Off
    $ts.战女神之怒 := A_TickCount - $cd.技能施放补正
  }
  $step := 0
  SetTimer resetStep, Off
}

__$skill_dot_战逃反应__() {
  if !(A_TickCount - $ts.战逃反应 > $cd.战逃反应) {
    return
  }
  Send {ctrl down}{2}{ctrl up}
  SetTimer __$watcher_dot_战逃反应__, % $cd.技能施放判断间隔
  return true
}

__$watcher_dot_战逃反应__() {
  clearWatcher("战逃反应", "status")
}

__$skill_dot_投盾__() {
  if !($level >= 15) {
    return
  }
  if !(A_TickCount - $ts.投盾 > $cd.投盾) {
    return
  }
  Send {ctrl down}{7}{ctrl up}
  SetTimer __$watcher_dot_投盾__, % $cd.技能施放判断间隔
  return true
}

__$watcher_dot_投盾__() {
  if !(clearWatcher("投盾")) {
    return
  }
  $step := 0
}

__$skill_dot_报告__() {
  if !($isReporting) {
    return
  }
  msg := makeReportMsg()
  msg := "" . msg . "`n"
  msg := "" . msg . "`ngold: " . $gold . ""
  msg := "" . msg . "`n"
  $ts.报告 := A_TickCount
  msg := makeReportMsg(msg, ["战逃反应", "预警", "深奥之灵", "厄运流转", "沥血剑", "安魂祈祷", "调停", "铁壁", "下踢", "插言", "雪仇", "亲疏自行"])
  ToolTip % msg, 410, 640
  SetTimer clearTip, Off
  SetTimer clearTip, % 0 - 10000
}

__$skill_dot_插言__() {
  if !(A_TickCount - $ts.插言 > $cd.插言) {
    return
  }
  if (hasStatusByTarget("眩晕")) {
    return
  }
  Send {ctrl down}{alt down}{4}{alt up}{ctrl up}
  SetTimer __$watcher_dot_插言__, % $cd.技能施放判断间隔
  return true
}

__$watcher_dot_插言__() {
  clearWatcher("插言")
}

__$skill_dot_日珥斩__() {
  if !($level >= 40) {
    return
  }
  if !($step == 21) {
    return
  }
  if !(A_TickCount - $ts.日珥斩 > $cd.日珥斩) {
    return
  }
  Send {alt down}{1}{alt up}
  SetTimer __$watcher_dot_日珥斩__, % $cd.技能施放判断间隔
  return true
}

__$watcher_dot_日珥斩__() {
  if !(clearWatcher("日珥斩")) {
    return
  }
  $step := 0
  SetTimer resetStep, Off
}

__$skill_dot_暴乱剑__() {
  if !($step == 1) {
    return
  }
  if !(A_TickCount - $ts.暴乱剑 > $cd.暴乱剑) {
    return
  }
  Send {ctrl down}{3}{ctrl up}
  SetTimer __$watcher_dot_暴乱剑__, % $cd.技能施放判断间隔
  return true
}

__$watcher_dot_暴乱剑__() {
  if !(clearWatcher("暴乱剑")) {
    return
  }
  if !($level >= 26) {
    $step := 0
    SetTimer resetStep, Off
    return
  }
  $step := 2
  SetTimer resetStep, Off
  SetTimer resetStep, % 0 - 15000
}

__$skill_dot_沥血剑__() {
  if !($level >= 54) {
    return
  }
  if !($step == 2) {
    return
  }
  if !(hasStatusByTarget("沥血剑-敌")) {
    $ts.沥血剑 := 0
  }
  if !(A_TickCount - $ts.沥血剑 > $cd.沥血剑) {
    return
  }
  Send {alt down}{4}{alt up}
  SetTimer __$watcher_dot_沥血剑__, % $cd.技能施放判断间隔
  return true
}

__$watcher_dot_沥血剑__() {
  if !(clearWatcher("沥血剑")) {
    return
  }
  $step := 0
}

__$skill_dot_深仁厚泽__() {
  if !($level >= 58) {
    return
  }
  if ($level >= 64) {
    if !($mp >= 20) {
      return
    }
  }
  else {
    if !($mp >= 40) {
      return
    }
  }
  if !(A_TickCount - $ts.深仁厚泽 > $cd.深仁厚泽) {
    return
  }
  Send {alt down}{6}{alt up}
  SetTimer __$watcher_dot_深仁厚泽__, % $cd.技能施放判断间隔
  return true
}

__$watcher_dot_深仁厚泽__() {
  if !(clearWatcher("深仁厚泽")) {
    return
  }
  $step := 0
}

__$skill_dot_深奥之灵__() {
  if !($level >= 30) {
    return
  }
  if !(A_TickCount - $ts.深奥之灵 > $cd.深奥之灵) {
    return
  }
  Send {ctrl down}{-}{ctrl up}
  SetTimer __$watcher_dot_深奥之灵__, % $cd.技能施放判断间隔
  return true
}

__$watcher_dot_深奥之灵__() {
  clearWatcher("深奥之灵")
}

__$skill_dot_盾阵__() {
  if !($level >= 35) {
    return
  }
  if !($gold >= 50) {
    return
  }
  if !(A_TickCount - $ts.盾阵 > $cd.盾阵) {
    return
  }
  Send {ctrl down}{=}{ctrl up}
  SetTimer __$watcher_dot_盾阵__, % $cd.技能施放判断间隔
  return true
}

__$watcher_dot_盾阵__() {
  clearWatcher("盾阵", "status")
}

__$skill_dot_自动盾阵__() {
  if !($level >= 35) {
    return
  }
  if !($gold >= 95) {
    return
  }
  use("盾阵")
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
  能力技施放()
}

能力技施放() {
  if !($isTargeting) {
    use("空白信息")
    return
  }
  if !($isNear) {
    use("空白信息")
    return
  }
  for __i__, skill in ["战逃反应", "深奥之灵", "厄运流转", "安魂祈祷", "调停", "雪仇", "亲疏自行", "自动盾阵", "空白信息"] {
    if (use(skill)) {
      break
    }
  }
}

__$skill_dot_获取状态__() {
  if (A_TickCount - $ts.获取状态 > 10000) {
    use("空白信息")
    use("空白信息")
    use("空白信息")
  }
  $ts.获取状态 := A_TickCount
  checkTrigger()
  checkTargeting()
  checkNear()
  checkMoving()
  checkMp()
  checkGold()
}

__$skill_dot_调停__() {
  if !($level >= 74) {
    return
  }
  if !($ap == 1) {
    return
  }
  if !(A_TickCount - $ts.调停 > $cd.调停) {
    return
  }
  Send {alt down}{=}{alt up}
  SetTimer __$watcher_dot_调停__, % $cd.技能施放判断间隔
  return true
}

__$watcher_dot_调停__() {
  clearWatcher("调停")
}

__$skill_dot_铁壁__() {
  if !(A_TickCount - $ts.铁壁 > $cd.铁壁) {
    return
  }
  Send {ctrl down}{alt down}{1}{alt up}{ctrl up}
  SetTimer __$watcher_dot_铁壁__, % $cd.技能施放判断间隔
  return true
}

__$watcher_dot_铁壁__() {
  clearWatcher("铁壁", "status")
}

__$skill_dot_雪仇__() {
  if !(A_TickCount - $ts.雪仇 > $cd.雪仇) {
    return
  }
  Send {ctrl down}{alt down}{5}{alt up}{ctrl up}
  SetTimer __$watcher_dot_雪仇__, % $cd.技能施放判断间隔
  return true
}

__$watcher_dot_雪仇__() {
  clearWatcher("雪仇")
}

__$skill_dot_预警__() {
  if !($level >= 38) {
    return
  }
  if !(A_TickCount - $ts.预警 > $cd.预警) {
    return
  }
  Send {ctrl down}{9}{ctrl up}
  SetTimer __$watcher_dot_预警__, % $cd.技能施放判断间隔
  return true
}

__$watcher_dot_预警__() {
  clearWatcher("预警", "status")
}

attackS() {
  if !($isTargeting) {
    use("索敌")
    return
  }
  if (use("圣灵")) {
    return
  }
  if !($isNear) {
    SoundBeep
    return
  }
  for __i__, skill in ["先锋剑", "暴乱剑", "沥血剑", "战女神之怒"] {
    if (use(skill)) {
      use("能力技")
      return
    }
  }
}

attackM() {
  if (use("圣环")) {
    return
  }
  for __i__, skill in ["全蚀斩", "日珥斩"] {
    if (use(skill)) {
      use("能力技")
      break
    }
  }
}

attackF() {
  if !($isTargeting) {
    use("索敌")
    return
  }
  use("投盾")
}

defendS() {
  if !($isTargeting) {
    return
  }
  for __i__, skill in ["铁壁", "预警", "盾阵"] {
    if (use(skill)) {
      return
    }
  }
  SoundBeep
}

breakS() {
  if !($isTargeting) {
    return
  }
  for __i__, skill in ["下踢", "插言"] {
    if (use(skill)) {
      return
    }
  }
  SoundBeep
}

healS() {
  for __i__, skill in ["圣光幕帘", "深仁厚泽"] {
    if (use(skill)) {
      return
    }
  }
  SoundBeep
}

__$default__() {
  $ts.targeting := 0
  $cd.技能施放判断间隔 := 100
  $cd.技能施放补正 := 1500
  $skill.中断咏唱 := Func("__$skill_dot_中断咏唱__")
  $skill.冲刺 := Func("__$skill_dot_冲刺__")
  $skill.空白信息 := Func("__$skill_dot_空白信息__")
  $skill.索敌 := Func("__$skill_dot_索敌__")
  $ts.下踢 := 0
  $cd.下踢 := 25000
  $skill.下踢 := Func("__$skill_dot_下踢__")
  $watcher.下踢 := Func("__$watcher_dot_下踢__")
  $ts.亲疏自行 := 0
  $cd.亲疏自行 := 120000
  $skill.亲疏自行 := Func("__$skill_dot_亲疏自行__")
  $watcher.亲疏自行 := Func("__$watcher_dot_亲疏自行__")
  $ts.先锋剑 := 0
  $cd.先锋剑 := 2500
  $skill.先锋剑 := Func("__$skill_dot_先锋剑__")
  $watcher.先锋剑 := Func("__$watcher_dot_先锋剑__")
  $ts.全蚀斩 := 0
  $cd.全蚀斩 := 2500
  $skill.全蚀斩 := Func("__$skill_dot_全蚀斩__")
  $watcher.全蚀斩 := Func("__$watcher_dot_全蚀斩__")
  $ts.厄运流转 := 0
  $cd.厄运流转 := 25000
  $skill.厄运流转 := Func("__$skill_dot_厄运流转__")
  $watcher.厄运流转 := Func("__$watcher_dot_厄运流转__")
  $ts.圣光幕帘 := 0
  $cd.圣光幕帘 := 90000
  $skill.圣光幕帘 := Func("__$skill_dot_圣光幕帘__")
  $watcher.圣光幕帘 := Func("__$watcher_dot_圣光幕帘__")
  $skill.圣灵 := Func("__$skill_dot_圣灵__")
  $skill.圣环 := Func("__$skill_dot_圣环__")
  $ts.安魂祈祷 := 0
  $cd.安魂祈祷 := 60000
  $skill.安魂祈祷 := Func("__$skill_dot_安魂祈祷__")
  $watcher.安魂祈祷 := Func("__$watcher_dot_安魂祈祷__")
  $ts.战女神之怒 := 0
  $cd.战女神之怒 := 2500
  $skill.战女神之怒 := Func("__$skill_dot_战女神之怒__")
  $watcher.战女神之怒 := Func("__$watcher_dot_战女神之怒__")
  $ts.战逃反应 := 0
  $cd.战逃反应 := 60000
  $skill.战逃反应 := Func("__$skill_dot_战逃反应__")
  $watcher.战逃反应 := Func("__$watcher_dot_战逃反应__")
  $ts.投盾 := 0
  $cd.投盾 := 2500
  $skill.投盾 := Func("__$skill_dot_投盾__")
  $watcher.投盾 := Func("__$watcher_dot_投盾__")
  $ts.报告 := 0
  $skill.报告 := Func("__$skill_dot_报告__")
  $ts.插言 := 0
  $cd.插言 := 30000
  $skill.插言 := Func("__$skill_dot_插言__")
  $watcher.插言 := Func("__$watcher_dot_插言__")
  $ts.日珥斩 := 0
  $cd.日珥斩 := 2500
  $skill.日珥斩 := Func("__$skill_dot_日珥斩__")
  $watcher.日珥斩 := Func("__$watcher_dot_日珥斩__")
  $ts.暴乱剑 := 0
  $cd.暴乱剑 := 2500
  $skill.暴乱剑 := Func("__$skill_dot_暴乱剑__")
  $watcher.暴乱剑 := Func("__$watcher_dot_暴乱剑__")
  $ts.沥血剑 := 0
  $cd.沥血剑 := 21000 - 3000
  $skill.沥血剑 := Func("__$skill_dot_沥血剑__")
  $watcher.沥血剑 := Func("__$watcher_dot_沥血剑__")
  $ts.深仁厚泽 := 0
  $cd.深仁厚泽 := 2500
  $skill.深仁厚泽 := Func("__$skill_dot_深仁厚泽__")
  $watcher.深仁厚泽 := Func("__$watcher_dot_深仁厚泽__")
  $ts.深奥之灵 := 0
  $cd.深奥之灵 := 30000
  $skill.深奥之灵 := Func("__$skill_dot_深奥之灵__")
  $watcher.深奥之灵 := Func("__$watcher_dot_深奥之灵__")
  $ts.盾阵 := 0
  $cd.盾阵 := 5000
  $skill.盾阵 := Func("__$skill_dot_盾阵__")
  $watcher.盾阵 := Func("__$watcher_dot_盾阵__")
  $skill.自动盾阵 := Func("__$skill_dot_自动盾阵__")
  $ts.能力技 := 0
  $cd.能力技 := 1000
  $skill.能力技 := Func("__$skill_dot_能力技__")
  $ts.获取状态 := 0
  $skill.获取状态 := Func("__$skill_dot_获取状态__")
  $ts.调停 := 0
  $cd.调停 := 30000
  $skill.调停 := Func("__$skill_dot_调停__")
  $watcher.调停 := Func("__$watcher_dot_调停__")
  $ts.铁壁 := 0
  $cd.铁壁 := 90000
  $skill.铁壁 := Func("__$skill_dot_铁壁__")
  $watcher.铁壁 := Func("__$watcher_dot_铁壁__")
  $ts.雪仇 := 0
  $cd.雪仇 := 60000
  $skill.雪仇 := Func("__$skill_dot_雪仇__")
  $watcher.雪仇 := Func("__$watcher_dot_雪仇__")
  $ts.预警 := 0
  $cd.预警 := 120000
  $skill.预警 := Func("__$skill_dot_预警__")
  $watcher.预警 := Func("__$watcher_dot_预警__")
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

2joy12::
  if !(checkTrigger()) {
    return
  }
  use("冲刺")
return

2joy4::
  if !(checkTrigger()) {
    return
  }
  SetTimer bindAttack, Off
  SetTimer bindAttack, % 300
  attack()
return

2joy2::
  if !(checkTrigger()) {
    return
  }
  if ($trigger == "right") {
    defendS()
    return
  }
return

2joy1::
  if !(checkTrigger()) {
    return
  }
  if ($trigger == "right") {
    breakS()
    return
  }
return

2joy3::
  if !(checkTrigger()) {
    return
  }
  if ($trigger == "right") {
    healS()
    return
  }
return

; eof