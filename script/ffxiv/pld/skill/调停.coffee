$ts.调停 = 0
$cd.调停 = 30e3

$skill.调停 = ->

  unless $level >= 74
    return

  unless $ap == 1
    return

  unless A_TickCount - $ts.调停 > $cd.调停
    return

  $.press 'alt + equal'

  setInterval $watcher.调停, $cd.技能施放判断间隔
  return true

$watcher.调停 = -> clearWatcher '调停'