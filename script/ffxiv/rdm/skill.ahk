; transpiled by coffee-basic

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

; function

回刺() {
  Send {alt down}{1}{alt up}
}

摇荡() {
  Send {alt down}{2}{alt up}
}

赤闪雷() {
  Send {alt down}{3}{alt up}
}

短兵相接() {
  Send {alt down}{4}{alt up}
}

赤疾风() {
  Send {alt down}{5}{alt up}
}

散碎() {
  Send {alt down}{6}{alt up}
}

赤震雷() {
  Send {alt down}{7}{alt up}
}

赤烈风() {
  Send {alt down}{8}{alt up}
}

赤火炎() {
  Send {alt down}{9}{alt up}
}

赤飞石() {
  Send {alt down}{0}{alt up}
}

交击斩() {
  Send {alt down}{-}{alt up}
}

移转() {
  Send {alt down}{=}{alt up}
}

飞刺() {
  Send {ctrl down}{1}{ctrl up}
}

连攻() {
  Send {ctrl down}{2}{ctrl up}
}

促进() {
  Send {ctrl down}{3}{ctrl up}
}

划圆斩() {
  Send {ctrl down}{4}{ctrl up}
}

赤治疗() {
  Send {ctrl down}{5}{ctrl up}
}

六分反击() {
  Send {ctrl down}{6}{ctrl up}
}

鼓励() {
  Send {ctrl down}{7}{ctrl up}
}

倍增() {
  white := getWhite()
  if !(white >= 40 and white <= 60) {
    return false
  }
  black := getBlack()
  if !(black >= 40 and black <= 60) {
    return false
  }
  Send {ctrl down}{8}{ctrl up}
  return true
}

震荡() {
  Send {ctrl down}{9}{ctrl up}
}

赤复活() {
  Send {ctrl down}{0}{ctrl up}
}

冲击() {
  Send {ctrl down}{-}{ctrl up}
}

交剑() {
  Send {ctrl down}{=}{ctrl up}
}

续斩() {
  Send {shift down}{1}{shift up}
}

昏乱() {
  Send {shift down}{2}{shift up}
}

即刻咏唱() {
  Send {shift down}{3}{shift up}
}

醒梦() {
  PixelGetColor color, 260, 35, RGB
  if !(color == 0x56463C) {
    return false
  }
  Send {shift down}{4}{shift up}
  return true
}

沉稳咏唱() {
  Send {shift down}{5}{shift up}
}

索敌() {
  Send {shift down}{6}{shift up}
}

爆发药() {
  Send {shift down}{7}{shift up}
}

; eof