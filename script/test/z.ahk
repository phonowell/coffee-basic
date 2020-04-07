; global variable

global $cd := {}
global $ts := {}
global $isChanting := false
global $hp := 0
global $isMoving := false
global $mp := 0
global $isTargeting := false
global $level := 80
global $skill := {}
global $watcher := {}
global d := {}

; function

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
  return
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
  return
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
  $mp := precent
  return
}

checkTargeting() {
  PixelGetColor color, 650, 65, RGB
  if (color == 0xFF8888) {
    $hasTarget := true
    return
  }
  if (color == 0xFFC888) {
    $hasTarget := true
    return
  }
  if (color == 0xEBD788) {
    $hasTarget := true
    return
  }
  if (color == 0xFFB1FF) {
    $hasTarget := true
    return
  }
  $hasTarget := false
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

makeReportMsg(msg, name) {
  result := calcCd(name)
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

__d_dot_display__() {
  if !(d.value == 0) {
    return
  }
  if !(d.value > 1) {
    d.value := 1
  }
  if (d.value == -1) {
    d.value := -2
  }
  else {
    d.value := 0
  }
  MsgBox % d.value
}

__$default__() {
  d.value := 2
  d.display := Func("__d_dot_display__")
}

; default
__$default__()

; event

f1::
  fn()
return