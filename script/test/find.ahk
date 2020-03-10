; function

__$default__() {
  PixelSearch x, y, 0, 0, A_ScreenWidth, A_ScreenHeight, 0xFFFFFF, 0, Fast RGB
  ImageSearch x, y, 0, 0, A_ScreenWidth, A_ScreenHeight, % A_ScriptDir . "\" . "white.png"
  PixelSearch x, y, 0, 0, A_ScreenWidth, A_ScreenHeight, color, 0, Fast RGB
  ImageSearch x, y, 0, 0, A_ScreenWidth, A_ScreenHeight, % A_ScriptDir . "\" . path . ".png"
}

; default
__$default__()