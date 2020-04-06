$ts.插言 = 0
$cd.插言 = 30e3

$skill.插言 = ->

  unless A_TickCount - $ts.插言 > $cd.插言
    return

  $.press 'shift + 4'

  setInterval $watcher.插言, $cd.技能施放判断间隔
  return true

$watcher.插言 = -> clearWatcher '插言'