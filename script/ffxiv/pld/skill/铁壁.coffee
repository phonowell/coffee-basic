$ts.铁壁 = 0
$cd.铁壁 = 90e3

$skill.铁壁 = ->

  unless A_TickCount - $ts.铁壁 > $cd.铁壁
    return

  $.press 'shift + 1'

  setInterval $watcher.铁壁, $cd.技能施放判断间隔
  return true

$watcher.铁壁 = -> clearWatcher '铁壁', 'status'