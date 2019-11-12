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

PixelSearch x, y, 0, 0, 100, 100, 0xFFFFFF, 0, Fast RGB

if (x > 0 and y > 0) {
  Run 'Notepad'
} else {
  ExitApp
}

ImageSearch x, y, 0, 0, 100, 100, *25 'img.jpg'