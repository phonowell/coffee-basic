$ts.扫腿 = 0
$cd.扫腿 = 40e3

$skill.扫腿 = ->

  unless A_TickCount - $ts.扫腿 > $cd.扫腿
    return

  $.press 'shift + 3'

  setInterval $watcher.扫腿, $cd.技能施放判断间隔
  return true

$watcher.扫腿 = -> clearWatcher '扫腿'