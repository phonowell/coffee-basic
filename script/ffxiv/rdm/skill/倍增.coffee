$ts.倍增 = 0
$cd.倍增 = 110e3

$skill.倍增 = ->

  unless $level >= 60
    return false

  unless A_TickCount - $ts.倍增 > $cd.倍增
    return false

  if A_TickCount - $ts.回刺 < $cd.comboZ
    return false

  unless $black >= 40 and $black <= 70
    return false

  unless $white >= 40 and $white <= 70
    return false

  $.press 'ctrl + 8'
  
  $ts.倍增 = A_TickCount - $cd.倍增 + $cd.技能施放补正
  $.setInterval $watcher.倍增, $cd.技能施放判断间隔
  return true

$watcher.倍增 = ->
  clearWatcher '倍增'
  $ts.短兵相接 = 0
  $ts.移转 = 0
  $ts.交剑 = 0