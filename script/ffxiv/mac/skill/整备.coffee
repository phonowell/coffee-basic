$ts.整备 = 0
$cd.整备 = 55e3

$skill.整备 = ->

  unless $step == 2
    return

  unless A_TickCount - $ts.整备 > $cd.整备
    return

  $.press 'alt + 4'

  setInterval $watcher.整备, $cd.技能施放判断间隔
  return true

$watcher.整备 = -> clearWatcher '整备', 'status'