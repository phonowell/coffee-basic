$ts.厄运流转 = 0
$cd.厄运流转 = 25e3

$skill.厄运流转 = ->

  unless $level >= 50
    return

  unless A_TickCount - $ts.厄运流转 > $cd.厄运流转
    return

  $.press 'ctrl + 0'

  setInterval $watcher.厄运流转, $cd.技能施放判断间隔
  return true

$watcher.厄运流转 = -> clearWatcher '厄运流转'