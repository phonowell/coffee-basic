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
global $mp := 0
global $isChanting := false
global $isMoving := false
global hasTarget := false
global $level := 80
global $skill := {}
global $watcher := {}
global count := 0
global long := 10
global time := 1

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
  if !($watcher[name]) {
    MsgBox % "invalid watcher: " . name . ""
    return
  }
  __timer__ := $watcher[name]
  SetTimer %__timer__%, Off
  $ts[name] := A_TickCount - $cd.技能施放补正
  return true
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
  return
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
  if ($isMoving) {
    return false
  }
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
  if !(result > 1) {
    return msg
  }
  return "" . msg . "`n" . name . "：" . result . "s"
}

resetKey() {
  Send {alt up}
  Send {ctrl up}
  Send {shift up}
  MouseMove 410, 640, 0
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

ask() {
  InputBox long, , % "input long(巨匠药水：35)", , , , , , , , % 10
  if !(long) {
    long := 10
  }
  InputBox time, , % "input time", , , , , , , , % 1
  if !(time) {
    time := 1
  }
  count := 0
  Sleep % 1000
  Click
}

circle() {
  if (count >= time) {
    SoundBeep
    return
  }
  count++
  restart()
  craft()
  circle()
}

craft() {
  report()
  Send {shift down}{2}{shift up}
  Sleep % long * 1000
}

execute() {
  SoundBeep
  ask()
  Sleep % 1000
  Send {shift down}{1}{shift up}
  Sleep % 1000
  circle()
}

report() {
  msg := "" . count . " / " . time . " (" . long . "s)"
  ToolTip % msg, 410, 640
}

restart() {
  Send {numpad0}
  Sleep % 500
  Send {numpad0}
  Sleep % 500
  Send {numpad0}
  Sleep % 1000
}

; event

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

f2::
  execute()
return

; eof