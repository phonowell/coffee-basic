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

SoundBeep

BlockInput

Click 20, 20

ExitApp

MouseMove 0, 120, 50

Run notepad

SoundPlay ahk.mp4

Sleep 20

Trim string
RTrim string
LTrim string