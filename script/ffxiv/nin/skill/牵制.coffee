$ts.牵制 = 0
$cd.牵制 = 90e3

$skill.牵制 = ->

  unless A_TickCount - $ts.牵制 > $cd.牵制
    return

  $.press 'shift + 5'

  setInterval $watcher.牵制, $cd.技能施放判断间隔
  return true

$watcher.牵制 = -> clearWatcher '牵制'