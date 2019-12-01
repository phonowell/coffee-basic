回刺 = -> $.press 'alt + 1'
摇荡 = -> $.press 'alt + 2'
赤闪雷 = -> $.press 'alt + 3'
短兵相接 = -> $.press 'alt + 4'
赤疾风 = -> $.press 'alt + 5'
散碎 = -> $.press 'alt + 6'
赤震雷 = -> $.press 'alt + 7'
赤烈风 = -> $.press 'alt + 8'
赤火炎 = -> $.press 'alt + 9'
赤飞石 = -> $.press 'alt + 0'
交击斩 = -> $.press 'alt + minus'
移转 = -> $.press 'alt + equal'
飞刺 = -> $.press 'ctrl + 1'
连攻 = -> $.press 'ctrl + 2'
促进 = -> $.press 'ctrl + 3'
划圆斩 = -> $.press 'ctrl + 4'
赤治疗 = -> $.press 'ctrl + 5'
六分反击 = -> $.press 'ctrl + 6'
鼓励 = -> $.press 'ctrl + 7'

倍增 = ->
  white = getWhite()
  unless white >= 40 and white <= 60
    return false
  black = getBlack()
  unless black >= 40 and black <= 60
    return false
  $.press 'ctrl + 8'
  return true

震荡 = -> $.press 'ctrl + 9'
赤复活 = -> $.press 'ctrl + 0'
冲击 = -> $.press 'ctrl + minus'
交剑 = -> $.press 'ctrl + equal'
续斩 = -> $.press 'shift + 1'
昏乱 = -> $.press 'shift + 2'
即刻咏唱 = -> $.press 'shift + 3'

醒梦 = ->
  color = $.getColor 260, 35
  unless color == 0x56463C
    return false
  $.press 'shift + 4'
  return true

沉稳咏唱 = -> $.press 'shift + 5'
索敌 = -> $.press 'shift + 6'
爆发药 = -> $.press 'shift + 7'