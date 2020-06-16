$ts.预警 = 0
$cd.预警 = 120e3

$skill.预警 = ->

  unless $level >= 38
    return

  unless A_TickCount - $ts.预警 > $cd.预警
    return

  $.press 'ctrl + 9'

  setInterval $watcher.预警, $cd.技能施放判断间隔
  return true

$watcher.预警 = -> clearWatcher '预警', 'status'