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

global cacheH := ""
global cacheV := ""
global isLp := false
global isPaused := false
global isReady := false
global isRp := false

; function

bind() {
  cacheH := "-"
  cacheV := "-"
  execute()
  SetTimer execute, 200
}

clearTip() {
  ToolTip
}

execute() {
  MouseGetPos x, y
  dv := getDv(y)
  dh := getDh(x, dv)
  press(dh, dv)
}

getDh(x, dv) {
  dis := x - (A_ScreenWidth * 0.5)
  if (dv == "") {
    if (dis < 0) {
      dh := "left"
    }
    else if (dis > 0) {
      dh := "right"
    }
    else {
      dh := ""
    }
  }
  else {
    if (dis < -160) {
      dh := "left"
    }
    else if (dis > 160) {
      dh := "right"
    }
    else {
      dh := ""
      dv := "up"
    }
  }
  return dh
}

getDv(y) {
  dis := y - (A_ScreenHeight * 0.8)
  if (dis < -120) {
    dv := "up"
  }
  else if (dis > 0) {
    dv := "down"
  }
  else {
    dv := ""
  }
  return dv
}

press(dh, dv) {
  if (cacheH == dh and cacheV == dv) {
    return
  }
  cacheH := dh
  cacheV := dv
  reset()
  if (dh == "left") {
    Send {a down}
  }
  else if (dh == "right") {
    Send {d down}
  }
  if (dv == "up") {
    Send {w down}
  }
  else if (dv == "down") {
    Send {s down}
  }
}

reset() {
  Send {w up}
  Send {a up}
  Send {s up}
  Send {d up}
}

toggle() {
  if (isPaused == true) {
    ToolTip % "ON"
    isPaused := false
  }
  else {
    ToolTip % "OFF"
    isPaused := true
  }
  SetTimer clearTip, % 0 - 1000
}

unbind() {
  SetTimer execute, Off
  reset()
}

viewFar() {
  ToolTip % "wait..."
  Send {ctrl down}{up down}{pgdn down}
  Sleep % "" . 3000 . ""
  Send {ctrl up}{up up}{pgdn up}
  ToolTip % "ON"
  SetTimer clearTip, % 0 - 1000
}

default() {
  if (A_YYYY != 2019) {
    ExitApp
  }
}

; default
default()

; bind

f12::
  Click % "up"
  Click % "right up"
  reset()
  SoundBeep
  ExitApp
return

lbutton::
  isLp := true
  if (isPaused == false and isRp == true) {
    unbind()
    Click % "down"
    Click % "right down"
    return
  }
  Click % "down"
return

lbutton up::
  isLp := false
  if (isPaused == false and isRp == true) {
    Click % "up"
    Click % "right up"
    bind()
    return
  }
  Click % "up"
return

rbutton::
  if (isReady == false) {
    viewFar()
    isReady := true
    return
  }
  isRp := true
  if (isPaused == false and isLp == false) {
    bind()
    return
  }
  Click % "right down"
return

rbutton up::
  isRp := false
  if (isPaused == false and isLp == false) {
    unbind()
    return
  }
  Click % "right up"
return

mbutton::
  if (isRp == true) {
    Send {space}
    return
  }
  toggle()
return

mbutton up::
  Click % "middle up"
return

; eof