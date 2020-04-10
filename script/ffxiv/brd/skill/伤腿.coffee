$ts.伤腿 = 0
$cd.伤腿 = 30e3

$skill.伤腿 = ->

  unless A_TickCount - $ts.伤腿 > $cd.伤腿
    return

  $.press 'shift + 1'

  setInterval $watcher.伤腿, $cd.技能施放判断间隔
  return true

$watcher.伤腿 = -> clearWatcher '伤腿'