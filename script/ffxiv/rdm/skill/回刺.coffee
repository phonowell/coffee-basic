$ts.回刺 = 0
$cd.回刺 = 10e3

$skill.回刺 = ->

  unless A_TickCount - $ts.回刺 > $cd.回刺
    return false

  unless black >= 80 and white >= 80
    return false

  中断咏唱()

  distance = getDistance()
  unless distance == 'near'
    短兵相接 true
    return false

  $.press 'alt + 1'

  $.setInterval $watcher.回刺, $cd.技能施放判断间隔
  return true

$watcher.回刺 = -> clearWatcher '魔回刺'