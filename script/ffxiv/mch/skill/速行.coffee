$ts.速行 = 0
$cd.速行 = 5e3

$skill.速行 = ->

  unless $isMoving
    return

  if $isTargeting
    return

  unless A_TickCount - $ts.targeting > 2500
    return

  unless A_TickCount - $ts.速行 > $cd.速行
    return

  if hasStatus '速行'
    return

  $.press 'shift + 4'

  setInterval $watcher.速行, $cd.技能施放判断间隔
  return true

$watcher.速行 = -> clearWatcher '速行', 'status'