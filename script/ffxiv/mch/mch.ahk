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
global $isNear := false
global $isTargeting := false
global $trigger := false
global $step := 0
global $level := 80
global $skill := {}
global $watcher := {}
global $blue := 0
global $isOverheat := false
global $red := 0
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
  PixelGetColor color, 1479, 682, RGB
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

checkBlue() {
  PixelSearch x, y, 1105, 806, 1248, 506, 0x58483E, 10, Fast RGB
  if !(x) {
    $blue := 100
    return
  }
  percent := (x - 1105) * 100 / (1248 - 1105)
  percent := Round(percent / 5)
  $blue := percent * 5
}

checkOverheat() {
  if !($level >= 30) {
    $isOverheat := false
    return $isOverheat
  }
  $isOverheat := A_TickCount - $ts.超荷 < 9000
  return $isOverheat
}

checkRed() {
  PixelSearch x, y, 1105, 760, 1248, 760, 0x58483E, 10, Fast RGB
  if !(x) {
    $red := 100
    return
  }
  percent := (x - 1105) * 100 / (1248 - 1105)
  percent := Round(percent / 5)
  $red := percent * 5
}

__$skill_dot_中断咏唱__() {
  if !($isChanting) {
    return true
  }
  Send {space}
  return true
}

__$skill_dot_冲刺__() {
  Send {shift down}{-}{shift up}
  return true
}

__$skill_dot_空白信息__() {
  Send {shift down}{=}{shift up}
  return true
}

__$skill_dot_索敌__() {
  if ($isTargeting) {
    return true
  }
  Send {f11}
  return true
}

__$skill_dot_伤腿__() {
  if !($isMoving) {
    return
  }
  if !(A_TickCount - $ts.伤腿 > $cd.伤腿) {
    return
  }
  if (hasStatusByTarget("加重")) {
    return
  }
  if (hasStatusByTarget("止步")) {
    return
  }
  if (hasStatusByTarget("眩晕")) {
    return
  }
  Send {shift down}{1}{shift up}
  SetTimer __$watcher_dot_伤腿__, % $cd.技能施放判断间隔
  return true
}

__$watcher_dot_伤腿__() {
  clearWatcher("伤腿")
}

__$skill_dot_伤足__() {
  if !($isMoving) {
    return
  }
  if !(A_TickCount - $ts.伤足 > $cd.伤足) {
    return
  }
  if (hasStatusByTarget("加重")) {
    return
  }
  if (hasStatusByTarget("止步")) {
    return
  }
  if (hasStatusByTarget("眩晕")) {
    return
  }
  Send {shift down}{3}{shift up}
  SetTimer __$watcher_dot_伤足__, % $cd.技能施放判断间隔
  return true
}

__$watcher_dot_伤足__() {
  clearWatcher("伤足")
}

__$skill_dot_分裂弹__() {
  if !($step == 0) {
    return
  }
  if !(A_TickCount - $ts.分裂弹 > $cd.分裂弹) {
    return
  }
  Send {alt down}{1}{alt up}
  SetTimer __$watcher_dot_分裂弹__, % $cd.技能施放判断间隔
  return true
}

__$watcher_dot_分裂弹__() {
  if !($level >= 54) {
    if !(hasUsed("分裂弹")) {
      return
    }
  }
  else {
    if !(hasUsed("热分裂弹")) {
      return
    }
  }
  SetTimer __$watcher_dot_分裂弹__, Off
  $ts.分裂弹 := A_TickCount - $cd.技能施放补正
  $step := 1
  SetTimer resetStep, Off
  SetTimer resetStep, % 0 - 15000
}

__$skill_dot_弹射__() {
  if !($level >= 50) {
    return
  }
  if !(A_TickCount - $ts.弹射 > $cd.弹射) {
    return
  }
  Send {ctrl down}{1}{ctrl up}
  SetTimer __$watcher_dot_弹射__, % $cd.技能施放判断间隔
  return true
}

__$watcher_dot_弹射__() {
  clearWatcher("弹射")
}

__$skill_dot_报告__() {
  if !($isReporting) {
    return
  }
  msg := makeReportMsg()
  msg := "" . msg . "`n"
  msg := "" . msg . "`nred: " . $red . " / blue: " . $blue . " / overheat: " . $isOverheat . ""
  msg := "" . msg . "`n"
  $ts.报告 := A_TickCount
  msg := makeReportMsg(msg, ["热弹", "整备", "虹吸弹", "超荷", "野火", "弹射", "伤腿", "伤足"])
  ToolTip % msg, 410, 640
  SetTimer clearTip, Off
  SetTimer clearTip, % 0 - 10000
}

__$skill_dot_散射__() {
  if !($level >= 18) {
    return
  }
  if !($step < 20) {
    return
  }
  if !(A_TickCount - $ts.散射 > $cd.散射) {
    return
  }
  Send {alt down}{6}{alt up}
  SetTimer __$watcher_dot_散射__, % $cd.技能施放判断间隔
  return true
}

