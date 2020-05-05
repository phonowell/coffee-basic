$ts.弹射 = 0
$cd.弹射 = 30e3

$skill.弹射 = ->

  unless $level >= 50
    return

  unless A_TickCount - $ts.弹射 > $cd.弹射
    return

  $.press 'ctrl + 1'

  setInterval $watcher.弹射, $cd.技能施放判断间隔
  return true

$watcher.弹射 = -> clearWatcher '弹射'