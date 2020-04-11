$ts.残影 = 0
$cd.残影 = 120e3

$skill.残影 = ->

  unless A_TickCount - $ts.残影 > $cd.残影
    return

  $.press 'alt + 2'

  setInterval $watcher.残影, $cd.技能施放判断间隔
  return true

$watcher.残影 = -> clearWatcher '残影', 'status'