__$watcher_dot_散射__() {
  if !(clearWatcher("散射")) {
    return
  }
  $step := 0
  SetTimer resetStep, Off
}

__$skill_dot_整备__() {
  if !($step == 2) {
    return
  }
  if !(A_TickCount - $ts.整备 > $cd.整备) {
    return
  }
  Send {alt down}{4}{alt up}
  SetTimer __$watcher_dot_整备__, % $cd.技能施放判断间隔
  return true
}

__$watcher_dot_整备__() {
  clearWatcher("整备", "status")
}

__$skill_dot_热冲击__() {
  if !($level >= 35) {
    return
  }
  if !($isOverheat) {
    return
  }
  Send {alt down}{9}{alt up}
  $ts.虹吸弹 := $ts.虹吸弹 - 15000
  $ts.弹射 := $ts.弹射 - 15000
  return true
}

__$skill_dot_热弹__() {
  if !(A_TickCount - $ts.热弹 > $cd.热弹) {
    return
  }
  Send {alt down}{3}{alt up}
  SetTimer __$watcher_dot_热弹__, % $cd.技能施放判断间隔
  return true
}

__$watcher_dot_热弹__() {
  clearWatcher("热弹")
}

__$skill_dot_狙击弹__() {
  if !($level >= 26) {
    return
  }
  if !($step == 2) {
    return
  }
  if !(A_TickCount - $ts.狙击弹 > $cd.狙击弹) {
    return
  }
  Send {alt down}{7}{alt up}
  SetTimer __$watcher_dot_狙击弹__, % $cd.技能施放判断间隔
  return true
}

__$watcher_dot_狙击弹__() {
  if !(clearWatcher("狙击弹")) {
    return
  }
  $step := 0
  SetTimer resetStep, Off
}

__$skill_dot_独头弹__() {
  if !($step == 1) {
    return
  }
  if !(A_TickCount - $ts.独头弹 > $cd.独头弹) {
    return
  }
  Send {alt down}{2}{alt up}
  SetTimer __$watcher_dot_独头弹__, % $cd.技能施放判断间隔
  return true
}

__$watcher_dot_独头弹__() {
  if !(clearWatcher("独头弹")) {
    return
  }
  if !($level >= 26) {
    $step := 0
    return
  }
  $step := 2
  SetTimer resetStep, Off
  SetTimer resetStep, % 0 - 15000
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
  if ($isOverheat) {
    能力技施放B()
    return
  }
  能力技施放A()
}

能力技施放A() {
  if ($ap == 1) {
    if (use("野火")) {
      return
    }
  }
  else {
    if (use("超荷")) {
      return
    }
  }
  for __i__, skill in ["整备", "虹吸弹", "车式浮空炮塔", "弹射", "伤腿", "伤足", "空白信息"] {
    if (use(skill)) {
      break
    }
  }
}

