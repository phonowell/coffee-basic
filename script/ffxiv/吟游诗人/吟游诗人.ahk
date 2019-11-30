; transpiled by coffee-basic

if (A_IsAdmin != true) {
  Run *RunAs "%A_ScriptFullPath%"
  ExitApp
}

#NoEnv
#Persistent
#SingleInstance Force
#UseHook

CoordMode Mouse, Client
CoordMode Pixel, Client
CoordMode ToolTip, Client
SendMode Event
SetKeyDelay 0, 50
SetMouseDelay 0, 50

; global

global isViewFar := false

; function

强力射击() {
  Send {alt down}{1}{alt up}
}

直线射击() {
  if !(hasStatus("直线射击预备")) {
    return false
  }
  Send {alt down}{2}{alt up}
  return true
}

猛者强击() {
  if (hasStatus("猛者强击")) {
    return false
  }
  Send {alt down}{3}{alt up}
  return true
}

毒咬箭() {
  if (hasStatusTarget("毒咬箭")) {
    return false
  }
  Send {alt down}{4}{alt up}
  return true
}

失血箭() {
  Send {alt down}{5}{alt up}
}

后跃射击() {
  Send {alt down}{6}{alt up}
}

连珠箭() {
  Send {alt down}{7}{alt up}
}

风蚀箭() {
  if (hasStatusTarget("风蚀箭")) {
    return false
  }
  Send {alt down}{8}{alt up}
  return true
}

纷乱箭() {
  if !(hasStatus("猛者强击")) {
    return false
  }
  Send {alt down}{9}{alt up}
  return true
}

贤者的叙事谣() {
  if !(hasStatus("猛者强击")) {
    return false
  }
  Send {alt down}{0}{alt up}
  return true
}

光阴神的礼赞凯歌() {
  Send {alt down}{-}{alt up}
}

军神的赞美歌() {
  Send {alt down}{=}{alt up}
}

死亡箭雨() {
  Send {ctrl down}{1}{ctrl up}
}

战斗之声() {
  Send {ctrl down}{2}{ctrl up}
}

放浪神的小步舞曲() {
  Send {ctrl down}{3}{ctrl up}
}

完美音调() {
  Send {ctrl down}{4}{ctrl up}
}

九天连箭() {
  Send {ctrl down}{5}{ctrl up}
}

伶牙俐齿() {
  Send {ctrl down}{6}{ctrl up}
}

侧风诱导箭() {
  Send {ctrl down}{7}{ctrl up}
}

行吟() {
  Send {ctrl down}{8}{ctrl up}
}

大地神的抒情恋歌() {
  Send {ctrl down}{9}{ctrl up}
}

影噬箭() {
  Send {ctrl down}{0}{ctrl up}
}

绝峰箭() {
  Send {ctrl down}{-}{ctrl up}
}

伤腿() {
  Send {ctrl down}{=}{ctrl up}
}

内丹() {
  Send {shift down}{1}{shift up}
}

伤足() {
  Send {shift down}{2}{shift up}
}

速行() {
  Send {shift down}{3}{shift up}
}

伤头() {
  Send {shift down}{4}{shift up}
}

亲疏自行() {
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

能力技() {
  猛者强击()
  纷乱箭()
  贤者的叙事谣()
  失血箭()
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
    直线射击()
    毒咬箭()
    风蚀箭()
    强力射击()
    delay("能力技", 300, 2)
    return
  }
  if (group == "both") {
    索敌()
    连珠箭()
    delay("能力技", 300, 2)
    return
  }
return

; eof