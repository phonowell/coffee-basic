$ts.先锋剑 = 0
$cd.先锋剑 = 3e3

$skill.先锋剑 = ->

  unless A_TickCount - $ts.先锋剑 > $cd.先锋剑
    return

  unless $step == 0
    return

  unless $distance == 'near'
    return

  $.press 'alt + 1'

  setInterval $watcher.先锋剑, $cd.技能施放判断间隔
  return true

$watcher.先锋剑 = ->
  unless clearWatcher '先锋剑'
    return

  $step = 1

  clearTimeout resetStep
  setTimeout resetStep, 15e3
