; transpiled by coffee-basic

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

; global

global isViewFar := false

; function

飞石() {
  Send {alt down}{1}{alt up}
}

治疗() {
  Send {alt down}{2}{alt up}
}

疾风() {
  if (isMoving()) {
    Send {alt down}{3}{alt up}
    return true
  }
  if (hasStatusTarget("天辉")) {
    return false
  }
  if (hasStatusTarget("烈风")) {
    return false
  }
  if (hasStatusTarget("疾风")) {
    return false
  }
  Send {alt down}{3}{alt up}
  return true
}

医治() {
  Send {alt down}{4}{alt up}
}

复活() {
  即刻咏唱()
  无中生有()
  Send {alt down}{5}{alt up}
  return true
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
  Send {alt down}{9}{alt up}
}

再生() {
  if (hasStatusTarget("再生")) {
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
  Send {ctrl down}{2}{ctrl up}
}

庇护所() {
  Send {ctrl down}{3}{ctrl up}
}

法令() {
  Send {ctrl down}{4}{ctrl up}
}

无中生有() {
  Send {ctrl down}{5}{ctrl up}
}

神名() {
  Send {ctrl down}{6}{ctrl up}
}

神祝祷() {
  Send {ctrl down}{7}{ctrl up}
}

全大赦() {
  Send {ctrl down}{8}{ctrl up}
}

苦难之心() {
  Send {ctrl down}{9}{ctrl up}
}

狂喜之心() {
  Send {ctrl down}{0}{ctrl up}
}

节制() {
  Send {ctrl down}{-}{ctrl up}
}

沉静() {
  Send {ctrl down}{=}{ctrl up}
}

康复() {
  Send {shift down}{1}{shift up}
}

即刻咏唱() {
  Send {shift down}{2}{shift up}
}

醒梦() {
  PixelGetColor color, 260, 35, RGB
  if !(color == 0x56463C) {
    return false
  }
  Send {shift down}{3}{shift up}
  return true
}

沉稳咏唱() {
  Send {shift down}{4}{shift up}
}

营救() {
  Send {shift down}{5}{shift up}
}

索敌() {
  Send {shift down}{6}{shift up}
}

delay(name, time := 300, n := 1) {
  loop %n% {
    if !(n == 1) {
      Sleep % "" . time . ""
    }
    SetTimer %name%, Off
    SetTimer %name%, % 0 - time
  }
}

getGroup() {
  isLT := false
  isRT := false
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
  return "none"
}

hasStatus(name) {
  ImageSearch x, y, 725, 840, 925, 875, % A_ScriptDir . "\" . name . ".png"
  if (x > 0 and y > 0) {
    return true
  }
  return false
}

hasStatusTarget(name) {
  ImageSearch x, y, 725, 765, 925, 800, % A_ScriptDir . "\" . name . ".png"
  if (x > 0 and y > 0) {
    return true
  }
  return false
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

toggleView() {
  if (isViewFar == false) {
    Send {ctrl down}{up down}{pgdn down}
    Sleep % "" . 3000 . ""
    Send {ctrl up}{up up}{pgdn up}
    isViewFar := true
  }
  else {
    Send {ctrl down}{down down}{pgup down}
    Sleep % "" . 3000 . ""
    Send {ctrl up}{down up}{pgup up}
    isViewFar := false
  }
  SoundBeep
}

; bind

f12::
  SoundBeep
  ExitApp
return

f8::
  MouseGetPos x, y
  PixelGetColor color, x, y, RGB
  ToolTip % "" . x . ", " . y . ", " . color . ""
return

f2::
  toggleView()
return

2joy4::
  group := getGroup()
  if (group == "none") {
    return
  }
  if (group == "right") {
    索敌()
    醒梦()
    苦难之心()
    法令()
    神速咏唱()
    if (疾风()) {
      return
    }
    飞石()
    return
  }
  if (group == "both") {
    索敌()
    醒梦()
    苦难之心()
    法令()
    神速咏唱()
    无中生有()
    即刻咏唱()
    神圣()
    return
  }
return

2joy2::
  group := getGroup()
  if (group == "none") {
    return
  }
  if (group == "right") {
    醒梦()
    神名()
    法令()
    安慰之心()
    神速咏唱()
    再生()
    救疗()
    治疗()
    return
  }
  if (group == "both") {
    醒梦()
    法令()
    全大赦()
    狂喜之心()
    神速咏唱()
    医济()
    医治()
    return
  }
return

2joy1::
  group := getGroup()
  if (group == "none") {
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
    复活()
    return
  }
return

2joy3::
  group := getGroup()
  if (group == "none") {
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

; eof