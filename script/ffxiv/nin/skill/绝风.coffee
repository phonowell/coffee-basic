$ts.绝风 = 0
$cd.绝风 = 2500

$skill.绝风 = ->

  unless $step == 1
    return

  unless A_TickCount - $ts.绝风 > $cd.绝风
    return

  $.press 'alt + 3'

  setInterval $watcher.绝风, $cd.技能施放判断间隔
  return true

$watcher.绝风 = ->
  unless clearWatcher '绝风'
    return
  
  unless $level >= 26
    $step = 0
    clearTimeout resetStep
    return
  
  $step = 2

  clearTimeout resetStep
  setTimeout resetStep, 15e3