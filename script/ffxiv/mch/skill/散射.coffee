$ts.散射 = 0
$cd.散射 = 2500

$skill.散射 = ->

  unless $level >= 18
    return

  unless $step < 20
    return

  unless A_TickCount - $ts.散射 > $cd.散射
    return

  $.press 'alt + 6'

  setInterval $watcher.散射, $cd.技能施放判断间隔
  return true

$watcher.散射 = ->
  unless clearWatcher '散射'
    return

  $step = 0

  clearTimeout resetStep
  # setInterval resetStep, 15e3