能力技施放B() {
  for __i__, skill in ["虹吸弹", "弹射", "空白信息"] {
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
  checkBlue()
  checkRed()
  checkOverheat()
}

__$skill_dot_虹吸弹__() {
  if !($level >= 15) {
    return
  }
  if !(A_TickCount - $ts.虹吸弹 > $cd.虹吸弹) {
    return
  }
  Send {alt down}{5}{alt up}
  SetTimer __$watcher_dot_虹吸弹__, % $cd.技能施放判断间隔
  return true
}

__$watcher_dot_虹吸弹__() {
  clearWatcher("虹吸弹")
}

__$skill_dot_超荷__() {
  if !($level >= 30) {
    return
  }
  if !($red >= 50) {
    return
  }
  if !(A_TickCount - $ts.超荷 > $cd.超荷) {
    return
  }
  Send {alt down}{8}{alt up}
  SetTimer __$watcher_dot_超荷__, % $cd.技能施放判断间隔
  return true
}

__$watcher_dot_超荷__() {
  clearWatcher("超荷")
}

__$skill_dot_车式浮空炮塔__() {
  if !($level >= 40) {
    return
  }
  if !($blue >= 50) {
    return
  }
  if !(A_TickCount - $ts.车式浮空炮塔 > $cd.车式浮空炮塔) {
    return
  }
  Send {alt down}{0}{alt up}
  SetTimer __$watcher_dot_车式浮空炮塔__, % $cd.技能施放判断间隔
  return true
}

__$watcher_dot_车式浮空炮塔__() {
  clearWatcher("车式浮空炮塔", "status")
}

__$skill_dot_速行__() {
  if !($isMoving) {
    return
  }
  if ($isTargeting) {
    return
  }
  if !(A_TickCount - $ts.targeting > 2500) {
    return
  }
  if !(A_TickCount - $ts.速行 > $cd.速行) {
    return
  }
  if (hasStatus("速行")) {
    return
  }
  Send {shift down}{4}{shift up}
  SetTimer __$watcher_dot_速行__, % $cd.技能施放判断间隔
  return true
}

__$watcher_dot_速行__() {
  clearWatcher("速行", "status")
}

__$skill_dot_野火__() {
  if !($level >= 45) {
    return
  }
  if !($red >= 50) {
    return
  }
  if !(A_TickCount - $ts.野火 > $cd.野火) {
    return
  }
  Send {alt down}{=}{alt up}
  SetTimer __$watcher_dot_野火__, % $cd.技能施放判断间隔
  return true
}

__$watcher_dot_野火__() {
  clearWatcher("野火")
}

attackS() {
  if !($isTargeting) {
    use("索敌")
    use("速行")
    return
  }
  if !($isNear) {
    SoundBeep
    return
  }
  if ($isOverheat) {
    use("热冲击")
    use("能力技")
    return
  }
  for __i__, skill in ["热弹", "分裂弹", "独头弹", "狙击弹"] {
    if (use(skill)) {
      use("能力技")
      break
    }
  }
}

attackM() {
  if !($isTargeting) {
    use("索敌")
    use("速行")
    return
  }
  if !($isNear) {
    SoundBeep
    return
  }
  if (use("散射")) {
    use("能力技")
    return
  }
}

__$default__() {
  $ts.targeting := 0
  $cd.技能施放判断间隔 := 100
  $cd.技能施放补正 := 1500
  $skill.中断咏唱 := Func("__$skill_dot_中断咏唱__")
  $skill.冲刺 := Func("__$skill_dot_冲刺__")
  $skill.空白信息 := Func("__$skill_dot_空白信息__")
  $skill.索敌 := Func("__$skill_dot_索敌__")
  $ts.伤腿 := 0
  $cd.伤腿 := 30000
  $skill.伤腿 := Func("__$skill_dot_伤腿__")
  $watcher.伤腿 := Func("__$watcher_dot_伤腿__")
  $ts.伤足 := 0
  $cd.伤足 := 30000
  $skill.伤足 := Func("__$skill_dot_伤足__")
  $watcher.伤足 := Func("__$watcher_dot_伤足__")
  $ts.分裂弹 := 0
  $cd.分裂弹 := 2500
  $skill.分裂弹 := Func("__$skill_dot_分裂弹__")
  $watcher.分裂弹 := Func("__$watcher_dot_分裂弹__")
  $ts.弹射 := 0
  $cd.弹射 := 30000
  $skill.弹射 := Func("__$skill_dot_弹射__")
  $watcher.弹射 := Func("__$watcher_dot_弹射__")
  $ts.报告 := 0
  $skill.报告 := Func("__$skill_dot_报告__")
  $ts.散射 := 0
  $cd.散射 := 2500
  $skill.散射 := Func("__$skill_dot_散射__")
  $watcher.散射 := Func("__$watcher_dot_散射__")
  $ts.整备 := 0
  $cd.整备 := 55000
  $skill.整备 := Func("__$skill_dot_整备__")
  $watcher.整备 := Func("__$watcher_dot_整备__")
  $skill.热冲击 := Func("__$skill_dot_热冲击__")
  $ts.热弹 := 0
  $cd.热弹 := 40000
  $skill.热弹 := Func("__$skill_dot_热弹__")
  $watcher.热弹 := Func("__$watcher_dot_热弹__")
  $ts.狙击弹 := 0
  $cd.狙击弹 := 2500
  $skill.狙击弹 := Func("__$skill_dot_狙击弹__")
  $watcher.狙击弹 := Func("__$watcher_dot_狙击弹__")
  $ts.独头弹 := 0
  $cd.独头弹 := 2500
  $skill.独头弹 := Func("__$skill_dot_独头弹__")
  $watcher.独头弹 := Func("__$watcher_dot_独头弹__")
  $ts.能力技 := 0
  $cd.能力技 := 1000
  $skill.能力技 := Func("__$skill_dot_能力技__")
  $ts.获取状态 := 0
  $skill.获取状态 := Func("__$skill_dot_获取状态__")
  $ts.虹吸弹 := 0
  $cd.虹吸弹 := 30000
  $skill.虹吸弹 := Func("__$skill_dot_虹吸弹__")
  $watcher.虹吸弹 := Func("__$watcher_dot_虹吸弹__")
  $ts.超荷 := 0
  $cd.超荷 := 10000
  $skill.超荷 := Func("__$skill_dot_超荷__")
  $watcher.超荷 := Func("__$watcher_dot_超荷__")
  $ts.车式浮空炮塔 := 0
  $cd.车式浮空炮塔 := 6000
  $skill.车式浮空炮塔 := Func("__$skill_dot_车式浮空炮塔__")
  $watcher.车式浮空炮塔 := Func("__$watcher_dot_车式浮空炮塔__")
  $ts.速行 := 0
  $cd.速行 := 5000
  $skill.速行 := Func("__$skill_dot_速行__")
  $watcher.速行 := Func("__$watcher_dot_速行__")
  $ts.野火 := 0
  $cd.野火 := 120000
  $skill.野火 := Func("__$skill_dot_野火__")
  $watcher.野火 := Func("__$watcher_dot_野火__")
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

; eof