$ts.浴血 = 0
$cd.浴血 = 90e3

$skill.浴血 = ->

  unless A_TickCount - $ts.浴血 > $cd.浴血
    return

  $.press 'shift + 4'

  setInterval $watcher.浴血, $cd.技能施放判断间隔
  return true

$watcher.浴血 = -> clearWatcher '浴血', 'status'