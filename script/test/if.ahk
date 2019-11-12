; transpiled by coffee-basic

#NoEnv
#Persistent
#SingleInstance Force
#UseHook

CoordMode Mouse, Client
CoordMode Pixel, Client
SendMode Event
SetKeyDelay 0, 50
SetMouseDelay 0, 50

if (a > 1) {
  a
}

if (a >= 1) {
  fn 1
} else {
  fn 2
}

if (a >= 2) {
  fn 3
} else if (a >= 4) {
  fn 4
} else {
  fn 5
}

if (a > 1) {
  if (b > a) {
    if (c == 5) {
      fn 2
    }
  } else if (c == 6) {
    fn 1
  }
} else {
  fn 0
}