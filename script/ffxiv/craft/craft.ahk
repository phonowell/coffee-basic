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
global 制作 := []
global 加工 := []
global 精修 := []
global 内静 := []
global 新颖 := []
global 俭约 := []
global 中级加工 := []
global 阔步 := []
global 改革 := []
global 元素之美名 := []
global 元素之印记 := []
global 最终确认 := []
global 长期俭约 := []
global 收藏品制作 := []
global 比尔格的祝福 := []
global 坚信 := []
global 模范制作 := []
global 掌握 := []
global 俭约加工 := []
global 闲静 := []
global 坯料加工 := []
global 再利用 := []
global 精密制作 := []
global 工匠的神速技巧 := []

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

使用(list) {
  Send {list[0]}
  Sleep % list[1]
}

__$default__() {
  制作[0] := "alt + 1"
  制作[1] := 2500
  加工[0] := "alt + 2"
  加工[1] := 2500
  精修[0] := "alt + 3"
  精修[1] := 2500
  内静[0] := "alt + 4"
  内静[1] := 1500
  新颖[0] := "alt + 5"
  新颖[1] := 1500
  俭约[0] := "alt + 6"
  俭约[1] := 1500
  中级加工[0] := "alt + 7"
  中级加工[1] := 2500
  阔步[0] := "alt + 8"
  阔步[1] := 1500
  改革[0] := "alt + 9"
  改革[1] := 1500
  元素之美名[0] := "alt + 0"
  元素之美名[1] := 1500
  元素之印记[0] := "alt + minus"
  元素之印记[1] := 2500
  最终确认[0] := "alt + equal"
  最终确认[1] := 1500
  长期俭约[0] := "ctrl + 1"
  长期俭约[1] := 1500
  收藏品制作[0] := "ctrl + 2"
  收藏品制作[1] := 1500
  比尔格的祝福[0] := "ctrl + 3"
  比尔格的祝福[1] := 2500
  坚信[0] := "ctrl + 4"
  坚信[1] := 2500
  模范制作[0] := "ctrl + 5"
  模范制作[1] := 2500
  掌握[0] := "ctrl + 6"
  掌握[1] := 1500
  俭约加工[0] := "ctrl + 7"
  俭约加工[1] := 2500
  闲静[0] := "ctrl + 8"
  闲静[1] := 2500
  坯料加工[0] := "ctrl + 9"
  坯料加工[1] := 2500
  再利用[0] := "ctrl + 0"
  再利用[1] := 1500
  精密制作[0] := "ctrl + minus"
  精密制作[1] := 2500
  工匠的神速技巧[0] := "ctrl + equal"
  工匠的神速技巧[1] := 2500
}

; default
__$default__()

; event

f2::
  SoundBeep
  Winset AlwaysOnTop, Toggle, A
return

f5::
  resetKey()
  SoundBeep
  Reload
return

!f4::
  resetKey()
  SoundBeep
  ExitApp
return

; eof