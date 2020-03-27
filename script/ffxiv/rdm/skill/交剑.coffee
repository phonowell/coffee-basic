$ts.交剑 = 0
$cd.交剑 = 35e3

$skill.交剑 = ->

  unless $level >= 72
    return false

  unless A_TickCount - $ts.交剑 > $cd.交剑
    return false

  distance = getDistance()
  unless distance == 'near'
    return false

  $.press 'ctrl + 0'
  
  $ts.交剑 = A_TickCount - $cd.交剑 + $cd.技能施放补正
  $.setInterval $watcher.交剑, $cd.技能施放判断间隔
  return true

$watcher.交剑 = -> clearWatcher '交剑'