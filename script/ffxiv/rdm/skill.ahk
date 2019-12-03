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

; global

global 回刺时间戳 := 0
global 回刺冷却 := 10000
global 短兵相接时间戳 := 0
global 短兵相接冷却 := 40000
global 交击斩时间戳 := 0
global 交击斩冷却 := 10000
global 飞刺时间戳 := 0
global 飞刺冷却 := 25000
global 连攻时间戳 := 0
global 连攻冷却 := 10000
global 促进时间戳 := 0
global 促进冷却 := 35000
global 划圆斩时间戳 := 0
global 六分反击时间戳 := 0
global 六分反击冷却 := 35000
global 鼓励时间戳 := 0
global 鼓励冷却 := 120000
global 倍增时间戳 := 0
global 倍增冷却 := 110000
global 交剑时间戳 := 0
global 交剑冷却 := 35000
global 即刻咏唱时间戳 := 0
global 即刻咏唱冷却 := 60000
global 醒梦时间戳 := 0
global 醒梦冷却 := 60000
global 索敌时间戳 := 0
global 索敌冷却 := 3000
global asr := 0
global 赤神圣时间戳 := 0
global 赤神圣冷却 := 10000
global black := 0
global white := 0

; function

回刺() {
  if !(A_TickCount - 回刺时间戳 > 回刺冷却) {
    return false
  }
  if !(black >= 80 and white >= 80) {
    return false
  }
  Send {alt down}{1}{alt up}
  return true
}

监听回刺() {
  if !(A_TickCount - 回刺时间戳 > 回刺冷却) {
    return
  }
  if !(isChanted("魔回刺")) {
    return
  }
  回刺时间戳 := A_TickCount - 2000
}

摇荡() {
  Send {alt down}{2}{alt up}
}

赤闪雷() {
  Send {alt down}{3}{alt up}
}

短兵相接() {
  if !(asr > 0) {
    return false
  }
  if !(A_TickCount - 短兵相接时间戳 > 短兵相接冷却) {
    return false
  }
  Send {alt down}{4}{alt up}
  asr--
  return true
}

监听短兵相接() {
  if !(A_TickCount - 短兵相接时间戳 > 短兵相接冷却) {
    return
  }
  if !(isChanted("短兵相接")) {
    return
  }
  短兵相接时间戳 := A_TickCount - 2000
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
  if !(A_TickCount - 交击斩时间戳 > 交击斩冷却) {
    return false
  }
  if !(A_TickCount - 回刺时间戳 < 15000) {
    return false
  }
  if !(black >= 50 and white >= 50) {
    return false
  }
  Send {alt down}{-}{alt up}
  return true
}

监听交击斩() {
  if !(A_TickCount - 交击斩时间戳 > 交击斩冷却) {
    return
  }
  if !(isChanted("魔交击斩")) {
    return
  }
  交击斩时间戳 := A_TickCount - 2000
}

移转() {
  Send {alt down}{=}{alt up}
}

飞刺() {
  if !(asr > 0) {
    return
  }
  if !(A_TickCount - 飞刺时间戳 > 飞刺冷却) {
    return false
  }
  Send {ctrl down}{1}{ctrl up}
  asr--
  return true
}

监听飞刺() {
  if !(A_TickCount - 飞刺时间戳 > 飞刺冷却) {
    return
  }
  if !(isChanted("飞刺")) {
    return
  }
  飞刺时间戳 := A_TickCount - 2000
}

连攻() {
  if !(A_TickCount - 连攻时间戳 > 连攻冷却) {
    return false
  }
  if !(A_TickCount - 交击斩时间戳 < 15000) {
    return false
  }
  if !(black >= 25 and white >= 25) {
    return false
  }
  Send {ctrl down}{2}{ctrl up}
  return true
}

监听连攻() {
  if !(A_TickCount - 连攻时间戳 > 连攻冷却) {
    return
  }
  if !(isChanted("魔连攻")) {
    return
  }
  连攻时间戳 := A_TickCount - 2000
}

促进() {
  if !(asr > 0) {
    return
  }
  if !(A_TickCount - 促进时间戳 > 促进冷却) {
    return false
  }
  if (black > 80 or white > 80) {
    return false
  }
  isBR := hasStatus("赤火炎预备")
  isWR := hasStatus("赤飞石预备")
  if (isBR and isWR) {
    return false
  }
  Send {ctrl down}{3}{ctrl up}
  asr--
  return true
}

监听促进() {
  if !(A_TickCount - 促进时间戳 > 促进冷却) {
    return
  }
  if !(isChanted("促进2")) {
    return
  }
  促进时间戳 := A_TickCount - 2000
}

划圆斩() {
  if !(black >= 20 and white >= 20) {
    return false
  }
  Send {ctrl down}{4}{ctrl up}
  if !(isChanted("魔划圆斩")) {
    return false
  }
  划圆斩时间戳 := A_TickCount - 2000
  return true
}

赤治疗() {
  Send {ctrl down}{5}{ctrl up}
}

六分反击() {
  if !(asr > 0) {
    return
  }
  if !(A_TickCount - 六分反击时间戳 > 六分反击冷却) {
    return false
  }
  Send {ctrl down}{6}{ctrl up}
  asr--
  return true
}

监听六分反击() {
  if !(A_TickCount - 六分反击时间戳 > 六分反击冷却) {
    return
  }
  if !(isChanted("六分反击")) {
    return
  }
  六分反击时间戳 := A_TickCount - 2000
}

