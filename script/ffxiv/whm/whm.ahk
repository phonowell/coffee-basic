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
global $red := 0
global $white := 0
global $isReporting := true

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

checkRed() {
  PixelGetColor color, 1075, 818, RGB
  if !(color == 0xDEB673) {
    $red := 3
    return
  }
  PixelGetColor color, 1057, 818, RGB
  if !(color == 0xDEB673) {
    $red := 2
    return
  }
  PixelGetColor color, 1039, 818, RGB
  if !(color == 0xDEB673) {
    $red := 1
    return
  }
  $red := 0
}

checkWhite() {
  PixelGetColor color, 1078, 790, RGB
  if !(color == 0xD6B273) {
    $white := 3
    return
  }
  PixelGetColor color, 1058, 790, RGB
  if !(color == 0xD6B273) {
    $white := 2
    return
  }
  PixelGetColor color, 1038, 790, RGB
  if !(color == 0xD6B273) {
    $white := 1
    return
  }
  $white := 0
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

__$skill_dot_全大赦__() {
  if !($level >= 70) {
    return
  }
  if !(A_TickCount - $ts.全大赦 > $cd.全大赦) {
    return
  }
  if !(能力技冷却判断()) {
    return
  }
  Send {ctrl down}{8}{ctrl up}
  $ts.全大赦 := A_TickCount - $cd.全大赦 + $cd.技能施放补正
  SetTimer __$watcher_dot_全大赦__, % $cd.技能施放判断间隔
  return true
}

__$watcher_dot_全大赦__() {
  clearWatcher("全大赦")
}

__$skill_dot_再生__() {
  if !($level >= 35) {
    return
  }
  if !(A_TickCount - $ts.再生 > $cd.再生) {
    return
  }
  if (hasStatusByTarget("再生")) {
    return
  }
  Send {alt down}{0}{alt up}
  $ts.再生 := A_TickCount - $cd.再生 + $cd.技能施放补正
  return true
}

__$skill_dot_医治__() {
  Send {alt down}{4}{alt up}
  return true
}

__$skill_dot_医济__() {
  if !($level >= 50) {
    return
  }
  if !(A_TickCount - $ts.医济 > $cd.医济) {
    return
  }
  Send {alt down}{8}{alt up}
  SetTimer __$watcher_dot_医济__, % $cd.技能施放判断间隔
  return true
}

__$watcher_dot_医济__() {
  clearWatcher("医济")
}

__$skill_dot_即刻咏唱__() {
  if !(A_TickCount - $ts.即刻咏唱 > $cd.即刻咏唱) {
    return
  }
  Send {shift down}{3}{shift up}
  $ts.即刻咏唱 := A_TickCount - $cd.即刻咏唱 + $cd.技能施放补正
  SetTimer __$watcher_dot_即刻咏唱__, % $cd.技能施放判断间隔
  return true
}

__$watcher_dot_即刻咏唱__() {
  clearWatcher("即刻咏唱", "status")
}

__$skill_dot_复活__() {
  Send {alt down}{5}{alt up}
}

__$skill_dot_天赐祝福__() {
  if !($level >= 50) {
    return
  }
  Send {ctrl down}{1}{ctrl up}
  return true
}

__$skill_dot_安慰之心__() {
  if !($level >= 52) {
    return
  }
  if !($white >= 1) {
    return
  }
  if !(能力技冷却判断()) {
    return
  }
  Send {ctrl down}{2}{ctrl up}
  return true
}

__$skill_dot_庇护所__() {
  if !($level >= 52) {
    return
  }
  Send {ctrl down}{3}{ctrl up}
  return true
}

__$skill_dot_康复__() {
  Send {shift down}{2}{shift up}
}

__$skill_dot_愈疗__() {
  if !($level >= 40) {
    return
  }
  Send {alt down}{-}{alt up}
  return true
}

__$skill_dot_报告__() {
  if !($isReporting) {
    return
  }
  msg := "等级：" . $level . " / 魔力：" . $mp . "%"
  msg := "" . msg . "`n白：" . $white . " / 红：" . $red . ""
  msg := "" . msg . "`n咏唱：" . $isChanting . " / 移动：" . $isMoving . ""
  msg := "" . msg . "`n耗时：" . A_TickCount - $ts.报告 . "ms`n"
  $ts.报告 := A_TickCount
  msg := makeReportMsg(msg, ["神速咏唱", "法令", "无中生有", "神名", "全大赦", "即刻咏唱", "醒梦"])
  ToolTip % msg, 410, 640
  SetTimer clearTip, Off
  SetTimer clearTip, % 0 - 10000
}

__$skill_dot_救疗__() {
  if !($level >= 30) {
    return
  }
  Send {alt down}{7}{alt up}
  return true
}

__$skill_dot_无中生有__() {
  if !($level >= 58) {
    return
  }
  if !(A_TickCount - $ts.无中生有 > $cd.无中生有) {
    return
  }
  Send {ctrl down}{5}{ctrl up}
  $ts.无中生有 := A_TickCount - $cd.无中生有 + $cd.技能施放补正
  SetTimer __$watcher_dot_无中生有__, % $cd.技能施放判断间隔
  return true
}

__$watcher_dot_无中生有__() {
  clearWatcher("无中生有", "status")
}

__$skill_dot_治疗__() {
  Send {alt down}{2}{alt up}
  return true
}

__$skill_dot_法令__() {
  if !($level >= 56) {
    return
  }
  if !(A_TickCount - $ts.法令 > $cd.法令) {
    return
  }
  Send {ctrl down}{4}{ctrl up}
  $ts.法令 := A_TickCount - $cd.法令 + $cd.技能施放补正
  SetTimer __$watcher_dot_法令__, % $cd.技能施放判断间隔
  return true
}

__$watcher_dot_法令__() {
  clearWatcher("法令")
}

__$skill_dot_狂喜之心__() {
  if !($level >= 76) {
    return
  }
  if !($white >= 1) {
    return
  }
  if !(能力技冷却判断()) {
    return
  }
  Send {ctrl down}{0}{ctrl up}
  return true
}

__$skill_dot_疾风__(isForced := false) {
  if !(isForced) {
    if ($level >= 72) {
      if (hasStatusByTarget("天辉")) {
        return
      }
    }
    else if ($level >= 46) {
      if (hasStatusByTarget("烈风")) {
        return
      }
    }
    else {
      if (hasStatusByTarget("疾风")) {
        return
      }
    }
  }
  Send {alt down}{3}{alt up}
  return true
}

__$skill_dot_神名__() {
  if !($level >= 60) {
    return
  }
  if !(A_TickCount - $ts.神名 > $cd.神名) {
    return
  }
  if !(能力技冷却判断()) {
    return
  }
  Send {ctrl down}{6}{ctrl up}
  $ts.神名 := A_TickCount - $cd.神名 + $cd.技能施放补正
  SetTimer __$watcher_dot_神名__, % $cd.技能施放判断间隔
  return true
}

__$watcher_dot_神名__() {
  clearWatcher("神名")
}

__$skill_dot_神圣__() {
  if !($level >= 45) {
    return
  }
  Send {alt down}{=}{alt up}
  return true
}

__$skill_dot_神祝祷__() {
  if !($level >= 66) {
    return
  }
  Send {ctrl down}{7}{ctrl up}
  return true
}

__$skill_dot_神速咏唱__() {
  if !($level >= 30) {
    return
  }
  if !(A_TickCount - $ts.神速咏唱 > $cd.神速咏唱) {
    return
  }
  Send {alt down}{9}{alt up}
  $ts.神速咏唱 := A_TickCount - $cd.神速咏唱 + $cd.技能施放补正
  SetTimer __$watcher_dot_神速咏唱__, % $cd.技能施放判断间隔
  return true
}

__$watcher_dot_神速咏唱__() {
  clearWatcher("神速咏唱", "status")
}

能力技冷却判断() {
  if !(A_TickCount - $ts.能力技 > $cd.能力技) {
    return
  }
  $ts.能力技 := A_TickCount
  return true
}

__$skill_dot_苦难之心__() {
  if !($level >= 74) {
    return
  }
  if !($red >= 3) {
    return
  }
  Send {ctrl down}{9}{ctrl up}
  return true
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
  checkRed()
  checkWhite()
}

__$skill_dot_醒梦__() {
  if !(A_TickCount - $ts.醒梦 > $cd.醒梦) {
    return
  }
  checkMp()
  if ($mp > 50) {
    return
  }
  Send {shift down}{4}{shift up}
  $ts.醒梦 := A_TickCount - $cd.醒梦 + $cd.技能施放补正
  SetTimer __$watcher_dot_醒梦__, % $cd.技能施放判断间隔
  return true
}

__$watcher_dot_醒梦__() {
  clearWatcher("醒梦", "status")
}

__$skill_dot_飞石__() {
  Send {alt down}{1}{alt up}
}

attackS() {
  if ($isChanting) {
    return
  }
  use("醒梦")
  use("法令")
  use("苦难之心")
  use("神速咏唱")
  if ($isMoving) {
    use("疾风", true)
    return
  }
  if (use("疾风")) {
    return
  }
  if (use("飞石")) {
    return
  }
  SoundBeep
}

attackM() {
  if ($isChanting) {
    return
  }
  use("醒梦")
  use("法令")
  use("苦难之心")
  use("神速咏唱")
  use("无中生有")
  use("即刻咏唱")
  if ($isMoving) {
    use("疾风", true)
    return
  }
  if (use("神圣")) {
    return
  }
  SoundBeep
}

healS() {
  if ($isChanting) {
    return
  }
  use("醒梦")
  if (use("法令")) {
    return
  }
  if (use("神名")) {
    return
  }
  if (use("安慰之心")) {
    return
  }
  if (use("再生")) {
    return
  }
  if (use("救疗")) {
    return
  }
  if (use("治疗")) {
    return
  }
  SoundBeep
}

healM() {
  if ($isChanting) {
    return
  }
  use("醒梦")
  if (use("法令")) {
    return
  }
  if (use("全大赦")) {
    return
  }
  if (use("狂喜之心")) {
    return
  }
  if (use("医济")) {
    return
  }
  if (use("愈疗")) {
    return
  }
  if (use("医治")) {
    return
  }
  SoundBeep
}

__$default__() {
  $cd.技能施放判断间隔 := 100
  $cd.技能施放补正 := 1500
  $skill.中断咏唱 := Func("__$skill_dot_中断咏唱__")
  $skill.冲刺 := Func("__$skill_dot_冲刺__")
  $skill.空白信息 := Func("__$skill_dot_空白信息__")
  $skill.索敌 := Func("__$skill_dot_索敌__")
  $ts.全大赦 := 0
  $cd.全大赦 := 60000
  $skill.全大赦 := Func("__$skill_dot_全大赦__")
  $watcher.全大赦 := Func("__$watcher_dot_全大赦__")
  $ts.再生 := 0
  $cd.再生 := 2500
  $skill.再生 := Func("__$skill_dot_再生__")
  $skill.医治 := Func("__$skill_dot_医治__")
  $ts.医济 := 0
  $cd.医济 := 15000
  $skill.医济 := Func("__$skill_dot_医济__")
  $watcher.医济 := Func("__$watcher_dot_医济__")
  $ts.即刻咏唱 := 0
  $cd.即刻咏唱 := 60000
  $skill.即刻咏唱 := Func("__$skill_dot_即刻咏唱__")
  $watcher.即刻咏唱 := Func("__$watcher_dot_即刻咏唱__")
  $skill.复活 := Func("__$skill_dot_复活__")
  $skill.天赐祝福 := Func("__$skill_dot_天赐祝福__")
  $skill.安慰之心 := Func("__$skill_dot_安慰之心__")
  $skill.庇护所 := Func("__$skill_dot_庇护所__")
  $skill.康复 := Func("__$skill_dot_康复__")
  $skill.愈疗 := Func("__$skill_dot_愈疗__")
  $ts.报告 := 0
  $skill.报告 := Func("__$skill_dot_报告__")
  $skill.救疗 := Func("__$skill_dot_救疗__")
  $ts.无中生有 := 0
  $cd.无中生有 := 120000
  $skill.无中生有 := Func("__$skill_dot_无中生有__")
  $watcher.无中生有 := Func("__$watcher_dot_无中生有__")
  $skill.治疗 := Func("__$skill_dot_治疗__")
  $ts.法令 := 0
  $cd.法令 := 45000
  $skill.法令 := Func("__$skill_dot_法令__")
  $watcher.法令 := Func("__$watcher_dot_法令__")
  $skill.狂喜之心 := Func("__$skill_dot_狂喜之心__")
  $skill.疾风 := Func("__$skill_dot_疾风__")
  $ts.神名 := 0
  $cd.神名 := 60000
  $skill.神名 := Func("__$skill_dot_神名__")
  $watcher.神名 := Func("__$watcher_dot_神名__")
  $skill.神圣 := Func("__$skill_dot_神圣__")
  $skill.神祝祷 := Func("__$skill_dot_神祝祷__")
  $ts.神速咏唱 := 0
  $cd.神速咏唱 := 150000
  $skill.神速咏唱 := Func("__$skill_dot_神速咏唱__")
  $watcher.神速咏唱 := Func("__$watcher_dot_神速咏唱__")
  $ts.能力技 := 0
  $cd.能力技 := 300
  $skill.苦难之心 := Func("__$skill_dot_苦难之心__")
  $ts.获取状态 := 0
  $skill.获取状态 := Func("__$skill_dot_获取状态__")
  $ts.醒梦 := 0
  $cd.醒梦 := 60000
  $skill.醒梦 := Func("__$skill_dot_醒梦__")
  $watcher.醒梦 := Func("__$watcher_dot_醒梦__")
  $skill.飞石 := Func("__$skill_dot_飞石__")
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
    healM()
    return
  }
return

2joy1::
  trigger := getCurrentTrigger()
  if !(trigger) {
    return
  }
  use("获取状态")
  use("报告")
  if (trigger == "right") {
    use("神祝祷")
    return
  }
  if (trigger == "both") {
    use("康复")
    return
  }
  if (trigger == "left") {
    use("即刻咏唱")
    use("无中生有")
    use("复活")
    return
  }
return

2joy3::
  trigger := getCurrentTrigger()
  if !(trigger) {
    return
  }
  use("获取状态")
  use("报告")
  if (trigger == "right") {
    use("庇护所")
    return
  }
return

; eof