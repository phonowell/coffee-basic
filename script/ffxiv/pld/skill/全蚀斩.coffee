$ts.全蚀斩 = 0
$cd.全蚀斩 = 2500

$skill.全蚀斩 = ->

  unless $step < 20
    return

  unless A_TickCount - $ts.全蚀斩 > $cd.全蚀斩
    return

  $.press 'alt + 4'

  setInterval $watcher.全蚀斩, $cd.技能施放判断间隔
  return true

$watcher.全蚀斩 = ->
  unless clearWatcher '全蚀斩'
    return

  unless $level >= 40
    $step = 0
    return

  $step = 21

  clearTimeout resetStep
  setInterval resetStep, 15e3
