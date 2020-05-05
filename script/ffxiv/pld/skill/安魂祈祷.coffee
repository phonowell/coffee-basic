$ts.安魂祈祷 = 0
$cd.安魂祈祷 = 60e3

$skill.安魂祈祷 = ->

  unless $level >= 68
    return

  unless $isTargeting
    return

  unless $mp > 80
    return

  unless $step == 0
    return

  unless A_TickCount - $ts.安魂祈祷 > $cd.安魂祈祷
    return

  $.press 'ctrl + 9'

  setInterval $watcher.安魂祈祷, $cd.技能施放判断间隔
  return true

$watcher.安魂祈祷 = -> clearWatcher '安魂祈祷', 'status'