鼓励() {
  if !(asr > 0) {
    return
  }
  if !(A_TickCount - 鼓励时间戳 > 鼓励冷却) {
    return false
  }
  Send {ctrl down}{7}{ctrl up}
  asr--
  return true
}

监听鼓励() {
  if !(A_TickCount - 鼓励时间戳 > 鼓励冷却) {
    return
  }
  if !(isChanted("鼓励")) {
    return
  }
  鼓励时间戳 := A_TickCount - 2000
}

倍增() {
  if !(asr > 0) {
    return
  }
  if !(white >= 40 and white < 70) {
    return false
  }
  if !(black >= 40 and black < 70) {
    return false
  }
  Send {ctrl down}{8}{ctrl up}
  asr--
  return true
}

监听倍增() {
  if !(A_TickCount - 倍增时间戳 > 倍增冷却) {
    return
  }
  if !(isChanted("倍增")) {
    return
  }
  倍增时间戳 := A_TickCount - 2000
  短兵相接时间戳 := 0
  交剑时间戳 := 0
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
  if !(asr > 0) {
    return
  }
  if !(A_TickCount - 交剑时间戳 > 交剑冷却) {
    return false
  }
  Send {ctrl down}{=}{ctrl up}
  asr--
  return true
}

监听交剑() {
  if !(A_TickCount - 交剑时间戳 > 交剑冷却) {
    return
  }
  if !(isChanted("交剑")) {
    return
  }
  交剑时间戳 := A_TickCount - 2000
}

续斩() {
  Send {shift down}{1}{shift up}
}

昏乱() {
  Send {shift down}{2}{shift up}
}

即刻咏唱() {
  if !(asr > 0) {
    return
  }
  if !(A_TickCount - 即刻咏唱时间戳 > 即刻咏唱冷却) {
    return false
  }
  if (black > 60 or white > 60) {
    return false
  }
  if (hasStatus("连续咏唱")) {
    return false
  }
  isBR := hasStatus("赤火炎预备")
  isWR := hasStatus("赤飞石预备")
  if (isBR and isWR) {
    return
  }
  Send {shift down}{3}{shift up}
  asr--
  return true
}

监听即刻咏唱() {
  if !(A_TickCount - 即刻咏唱时间戳 > 即刻咏唱冷却) {
    return
  }
  if !(isChanted("即刻咏唱2")) {
    return
  }
  即刻咏唱时间戳 := A_TickCount - 2000
}

醒梦() {
  if !(asr > 0) {
    return
  }
  if !(A_TickCount - 醒梦时间戳 > 醒梦冷却) {
    return false
  }
  if (mp > 65) {
    return false
  }
  Send {shift down}{4}{shift up}
  asr--
  return true
}

监听醒梦() {
  if !(A_TickCount - 醒梦时间戳 > 醒梦冷却) {
    return
  }
  if !(isChanted("醒梦")) {
    return
  }
  醒梦时间戳 := A_TickCount - 2000
}

沉稳咏唱() {
  Send {shift down}{5}{shift up}
}

索敌() {
  if !(A_TickCount - 索敌时间戳 > 索敌冷却) {
    return false
  }
  Send {shift down}{-}{shift up}
  索敌时间戳 := A_TickCount - 2000
  return true
}

清空信息() {
  Send {shift down}{=}{shift up}
}

能力技() {
  if !(asr > 0) {
    return false
  }
  if (飞刺()) {
    return true
  }
  if (六分反击()) {
    return true
  }
  if (交剑()) {
    return true
  }
  if (醒梦()) {
    return true
  }
}

赤神圣() {
  if !(A_TickCount - 赤神圣时间戳 > 赤神圣冷却) {
    return false
  }
  if !(A_TickCount - 连攻时间戳 < 15000) {
    return false
  }
  if (black - white > 9) {
    赤疾风()
    return true
  }
  if (white - black > 9) {
    赤闪雷()
    return true
  }
  isBR := hasStatus("赤火炎预备")
  isWR := hasStatus("赤飞石预备")
  if (isBR and isWR) {
    if (black > white) {
      赤疾风()
    }
    else {
      赤闪雷()
    }
    return true
  }
  if (isBR) {
    赤疾风()
    return true
  }
  if (isWR) {
    赤闪雷()
    return true
  }
  if (black > white) {
    赤疾风()
  }
  else {
    赤闪雷()
  }
  return true
}

监听赤神圣() {
  if !(A_TickCount - 赤神圣时间戳 > 赤神圣冷却) {
    return
  }
  isBR := isChanted("赤核爆")
  isWR := isChanted("赤神圣")
  if !(isBR or isWR) {
    return
  }
  赤神圣时间戳 := A_TickCount - 2000
}

焦热() {
  if !(A_TickCount - 赤神圣时间戳 < 15000) {
    return false
  }
  摇荡()
  回刺时间戳 := 0
  交击斩时间戳 := 0
  连攻时间戳 := 0
  赤神圣时间戳 := 0
  SoundBeep
  return true
}

监听() {
  mp := getMp()
  black := getBlack()
  white := getWhite()
  监听回刺()
  监听短兵相接()
  监听交击斩()
  监听飞刺()
  监听连攻()
  监听促进()
  监听六分反击()
  监听鼓励()
  监听倍增()
  监听交剑()
  监听即刻咏唱()
  监听醒梦()
  监听赤神圣()
  report()
}

default() {
  SetTimer 清空信息, % 0 - 3000
  SetTimer 监听, 200
}

; default
default()

; eof