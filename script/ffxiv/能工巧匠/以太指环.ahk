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

global count := 0
global limit := 20

; function

内静() {
  Send {alt down}{1}{alt up}
  Sleep % "" . 1500 . ""
}

阔步() {
  Send {alt down}{2}{alt up}
  Sleep % "" . 1500 . ""
}

稳手II() {
  Send {alt down}{3}{alt up}
  Sleep % "" . 1500 . ""
}

上级加工() {
  Send {alt down}{4}{alt up}
  Sleep % "" . 2500 . ""
}

比尔格的祝福() {
  Send {alt down}{5}{alt up}
  Sleep % "" . 2500 . ""
}

模范制作III() {
  Send {alt down}{6}{alt up}
  Sleep % "" . 2500 . ""
}

掌握II() {
  Send {alt down}{7}{alt up}
  Sleep % "" . 1500 . ""
}

俭约加工() {
  Send {alt down}{8}{alt up}
  Sleep % "" . 2500 . ""
}

坯料加工() {
  Send {alt down}{9}{alt up}
  Sleep % "" . 2500 . ""
}

再利用() {
  Send {alt down}{0}{alt up}
  Sleep % "" . 1500 . ""
}

精密制作() {
  Send {alt down}{-}{alt up}
  Sleep % "" . 2500 . ""
}

工匠的神速技巧() {
  Send {alt down}{=}{alt up}
  Sleep % "" . 2500 . ""
}

工匠的苦行() {
  Send {ctrl down}{1}{ctrl up}
  Sleep % "" . 2500 . ""
}

新颖II() {
  Send {ctrl down}{7}{ctrl up}
  Sleep % "" . 1500 . ""
}

渐进() {
  Send {ctrl down}{8}{ctrl up}
  Sleep % "" . 1500 . ""
}

改革() {
  Send {ctrl down}{9}{ctrl up}
  Sleep % "" . 1500 . ""
}

俭约II() {
  Send {ctrl down}{0}{ctrl up}
  Sleep % "" . 1500 . ""
}

安逸() {
  Send {ctrl down}{-}{ctrl up}
  Sleep % "" . 1500 . ""
}

回收() {
  Send {ctrl down}{=}{ctrl up}
  Sleep % "" . 1500 . ""
}

坚信() {
  Send {shift down}{1}{shift up}
  Sleep % "" . 2500 . ""
}

退出界面() {
  loop 4 {
    Sleep % "" . 200 . ""
    Send {numpaddot}
  }
  Sleep % "" . 200 . ""
  Sleep % "" . 1000 . ""
}

回收利用() {
  Send {alt down}{0}{alt up}
  Send {ctrl down}{=}{ctrl up}
  Sleep % "" . 1500 . ""
}

开始制作() {
  Send {shift down}{7}{shift up}
  Sleep % "" . 1000 . ""
  循环制作()
}

制作() {
  稳手II()
  坯料加工()
  坯料加工()
  回收利用()
  模范制作III()
  count++
  Sleep % "" . 2000 . ""
}

继续制作() {
  Send {numpad0}
  Sleep % "" . 500 . ""
  Send {numpad0}
  Sleep % "" . 500 . ""
  Send {numpad0}
  Sleep % "" . 1000 . ""
}

停止制作() {
  Sleep % "" . 1000 . ""
  退出界面()
}

循环制作() {
  if (count >= limit) {
    停止制作()
    修理()
    分解()
    count := 0
    开始制作()
    return
  }
  继续制作()
  制作()
  循环制作()
}

修理() {
  Send {shift down}{8}{shift up}
  Sleep % "" . 1000 . ""
  Send {numpad6}
  Sleep % "" . 500 . ""
  Send {numpad0}
  Sleep % "" . 500 . ""
  Send {numpad4}
  Sleep % "" . 500 . ""
  Send {numpad0}
  Sleep % "" . 500 . ""
  退出界面()
}

分解() {
  Send {shift down}{9}{shift up}
  Sleep % "" . 1000 . ""
  loop %count% {
    Send {numpad0}
    Sleep % "" . 500 . ""
    Send {numpad4}
    Sleep % "" . 500 . ""
    Send {numpad0}
    Sleep % "" . 3000 . ""
    Send {numpad0}
    Sleep % "" . 500 . ""
  }
  退出界面()
}

hasStatus(name) {
  ImageSearch x, y, 725, 840, 925, 875, % A_ScriptDir . "\" . name . ".png"
  if (x > 0 and y > 0) {
    return true
  }
  return false
}

; bind

f12::
  SoundBeep
  ExitApp
return

f9::
  MouseGetPos x, y
  PixelGetColor color, x, y, RGB
  ToolTip % "" . x . ", " . y . ", " . color . ""
return

f2::
  开始制作()
return

; eof