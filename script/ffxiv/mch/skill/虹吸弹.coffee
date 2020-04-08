$ts.虹吸弹 = 0
$cd.虹吸弹 = 30e3

$skill.虹吸弹 = ->

  unless $level >= 15
    return

  unless A_TickCount - $ts.虹吸弹 > $cd.虹吸弹
    return

  $.press 'alt + 5'

  setInterval $watcher.虹吸弹, $cd.技能施放判断间隔
  return true

$watcher.虹吸弹 = -> clearWatcher '虹吸弹'